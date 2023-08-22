import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/blocs/favorite-bloc.dart';
import 'package:favoritos_youtube/blocs/video_bloc.dart';
import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:favoritos_youtube/screens/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/video.dart';
import '../widgets/video_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: SizedBox(
          height: 25,
          child: SvgPicture.asset("images/youtube-logo.svg"),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.black87,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
                stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                initialData: const {},
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "${snapshot.data!.length}",
                      style: const TextStyle(color: Colors.white),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const Favorites())));
              },
              icon: const Icon(Icons.star)),
          IconButton(
              onPressed: () async {
                String? result =
                    await showSearch(context: context, delegate: DataSearch());
                if (result != null)
                  BlocProvider.getBloc<VideoBloc>().inSearch.add(result);
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideoBloc>().outVideos,
        initialData: [],
        builder: ((context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data!.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data!.length) {
                  return VideoTile(video: snapshot.data![index]);
                } else if (index > 1) {
                  BlocProvider.getBloc<VideoBloc>().inSearch.add("");
                  return Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.red),
                    ),
                  );
                } else {
                  return Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Pesquise Algum Video!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                  );
                }
              });
        }),
      ),
    );
  }
}

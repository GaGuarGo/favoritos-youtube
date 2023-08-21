import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/blocs/video_bloc.dart';
import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          const Align(
            alignment: Alignment.center,
            child: Text("0"),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
          IconButton(
              onPressed: () async {
                String? result =
                    await showSearch(context: context, delegate: DataSearch());
                if (result != null) {
                  BlocProvider.getBloc<VideoBloc>().inSearch.add(result);
                }
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideoBloc>().outVideos,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(itemBuilder: (context, index) {});
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
        }),
      ),
    );
  }
}

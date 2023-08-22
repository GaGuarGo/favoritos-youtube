import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/blocs/favorite-bloc.dart';
import 'package:flutter/material.dart';

import '../models/video.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text(
          "Favoritos",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        // ignore: prefer_const_literals_to_create_immutables
        initialData: {},
        builder: (context, snapshot) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Icon(
                Icons.add_box_outlined,
                color: Colors.red,
                size: 70,
              ),
            );
          } else {
            return ListView(
              children: snapshot.data!.values.map((v) {
                return InkWell(
                  onTap: () {},
                  onLongPress: () {
                    bloc.toggleFavorite(v);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: Image.network(v.thumb),
                      ),
                      Expanded(
                          child: Text(
                        v.title,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 2,
                      ))
                    ],
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/blocs/favorite-bloc.dart';
import 'package:favoritos_youtube/blocs/video_bloc.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  const VideoTile({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      video.title,
                      maxLines: 2,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      video.channel,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )
                ],
              )),
              StreamBuilder<Map<String, Video>>(
                  stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                  initialData: const {},
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                          onPressed: () {
                            BlocProvider.getBloc<FavoriteBloc>()
                                .toggleFavorite(video);
                          },
                          iconSize: 30,
                          color: Colors.white,
                          icon: Icon(!snapshot.data!.containsKey(video.id)
                              ? Icons.star_border_outlined
                              : Icons.star));
                    } else {
                      return const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.red),
                      );
                    }
                  })
            ],
          ),
        ],
      ),
    );
  }
}

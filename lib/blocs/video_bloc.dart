// ignore_for_file: unnecessary_overrides
import 'dart:async';
import 'package:favoritos_youtube/api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/models/video.dart';

class VideoBloc extends BlocBase {
  API api = API();
  List<Video> videos = [];

  final StreamController<List<Video>> _videosController =
      StreamController<List<Video>>();
  Stream<List<Video>> get outVideos => _videosController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideoBloc() {
    api = API();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if (search.isNotEmpty) {
      _videosController.sink.add(<Video>[]);

      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }

    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    super.dispose();
    _videosController.close();
    _searchController.close();
  }
}

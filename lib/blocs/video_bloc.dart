import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_youtube_favorites/models/video.dart';

import '../api.dart';

class VideoBloc implements BlocBase {
  API _api;

  List<Video> videos;

  final _videosController = StreamController<List<Video>>();

  Stream get outVideos => _videosController.stream;

  final _searchController = StreamController<String>();

  StreamSink get inSearch => _searchController.sink;

  VideoBloc() {
    _api = API();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    print("_search");
    if (search != null) {
      videos = await _api.search(search);
    } else {
      videos += await _api.loadNextPage();
    }

    print("videos: $videos");

    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}

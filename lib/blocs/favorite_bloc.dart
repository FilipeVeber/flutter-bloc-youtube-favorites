import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_youtube_favorites/models/video.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};

  final StreamController _favoriteController =
      StreamController<Map<String, Video>>.broadcast();

  Stream<Map<String, Video>> get outFavorites => _favoriteController.stream;

  void toggleFavorite(Video video) {
    final String videoId = video.id;

    if (_favorites.containsKey(videoId)) {
      _favorites.remove(videoId);
    } else {
      _favorites[videoId] = video;
    }

    _favoriteController.sink.add(_favorites);
  }

  @override
  void dispose() {
    _favoriteController.close();
  }
}

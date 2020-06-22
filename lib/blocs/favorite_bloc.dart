import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_youtube_favorites/models/video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};

  FavoriteBloc() {
    print("FavoriteBloc");
    SharedPreferences.getInstance().then((preferences) {
      if (preferences.getKeys().contains("favorites")) {
        _favorites =
            json.decode(preferences.getString("favorites")).map((k, v) {
          return MapEntry(k, Video.fromJson(v));
        }).cast<String, Video>();
        _favoriteController.sink.add(_favorites);
      }
    });
  }

  final StreamController _favoriteController =
      BehaviorSubject<Map<String, Video>>(seedValue: {});

  Stream<Map<String, Video>> get outFavorites => _favoriteController.stream;

  void toggleFavorite(Video video) {
    final String videoId = video.id;

    if (_favorites.containsKey(videoId)) {
      _favorites.remove(videoId);
    } else {
      _favorites[videoId] = video;
    }

    _favoriteController.sink.add(_favorites);

    _saveFavorite();
  }

  void _saveFavorite() {
    SharedPreferences.getInstance().then((preferences) {
      preferences.setString("favorites", json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favoriteController.close();
  }
}

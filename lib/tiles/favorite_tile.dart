import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:flutter_youtube_favorites/blocs/favorite_bloc.dart';
import 'package:flutter_youtube_favorites/constants.dart';
import 'package:flutter_youtube_favorites/models/video.dart';

class FavoriteTile extends StatelessWidget {
  final Video video;

  FavoriteTile(this.video);

  @override
  Widget build(BuildContext context) {
    final _favoritesProvider = BlocProvider.of<FavoriteBloc>(context);

    return InkWell(
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            height: 50,
            child: Image.network(this.video.thumbnail),
          ),
          Expanded(
            child: Text(
              this.video.title,
              maxLines: 2,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      onTap: () {
        FlutterYoutube.playYoutubeVideoById(
            apiKey: API_KEY, videoId: this.video.id);
      },
      onLongPress: () {
        _favoritesProvider.toggleFavorite(this.video);
      },
    );
  }
}

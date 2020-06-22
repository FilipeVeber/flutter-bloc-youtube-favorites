import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_favorites/blocs/favorite_bloc.dart';
import 'package:flutter_youtube_favorites/models/video.dart';
import 'package:flutter_youtube_favorites/tiles/favorite_tile.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _favoritesProvider = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
      ),
      body: StreamBuilder<Map<String, Video>>(
        initialData: {},
        stream: _favoritesProvider.outFavorites,
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((v) {
              return FavoriteTile(v);
            }).toList(),
          );
        },
      ),
    );
  }
}

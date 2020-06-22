import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_favorites/blocs/favorite_bloc.dart';

import '../models/video.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    final favoritesBloc = BlocProvider.of<FavoriteBloc>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              video.thumbnail,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        video.title,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(video.channel,
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    )
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                stream: favoritesBloc.outFavorites,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return IconButton(
                      icon: Icon(snapshot.data.containsKey(video.id)
                          ? Icons.star
                          : Icons.star_border),
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: () {
                        favoritesBloc.toggleFavorite(video);
                      },
                    );
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

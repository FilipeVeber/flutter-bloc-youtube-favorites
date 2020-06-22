import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_favorites/blocs/favorite_bloc.dart';
import 'package:flutter_youtube_favorites/blocs/video_bloc.dart';
import 'package:flutter_youtube_favorites/delegates/data_search.dart';
import 'package:flutter_youtube_favorites/models/video.dart';
import 'package:flutter_youtube_favorites/screens/favorite_screen.dart';
import 'package:flutter_youtube_favorites/tiles/video_tile.dart';

class VideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _videoProvider = BlocProvider.of<VideoBloc>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(height: 25, child: Text("Aqui vai a logo")
//            child: Image.asset("")
            ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
                stream: BlocProvider.of<FavoriteBloc>(context).outFavorites,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return Text("${snapshot.data.length}");
                  }
                }),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FavoriteScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());

              if (result != null) {
                _videoProvider.inSearch.add(result);
              }
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _videoProvider.outVideos,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Container();
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return VideoTile(snapshot.data[index]);
                  },
                );
              }
              break;
            default:
              return Container();
          }
          return Container();
        },
      ),
    );
  }
}

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_favorites/blocs/video_bloc.dart';
import 'package:flutter_youtube_favorites/delegates/data_search.dart';
import 'package:flutter_youtube_favorites/models/video.dart';
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
            child: Text("0"),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {},
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
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 10 + 1,
              itemBuilder: (context, index) {
                if (index < 10 + 1) {
                  return VideoTile(snapshot.data[index]);
                } else {
                  _videoProvider.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'blocs/video_bloc.dart';
import 'screens/video_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideoBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: VideoScreen(),
      ),
    );
  }
}

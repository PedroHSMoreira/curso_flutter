import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/blocs/videos_bloc.dart';
import 'package:flutter_bloc/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocs: [Bloc((_) => VideosBloc())],
        child: MaterialApp(
          title: 'Flutter Demo',
          home: Home(),
          debugShowCheckedModeBanner: false,
        ));
  }
}

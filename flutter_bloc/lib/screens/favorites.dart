import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/blocs/favorite_bloc.dart';
import 'package:flutter_bloc/models/video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:flutter_bloc/api.dart';

class Favorites extends StatelessWidget {
  final bloc = BlocProvider.getBloc<FavoriteBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map(
              (value) {
                return InkWell(
                  onTap: () {
                    FlutterYoutube.playYoutubeVideoById(
                        apiKey: API_KEY, videoId: value.id, autoPlay: true,);
                  },
                  onLongPress: () {
                    bloc.toggleFavorite(value);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 50,
                        child: Image.network(value.thumb),
                      ),
                      Expanded(
                        child: Text(
                          value.title,
                          style: TextStyle(color: Colors.white70),
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}

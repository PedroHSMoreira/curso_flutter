import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset = 0;

  Future<Map> _getGifs() async {
    http.Response response;

    if (_search == null) {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=5xwSWq89rAlKBCLCX6yU63hX4L61FA6d&limit=20&rating=g");
    } else {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=5xwSWq89rAlKBCLCX6yU63hX4L61FA6d&q=$_search&limit=20&offset=$_offset&rating=g&lang=en");
    }

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _getGifs().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
            "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Pesquise Aqui",
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError)
                      return Container();
                    else
                      return _createGifsTable(context, snapshot);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget _createGifsTable(BuildContext context, AsyncSnapshot snapshot) {
  return GridView.builder(
    padding: EdgeInsets.all(10.0),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
    itemCount: snapshot.data["data"].length,
    itemBuilder: (context, index) {
      return GestureDetector(
        child: Image.network(
          snapshot.data["data"][index]["images"]["fixed_height"]["url"],
          height: 300.0,
          fit: BoxFit.cover,
        ),
      );
    },
  );
}
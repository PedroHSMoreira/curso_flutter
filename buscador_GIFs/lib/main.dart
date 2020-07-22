import 'package:flutter/material.dart';

import 'package:buscador_GIFs/ui/home_page.dart';

void main() {
  runApp(MaterialApp(
    title: "Buscador de GIFs",
    theme: ThemeData(
        hintColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hintStyle: TextStyle(color: Colors.white),
        )),
    home: HomePage(),
  ));
}

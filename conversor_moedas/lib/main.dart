import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const URL = "https://api.hgbrasil.com/finance?key=";
void main() async {
  runApp(MaterialApp(
    title: "Conversor de Moedas",
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.amberAccent,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amberAccent)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(URL);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _realController = TextEditingController();
  final _dolarController = TextEditingController();
  final _euroController = TextEditingController();

  double dolar, euro;

  void _clearAll() {
    _realController.text = "";
    _dolarController.text = "";
    _euroController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    _dolarController.text = (real / dolar).toStringAsFixed(2);
    _euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    _realController.text = (dolar * this.dolar).toStringAsFixed(2);
    _euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    _realController.text = (euro * this.euro).toStringAsFixed(2);
    _dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de Moedas"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados...",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao Carregar Dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              dolar = snapshot.data['results']['currencies']['USD']['buy'];
              euro = snapshot.data['results']['currencies']['EUR']['buy'];
              return SingleChildScrollView(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(
                      Icons.monetization_on,
                      size: 150.0,
                      color: Colors.amber,
                    ),
                    buildTextField(
                        "Reais", "R\$", _realController, _realChanged),
                    Divider(),
                    buildTextField(
                        "Dólares", "US\$", _dolarController, _dolarChanged),
                    Divider(),
                    buildTextField("Euros", "€", _euroController, _euroChanged)
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}

Widget buildTextField(String label, String prefix,
    TextEditingController controller, Function func) {
  return TextField(
    controller: controller,
    onChanged: func,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    // Para digitar númeors decimais no IOS
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}

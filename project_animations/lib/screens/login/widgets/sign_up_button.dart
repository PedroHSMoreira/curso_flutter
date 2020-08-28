import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(
        top: 160,
      ),
      onPressed: () {},
      child: Text(
        "Não possui uma conta? Cadastre-se!",
        textAlign: TextAlign.center,
        // Faz a truncagem do texto
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

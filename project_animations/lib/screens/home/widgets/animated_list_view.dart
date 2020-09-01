import 'package:flutter/material.dart';
import 'package:project_animations/screens/home/widgets/list_data.dart';

class AnimatedListView extends StatelessWidget {
  final Animation<EdgeInsets> listSlidePosition;

  AnimatedListView({
    @required this.listSlidePosition,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        ListData(
          title: "Estudando Flutter",
          subTitle: "Com um curso muito bacana",
          image: AssetImage("images/perfil.jpeg"),
          margin: listSlidePosition.value * 1,
        ),
        ListData(
          title: "Estudando Flutter 2",
          subTitle: "Com um curso muito bacana",
          image: AssetImage("images/perfil.jpeg"),
          margin: listSlidePosition.value * 0,
        ),
      ],
    );
  }
}

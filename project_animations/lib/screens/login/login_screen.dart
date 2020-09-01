import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_animations/screens/home/home_screen.dart';
import 'package:project_animations/screens/login/widgets/form_container.dart';
import 'package:project_animations/screens/login/widgets/sign_up_button.dart';
import 'package:project_animations/screens/login/widgets/stagger_animation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  String moonAnim = "";

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        setState(() {
        moonAnim = "Flying";  
        });
      }
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "images/background.jpg",
              ),
              fit: BoxFit.cover),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 70, bottom: 32),
                      height: 300,
                      width: 300,
                      child: FlareActor(
                        "images/moon_anim.flr",
                        animation: moonAnim,
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 70, bottom: 32),
                    //   child: SvgPicture.asset(
                    //     "images/moon.svg",
                    //     width: 150,
                    //     height: 150,
                    //     fit: BoxFit.contain,
                    //   ),
                    // ),
                    FormContainer(),
                    SignUpButton(),
                  ],
                ),
                StaggerAnimation(controller: _animationController.view),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

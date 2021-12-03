import 'dart:async';
import 'package:flutter/material.dart';
import 'package:homelabz/Screens/HomeScreen.dart';
import 'package:homelabz/components/ColorValues.dart';


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorValues.THEME_TEXT_COLOR),
      body: Center(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(ColorValues.WHITE),
                shape: BoxShape.circle),
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Image.asset('assets/images/splashLogo.png',
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.5),
          )
      ),
    );
  }
}
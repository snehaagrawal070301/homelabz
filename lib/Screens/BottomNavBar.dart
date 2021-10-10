import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:homelabz/Screens/HomeScreen.dart';
import 'package:homelabz/components/colorValues.dart';

class BottomNavBar extends StatefulWidget {
  final String screenName;

  const BottomNavBar(this.screenName);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      color: Color(ColorValues.THEME_COLOR),
      backgroundColor: Color(ColorValues.THEME_COLOR),
      items: [
        TabItem(icon: Icons.home, title: "Home"),
      ],
      onTap: (int i) {
//        Navigator.pushReplacement(
//            context,
//            MaterialPageRoute(
//                builder: (context) => HomeScreen()));
        // Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        if (widget.screenName != null &&
            widget.screenName.compareTo("homeScreen") == 0) {
          // do nothing
        } else {
          makeRoutePage(context: context, pageRef: HomeScreen());
        }
      },
    );
  }

  void makeRoutePage({BuildContext context, Widget pageRef}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => pageRef),
        (Route<dynamic> route) => false);
  }
}

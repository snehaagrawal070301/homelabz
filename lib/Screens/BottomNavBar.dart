import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:homelabz/Screens/HomeScreen.dart';
import 'package:homelabz/components/ColorValues.dart';

class BottomNavBar extends StatefulWidget {
  final String screenName;

  const BottomNavBar(this.screenName);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: ConvexAppBar(
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
          if (widget.screenName != "") {
            if (widget.screenName.compareTo("homeScreen") == 0) {
              // do nothing
            }else if(widget.screenName.compareTo("bookingScreen") == 0) {
              showAlertDialog(context);
            }
          } else {
            makeRoutePage(context: context, pageRef: HomeScreen());
          }
        },
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK", style: TextStyle(
        color: Color(ColorValues.THEME_TEXT_COLOR),
      ),),
      onPressed: () {
        makeRoutePage(context: context, pageRef: HomeScreen());
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("Cancel", style: TextStyle(
        color: Color(ColorValues.THEME_TEXT_COLOR),
      ),),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Discard"),
      content: Text("Do you want to discard this Booking?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
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

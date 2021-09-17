import 'package:flutter/material.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:url_launcher/url_launcher.dart';

class CallforAppointment extends StatefulWidget {
  @override
  _CallforAppointmentState createState() => _CallforAppointmentState();
}

class _CallforAppointmentState extends State<CallforAppointment> {
  String _url= 'tel:+919827510000';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(ColorValues.WHITE_COLOR),
    appBar: AppBar(
    backgroundColor: Color(ColorValues.WHITE_COLOR),
    leading: IconButton(
    icon: Icon(
    Icons.arrow_back,
    color: Color(ColorValues.THEME_COLOR),
    ),
    onPressed: () {
    Navigator.pop(context);
    },
    ),
    title: Text(
    "Call for Appointment",
    style: TextStyle(
    fontFamily: "Regular",
    fontSize: 18,
    color: Color(ColorValues.THEME_COLOR)),
    ),
    ),
      body:Center(
        child: RaisedButton(
          color: Color(ColorValues.THEME_COLOR),
          onPressed: _launchURL,
          child: Text('Call for Appointment',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(ColorValues.WHITE_COLOR,)
          ),),
        ),
      ) ,
    );
  }
  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}

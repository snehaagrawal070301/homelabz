import 'package:flutter/material.dart';
import 'package:homelabz/MakeAnAppointmentScreen.dart';
import 'package:homelabz/appointmentScreen.dart';
//import 'package:homelabz/MakeAnAppointmentScreen.dart';
import 'package:homelabz/bookingScreen.dart';
import 'package:homelabz/homeScreen.dart';
import 'package:homelabz/paymentScreen.dart';
//import 'package:homelabz/bookingSuccess.dart';
//import 'package:homelabz/homeScreen.dart';
//import 'package:homelabz/homeScreen.dart';
//import 'package:homelabz/login1.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffFFFFFF),
        
        canvasColor: Colors.transparent
      ),
      
      home:HomeScreen(),
    );
  }
}



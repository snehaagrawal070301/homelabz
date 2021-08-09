import 'package:flutter/material.dart';
import 'package:homelabz/Screens/BookingChooseDate.dart';
import 'package:homelabz/Screens/MakeAnAppointmentScreen.dart';
import 'package:homelabz/Screens/MakeAppointment.dart';
import 'package:homelabz/Screens/homeScreen.dart';

import 'Screens/bookingScreen.dart';


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
     // home: BookingChooseDate(),
       home:MakeAppointment(),
   //  home:BookingScreen(),
    );
  }
}




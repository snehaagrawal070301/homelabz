import 'package:flutter/material.dart';
import 'package:homelabz/Screens/SplashScreen.dart';
//import 'package:homelabz/Screens/BookingChooseDate.dart';
import 'package:homelabz/Screens/homeScreen.dart';
//import 'package:homelabz/Screens/test.dart';
//import 'package:homelabz/Screens/MakeAppointmentScreen.dart';

//import 'Screens/appointmentScreen.dart';

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
// home:SplashScreen(),
  home: HomeScreen(),
  //  home: AppointmentScreen(null,null),
     // home: BookingChooseDate(),
    //   home:MakeAppointment(),
//   home:MakeAppointmentScreen(),
//   home:BookingChooseDate(),
//      home: Test(),
   //  home:BookingScreen(),
    );
  }
}




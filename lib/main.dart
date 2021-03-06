import 'package:flutter/material.dart';
import 'package:homelabz/Screens/DocumentUpload.dart';
import 'package:homelabz/Screens/HomeScreen.dart';
import 'package:homelabz/Screens/ProfileScreen.dart';
import 'package:homelabz/Screens/Vault.dart';

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
          textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: Colors.transparent,
          ),
          scaffoldBackgroundColor: const Color(0xffFFFFFF),
          canvasColor: Colors.transparent),
      home: HomeScreen(),
      // home: Vault(),
    );
  }
}

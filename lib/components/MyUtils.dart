import 'package:homelabz/components/ColorValues.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class MyUtils{
  static String changeDateFormat(String date){
    // String to date
    DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(tempDate);
    return formatted;
  }

  static String getDayOfWeek(String date){
    // String to date
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    final DateFormat formatter = DateFormat('EE');
    final String formatted = formatter.format(tempDate);
    return formatted;
  }

  static String getDateOfMonth(String date){
    // String to date
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    final DateFormat formatter = DateFormat('dd');
    final String formatted = formatter.format(tempDate);
    return formatted;
  }

  static String getMonthName(String date){
    // String to date
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    final DateFormat formatter = DateFormat('MMM');
    final String formatted = formatter.format(tempDate);
    return formatted;
  }

  static String changeTimeFormat(String time){
    // String to date
    DateTime tempDate = new DateFormat("HH:mm:ss").parse(time);
    final DateFormat formatter = DateFormat('hh:mm a');
    final String formatted = formatter.format(tempDate);
    return formatted;
  }

  static Future<SecurityContext> get globalContext async {
    final sslCert1 = await rootBundle.load('assets/ssl_certificate.crt');
    SecurityContext sc = new SecurityContext(withTrustedRoots: false);
    sc.setTrustedCertificatesBytes(sslCert1.buffer.asInt8List());
    return sc;
  }


  // Custom Toast Position
  static void showCustomToast(String message, bool isError, BuildContext context) {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
      decoration: isError == false
          ? BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.green,
      )
          : BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.red,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // isError == false
          //     ? Icon(
          //   Icons.check,
          //   color: Color(ColorValues.WHITE),
          // )
          // :ImageIcon(
          //   AssetImage('assets/images/close_red.png'),
          //   size: 10,
          // ),


          // Padding(
          //   padding: const EdgeInsets.only(left: 15.0),
          //     child:
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  message,
                  style: TextStyle(
                      fontFamily: "Regular",
                      fontSize: 14,
                      color: Color(ColorValues.WHITE)),
                ),
              ),
            ),
          ),
          // ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 3),
    );
  }

}
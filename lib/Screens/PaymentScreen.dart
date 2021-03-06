import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/Models/PaymentInfo.dart';
import 'package:homelabz/Screens/BookingsListScreen.dart';
import 'package:homelabz/Screens/PaymentSuccess.dart';
import 'package:homelabz/Screens/BottomNavBar.dart';
import 'package:homelabz/Services/payment-service.dart';
import 'package:homelabz/components/MyUtils.dart';
import 'package:homelabz/components/ColorValues.dart';
import 'package:homelabz/constants/Constants.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen extends StatefulWidget{

  final int bookingId;
  final String screenName;

  const PaymentScreen(this.bookingId, this.screenName);

  @override
  State<StatefulWidget> createState() {
    return PaymentScreenState();
  }

}

class PaymentScreenState extends State<PaymentScreen>{
  SharedPreferences preferences;
  PaymentInfo model;
  String key = "sk_test_51JCGTpSEMWQLjRXwcTdxvmgHC60nfosillm6LgGaBks56r5JVmESiCJsDb7abWIL0LoxAG8v8dNJZ2GuoprceD8D00QdDQzoNQ";

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    getPaymentInfo();
  }

  Future<void> getPaymentInfo() async {
    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.GET_PAYMENT_INFO);
      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH: "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };

      Map mapBody = {
        Constants.BOOKING_ID: widget.bookingId,
      };
      print(mapBody);
      // make POST request
      var response =
      await _ioClient.post(url, headers: headers, body: json.encode(mapBody));

      String body = response.body;
      print(body);

      if (response.statusCode == 200) {
        model = PaymentInfo.fromJson(json.decode(body));
        StripeService.init(model.stripePublicKey, key);
      } else {
        var data = json.decode(body);
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
    } catch (e) {
      print("Error+++++" + e.toString());
    }
  }

  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();

    if (model.amount != null) {
      var response = await StripeService.payWithNewCard(
          amount: model.amount.toString(), currency: model.currency);
    if (response.success) {
      print(response.message);
      // call submit api here
      submitPaymentStatus("succeeded");
    } else {

    }
    await dialog.hide();
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(response.message),
        duration: new Duration(
            milliseconds: response.success == true ? 1200 : 3000)));
  }
  }

  Future<void> submitPaymentStatus(String status) async {
    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.SUBMIT_PAYMENT_INFO);
      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH: "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };

      Map mapBody = {
        Constants.BALANCE_TRANSACTION: model.amount,
        Constants.BOOKING_ID: widget.bookingId,
        Constants.STATUS: status,
      };
      print(mapBody);
      // make POST request
      var response =
      await _ioClient.post(url, headers: headers, body: json.encode(mapBody));

      String body = response.body;
      print(body);

      if (response.statusCode == 200) {
        // call success screen
        var data = json.decode(body);
        int paymentId = data["paymentId"];
        print("paymentId"+" ===== "+ paymentId.toString());

        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => PaymentSuccess(paymentId, widget.bookingId)));
      } else {
        var data = json.decode(body);
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
    } catch (e) {
      print("Error+++++" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color(ColorValues.WHITE_COLOR),
        leading: IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/back_arrow.png'),
              color: Color(ColorValues.THEME_COLOR),
              size: 20,
            ),
          onPressed: () {
              if(widget.screenName!=null &&(widget.screenName.compareTo("BookingDetails")==0)) {
                Navigator.pop(context);
              }else {
                //go to upcoming list screen
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            BookingsListScreen()));
              }
          },
    ),
        title: Text("Payment",style: TextStyle(fontFamily: "Regular",fontSize: 18,
        color: Color(ColorValues.THEME_COLOR)),),
      ),
      body: 
      SingleChildScrollView(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //margin: EdgeInsets.symmetric(horizontal: 65),
              child: Image(
                height: MediaQuery.of(context).size.height*0.30,
                width: MediaQuery.of(context).size.width,
                image: AssetImage("assets/images/PaymentScreen.png"),
              ),
            ),
            //
            // Container(
            //   margin: EdgeInsets.only(top: 39,left: 30),
            //   child: Text("Select payment method",style:
            //   TextStyle(fontFamily:"Poppins",fontSize: 13,color:Color(ColorValues.BLACK_TEXT_COL) ),),
            // ),
            //
            // Container(
            //           margin: EdgeInsets.only(top: 16,right: 30,left: 30),
            //           padding: EdgeInsets.only(left: 16),
            //           height: 43,
            //           width: MediaQuery.of(context).size.width,
            //           decoration: BoxDecoration(
            //           color: Color(ColorValues.WHITE_COLOR),
            //           borderRadius: BorderRadius.circular(10),
            //           boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey,
            //             blurRadius: 7.0,
            //             spreadRadius: 1.0,
            //             )]
            //             ),
            //           child: DropdownButtonHideUnderline(
            //           child: DropdownButton<String>(
            //             value: type,
            //             iconSize: 24,
            //             dropdownColor: Color(ColorValues.WHITE_COLOR),
            //             iconEnabledColor: Color(ColorValues.BLACK_COLOR),
            //             focusColor: Color(ColorValues.WHITE_COLOR),
            //             elevation: 16,
            //             style: TextStyle(color: Color(ColorValues.BLACK_COLOR),fontSize: 14,fontFamily: "Black"),
            //             onChanged: (String newValue) {
            //               setState(() {
            //                 type = newValue;
            //               });
            //             },
            //             items: <String>['Credit/Debit/ATM Card', 'Electronic bank transfer']
            //                 .map<DropdownMenuItem<String>>((String value) {
            //               return DropdownMenuItem<String>(
            //                 value: value,
            //                 child: Text(value),
            //               );
            //             }).toList(),
            //           ),
            //         )),
            //   Container(
            //     margin: EdgeInsets.only(top: 39,left: 28),
            //      child:Row(
            //           children: [
            //             Radio(
            //               value: 0,
            //               groupValue: _radioValue,
            //               onChanged: _handleRadioValueChange,
            //             ),
            //             Text(
            //               "Add New Card",
            //               style: TextStyle(fontSize: 12.0, color: Color(ColorValues.BLACK_TEXT_COL)),
            //               textAlign: TextAlign.center,
            //             ),
            //           ]),
            //           ),
            //       Container(
            //           margin: EdgeInsets.only(top: 13,right: 30,left: 30),
            //           height: MediaQuery.of(context).size.height*0.27,
            //           width: MediaQuery.of(context).size.width,
            //           decoration: BoxDecoration(
            //           color: Color(ColorValues.WHITE_COLOR),
            //           borderRadius: BorderRadius.circular(10),
            //           boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey,
            //             blurRadius: 7.0,
            //             spreadRadius: 1.0,
            //             )]
            //             ),
            //        ),
            //       GestureDetector(
            //         onTap: (){
            //          Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) =>
            //                           BookingSuccessScreen()));
            //       },
            //         child: Container(
            //           margin: EdgeInsets.only(top:35,left: 30,right: 30),
            //         height: 38,
            //         width: MediaQuery.of(context).size.width,
            //         decoration: BoxDecoration(
            //           color: Color(ColorValues.THEME_COLOR),
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: Center(
            //           child: Text("CONFIRM AND PAY",style: TextStyle(fontFamily: "Regular",fontSize: 15,
            //           color: Color(ColorValues.WHITE_COLOR)),textAlign: TextAlign.center,),),
            //     ),
            //         ),
            //       SizedBox(
            //         height: 30,
            //       )

            GestureDetector(
              onTap: () {
                payViaNewCard(context);
              },
              child: Container(
                margin:
                EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                height: 38,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(ColorValues.THEME_COLOR),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    "Pay via Card",
                    style: TextStyle(
                        fontFamily: "Regular",
                        fontSize: 16,
                        color: Color(ColorValues.WHITE_COLOR)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

                    ]),
            ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/Screens/BookingsListScreen.dart';
import 'package:homelabz/Screens/BottomNavBar.dart';
import 'package:homelabz/components/colorValues.dart';

class PaymentSuccess extends StatefulWidget{

  final int paymentId;
  final int bookingId;

  const PaymentSuccess(this.paymentId, this.bookingId);

  @override
  State<StatefulWidget> createState() {
    return PaymentSuccessState();
  }
}

class PaymentSuccessState extends State<PaymentSuccess>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(ColorValues.WHITE_COLOR),
    //     leading: IconButton(
    //         icon: Icon(
    //         Icons.arrow_back,
    //         color: Color(ColorValues.THEME_COLOR),
    //         ),
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    // ),
        title: Center(
          child: Text("Booking Success",style: TextStyle(fontFamily: "Regular",fontSize: 18,
          color: Color(ColorValues.THEME_COLOR)),),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Image(image: AssetImage("assets/images/bookingSuccessLogo.png"),height: MediaQuery.of(context).size.height*0.27,width: MediaQuery.of(context).size.width*0.66,),
            ),
            Container(
              margin: EdgeInsets.only(top: 25,left: 38,right: 38),
              height: MediaQuery.of(context).size.height*0.19,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(ColorValues.WHITE_COLOR),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                  color: Colors.grey,
                  blurRadius: 7.0,
                  spreadRadius: 0,
                )]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text("Booking Success",style: TextStyle(fontSize: 16,color: Color(ColorValues.BLACK_COLOR),fontFamily:"Black"),textAlign: TextAlign.center,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text("Booking ID - ${widget.bookingId}",style: TextStyle(fontSize: 16,color: Color(ColorValues.THEME_COLOR),fontFamily:"Black"),textAlign: TextAlign.center,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text("Your Payment was successfully completed.",style: TextStyle(fontSize: 12,color: Color(ColorValues.BLACK_COLOR),fontFamily:"Medium"),textAlign: TextAlign.center,),
                  )
                ],
              ),
            ),
            GestureDetector(
                        onTap: () {
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BookingsListScreen()));
                        },
                child: Container(
                  margin: EdgeInsets.only(top: 45,right: 30,left: 30),
                height: 38,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(ColorValues.THEME_COLOR),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text("BACK TO HOME",style: TextStyle(fontFamily: "Regular",fontSize: 15,
                  color: Color(ColorValues.WHITE_COLOR)),textAlign: TextAlign.center,),),
              ),
           ),
          ],
        ),
        ),
      bottomNavigationBar: BottomNavBar(""),
    );
  }
}
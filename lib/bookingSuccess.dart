import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/homeScreen.dart';

class BookingSuccessScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BookingSuccessScreenState();
  }

}

class BookingSuccessScreenState extends State<BookingSuccessScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        leading: IconButton(
            icon: Icon(
            Icons.arrow_back,
            color: Color(0xff21C8BE),
            ),
          onPressed: () {
            Navigator.pop(context);
          },
    ),
        title: Text("Booking Success",style: TextStyle(fontFamily: "Regular",fontSize: 18,
        color: Color(0xff21C8BE)),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 25,left: 64,right: 64),
              child: Image(image: AssetImage("assets/images/bookingSuccessLogo.png"),),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              height: 137,
              width: 301,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                  color: Colors.grey,
                  blurRadius: 7.0,
                  spreadRadius: 0,
                )]
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text("Booking Success",style: TextStyle(fontSize: 16,color: Color(0xff000000),fontFamily:"Black"),textAlign: TextAlign.center,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text("Booking ID - 003221",style: TextStyle(fontSize: 16,color: Color(0xff21C8BE),fontFamily:"Black"),textAlign: TextAlign.center,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 9),
                    child: Text("Lorem Ipsum is simply dummy text of the printing \nand typesetting industry. Lorem Ipsum has been \nthe industry's standard dummy text ever since the\n 1500s",style: TextStyle(fontSize: 11,color: Color(0xff000000),fontFamily:"Medium"),textAlign: TextAlign.center,),
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
                                      HomeScreen()));
                        },
                child: Container(
                  margin: EdgeInsets.only(top: 33,right: 30,left: 30),
                height: 38,
                width: 315,
                decoration: BoxDecoration(
                  color: Color(0xff21C8BE),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text("BACK TO HOME",style: TextStyle(fontFamily: "Regular",fontSize: 15,
                  color: Color(0xffFFFFFF)),textAlign: TextAlign.center,),),
              ),
           ),
          ],
        ),
        ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/Screens/BookingChooseDate.dart';
import 'package:homelabz/Screens/appointmentScreen.dart';
import 'package:homelabz/components/colorValues.dart';

class BookingScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BookingScreenState();
  }
}

class BookingScreenState extends State<BookingScreen>{
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
        title: Text("Booking",style: TextStyle(fontFamily: "Regular",fontSize: 18,
        color: Color(ColorValues.THEME_COLOR)),),
      ),
      body:
      SingleChildScrollView(
        child:
        Container(
          height: MediaQuery.of(context).size.height,
          color: Color(ColorValues.WHITE_COLOR),
          child: Stack(
            children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.18,
                    width: MediaQuery.of(context).size.width,
                    color: Color(ColorValues.THEME_COLOR),
                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                              },
                              child: Container(
                                height: 36,
                                width: MediaQuery.of(context).size.width*0.41,
                                decoration: BoxDecoration(
                                  color: Color(ColorValues.WHITE_COLOR),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text("ASAP",style: TextStyle(fontFamily: "Regular",fontSize: 18,
                                      color: Color(ColorValues.THEME_COLOR)),textAlign: TextAlign.center,),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BookingChooseDate()));
                              },
                              child: Container(
                                height: 36,
                                width: MediaQuery.of(context).size.width*0.41,
                                decoration: BoxDecoration(
                                  color: Color(ColorValues.THEME_COLOR),
                                  border: Border.all(color: Color(ColorValues.WHITE_COLOR)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text("Chose Date",style: TextStyle(fontFamily: "Regular",fontSize: 18,
                                      color: Color(ColorValues.WHITE_COLOR)),textAlign: TextAlign.center,),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              Positioned(
                top:71,
                left: 20,
                right: 20,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.21,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(ColorValues.WHITE_COLOR),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                      color: Colors.grey,
                      blurRadius: 7.0,
                      spreadRadius: 1.0,
                    )]
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff1D2A4D),
                          borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 21),
                                child: Image(image: AssetImage("assets/images/bookingImage.png"),height: 23,width: 23,),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 17),
                                child: Text("Lorem Ipsum is simply",style: TextStyle(color: Color(ColorValues.WHITE_COLOR),fontFamily: "Poppins",fontSize: 14),))
                            ],
                          ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(21, 19, 21, 20),
                        child: Text("Get your labs done within 24hours by paying extra \n10 We will schedule a phlebotomist as soon as\n available to reach you.",style: TextStyle(fontSize: 12,color: Color(ColorValues.BLACK_COLOR)),),
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top:MediaQuery.of(context).size.height*0.36,
                right: 37,
                left: 37,
                  child:GestureDetector(
                    onTap: (){
                       Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AppointmentScreen(null,null)));
                    },
                      child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 38,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(ColorValues.THEME_COLOR),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text("BOOK NOW",style: TextStyle(fontFamily: "Regular",fontSize: 15,
                        color: Color(ColorValues.WHITE_COLOR)),textAlign: TextAlign.center,),),
                  ),

               ),
               ),
          ]),
        ),
      ),);
  }
}
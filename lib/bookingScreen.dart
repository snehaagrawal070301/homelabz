import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/appointmentScreen.dart';

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
      backgroundColor: Color(0xffFFFFFF),
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
        title: Text("Booking",style: TextStyle(fontFamily: "Regular",fontSize: 18,
        color: Color(0xff21C8BE)),),
      ),
      body:
      SingleChildScrollView(
        child:
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 300),
              width: MediaQuery.of(context).size.width,
              height: 137,
              color: Color(0xff21C8BE),   
          ),
            Positioned(
              left: 19,
              top:25,
               child:GestureDetector(
                          onTap: () {
                          },
              child: Container(
                height: 36,
                width: 159,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("ASAP",style: TextStyle(fontFamily: "Regular",fontSize: 18,
                  color: Color(0xff21C8BE)),textAlign: TextAlign.center,),
                ),
              ),
             ),
             ),
            Positioned(
              right: 19,
              top:25,
               child:GestureDetector(
                          onTap: () {
                          },
              child: Container(
                height: 36,
                width: 159,
                decoration: BoxDecoration(
                  color: Color(0xff21C8BE),
                  border: Border.all(color: Color(0xffFFFFFF)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("Chose Date",style: TextStyle(fontFamily: "Regular",fontSize: 18,
                  color: Color(0xffFFFFFF)),textAlign: TextAlign.center,),
                ),
              ),
             ),
             ),
            Positioned(
              top:71,
              left: 20,
              right: 20,
              child: Container(
                height: 155,
                width: 348,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
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
                              child: Text("Lorem Ipsum is simply",style: TextStyle(color: Color(0xffFFFFFF),fontFamily: "Poppins",fontSize: 14),))
                          ],
                        ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(21, 19, 21, 20),
                      child: Text("Get your labs done within 24hours by paying extra \n10 We will schedule a phlebotomist as soon as\n available to reach you.",style: TextStyle(fontSize: 12,color: Color(0xff000000)),),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              top:254,
              right: 37,
              left: 37,
                child:GestureDetector(
                  onTap: (){
                     Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AppointmentScreen()));
                  },
                    child: Container(
                    height: 38,
                    width: 301,
                    decoration: BoxDecoration(
                      color: Color(0xff21C8BE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text("BOOK NOW",style: TextStyle(fontFamily: "Regular",fontSize: 15,
                      color: Color(0xffFFFFFF)),textAlign: TextAlign.center,),),
                ),
  
             ),
             ),
        ]),
      ),);
  }
}
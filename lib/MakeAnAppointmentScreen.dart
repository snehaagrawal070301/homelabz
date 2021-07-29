import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/bookingScreen.dart';

class MakeAnAppointScreeen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MakeAnAppointScreeenState();
  }

}

class MakeAnAppointScreeenState extends State<MakeAnAppointScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        leading:Container(
          margin: EdgeInsets.only(left: 17,top: 20,bottom: 20),
          child:Image(image: AssetImage("assets/images/MakeAnAppointmentMenu.png"),height: 19.52,width: 26,),),
        title: Text("Make an Appointment",style: TextStyle(fontFamily: "Regular",fontSize: 18,
        color: Color(0xff21C8BE)),),
        actions: <Widget>[
          IconButton(
            icon: Icon(
            Icons.notifications,
            color: Color(0xff21C8BE),
            ),
          onPressed: () {
            Navigator.pop(context);
          },
    )
  ],
      ),
      body:
      SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 586),
              width: MediaQuery.of(context).size.width,
              height: 116,
              color: Color(0xff21C8BE), 
            ),
            Positioned(
              left: 10,
              right: 10,
              top:66,
              bottom: 30,
              child: Container(
                height: 586,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                    color: Colors.grey,
                    blurRadius: 7.0,
                    spreadRadius: 0.0,
                  )]
                ),
                child: ListView(children: [
                  Container(
                    margin: EdgeInsets.only(left: 18,top: 18),
                    child: Text("Upcoming",style: TextStyle(color: Color(0xff000000),fontSize: 12,fontFamily: "Regular"),))
                ],),
              ),
            ),
            Positioned(
              left: 200,
              right: 17,
              top:20,
              child:GestureDetector(
                  onTap: (){
                     Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BookingScreen()));
                  },
              child: Container(
                height: 29,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("BOOK APPOINTMENT",style: TextStyle(fontFamily: "Regular",fontSize: 10,
                  color: Color(0xff21C8BE)),textAlign: TextAlign.center,),
                ),
              ),
            ),
            ),
            Positioned(
            top: 118,  
            right: 28,
            left: 28,
            child:
            Container(
                        height: 238,
                        width: 321,
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
                     ),
            ),
            Positioned(
              top: 376,
              left: 28,
              right: 28,
              child:
            Container(
                        height: 238,
                        width: 321,
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
                     ),) 
        ],),
      ),
    );
  }
}
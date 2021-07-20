import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        leading:Image(image: AssetImage("assets/MakeAnAppointmentMenu.png"),height: 19.52,width: 26,) ,
        title: Text("Make an Appointment",style: TextStyle(fontFamily: "Regular",fontSize: 18,color: Color(0xff21C8BE)),),
        
      ),
    );
  }
}
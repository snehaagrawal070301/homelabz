import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/Screens/bookingScreen.dart';
import 'package:homelabz/components/colorValues.dart';

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
      backgroundColor: Color(ColorValues.WHITE_COLOR),
      appBar: AppBar(
        backgroundColor: Color(ColorValues.WHITE_COLOR),
        leading:Container(
          margin: EdgeInsets.only(left: 17,top: 20,bottom: 20),
          child:Image(image: AssetImage("assets/images/MakeAnAppointmentMenu.png"),height: 19.52,width: 26,),),
        title: Text("Make an Appointment",style: TextStyle(fontFamily: "Regular",fontSize: 18,
        color: Color(ColorValues.THEME_COLOR)),),
        actions: <Widget>[
          IconButton(
            icon: Icon(
            Icons.notifications,
            color: Color(ColorValues.THEME_COLOR),
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
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.72),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.16,
              color: Color(ColorValues.THEME_COLOR), 
            ),
            Positioned(
              left: 10,
              right: 10,
              top:66,
              bottom: 30,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(ColorValues.WHITE_COLOR),
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
                    child: Text("Upcoming",style: TextStyle(color: Color(ColorValues.BLACK_COLOR),fontSize: 12,fontFamily: "Regular"),))
                ],),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width*0.51,
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
                  color: Color(ColorValues.WHITE_COLOR),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("BOOK APPOINTMENT",style: TextStyle(fontFamily: "Regular",fontSize: 10,
                  color: Color(ColorValues.THEME_COLOR)),textAlign: TextAlign.center,),
                ),
              ),
            ),
            ),
            Positioned(
            top: MediaQuery.of(context).size.height*0.16,  
            right: 28,
            left: 28,
            child:
            Container(
                        height: MediaQuery.of(context).size.height*0.32,
                        width: MediaQuery.of(context).size.width*0.85,
                        decoration: BoxDecoration(
                        color: Color(ColorValues.WHITE_COLOR),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          spreadRadius: 0.5,
                          )]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 8,right:12 ),
                                    height: 16,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Color(0xff21C07D),
                                      borderRadius:BorderRadius.circular(10) 
                                    ),
                                    child: Center(child: Text("Confirmed",style: TextStyle(fontSize: 9,color: Color(ColorValues.WHITE_COLOR),fontFamily: "Regular"),textAlign: TextAlign.center,)),
                                  ),
                                ],
                              ),
                              Container(
                                //margin: EdgeInsets.only(left: 11.98),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                      Container(
                                          child: Image(
                                            height: 60,
                                            width: 60,
                                            image: AssetImage("assets/images/profileImage.png"),
                                          ),),
                                      
                                      Container(
                                        margin: EdgeInsets.only(left: 7.55),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(child: Text("Union Laboratory",style: TextStyle(color: Color(ColorValues.THEME_COLOR),fontFamily: "Regular",fontSize: 12),)),
                                            Container(
                                              margin: EdgeInsets.only(top: 5,bottom: 8),
                                              child: Text("Dr. Ruby khan",style: TextStyle(color: Color(ColorValues.BLACK_TEXT_COL),fontFamily: "Regular",fontSize: 9),)),
                                            Row(
                                              children: [
                                                Image(image: AssetImage("assets/images/star.png"),height: 8.43,width:49 ),
                                                SizedBox(width: 4,),
                                                Text("(47)",style: TextStyle(fontFamily: "Regular",fontSize: 8,color: Color(ColorValues.LIGHT_TEXT_COLOR)),)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      ],
                                    ),
                                    Container(
                                          
                                          child: Text(r"$ 50",style: TextStyle(fontWeight: FontWeight.bold,
                                          fontSize: 11,color: Color(ColorValues.THEME_COLOR),fontFamily: "Regular"),),
                                        ), 
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 14.55),
                                  child: Image(
                                    image: AssetImage("assets/images/dashedLine.png"),
                                    width: 269,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20.71,left: 32),
                                child: Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 72,
                                      height: 86,
                                      color: Color(ColorValues.DATE_BG),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("TUE",style: TextStyle(color: Color(ColorValues.LIGHT_TEXT_COLOR),fontSize: 11),),
                                            Text("25",style: TextStyle(fontSize: 21,color: Color(0xff21CDC0),fontWeight: FontWeight.bold),),
                                            Text("Feb",style: TextStyle(color: Color(ColorValues.LIGHT_TEXT_COLOR),fontSize: 11),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  Container(
                                  margin: EdgeInsets.symmetric(vertical: 0,horizontal: 7),
                                  height: 67, child: VerticalDivider(color: Color(ColorValues.GREY))),
                                  Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(child: Text("Phelbotomist Name",style: TextStyle(color: Color(ColorValues.BLACK_TEXT_COL),fontFamily: "Regular",fontSize: 12),)),
                                          Container(
                                            margin: EdgeInsets.only(top: 6,bottom: 9),
                                            child: Row(
                                              children: [
                                                Image(image: AssetImage("assets/images/clock.png"),height: 16.35,width:16.34 ),
                                                SizedBox(width: 7,),
                                                Text("04:00PM",style: TextStyle(fontFamily: "Regular",fontSize: 12,color: Color(0xff3D4461),)),
                                              ],
                                            ),
                                          ),
                                          Text("Change Date & Time",style: TextStyle(color: Color(0xff21CDC0),fontFamily: "Regular",fontSize: 10),),
                                        ]),
                                  ],
                                ),
                              )
                            ],
                          ),
                     ),
            ),
           
        ],),
      ),
    );
  }
}


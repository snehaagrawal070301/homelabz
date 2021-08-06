import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:table_calendar/table_calendar.dart';
import 'appointmentScreen.dart';

class BookingChooseDate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookingChooseDateState();
  }
  
}

class BookingChooseDateState extends State<BookingChooseDate>{
  
  CalendarController _controller;
  @override
  void initState(){
    super.initState();
    _controller=CalendarController();
  }
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
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.68),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.18,
              color: Color(ColorValues.THEME_COLOR),   
          ),
            Positioned(
              left: 19,
              top:25,
               child:GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
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
                  child: Text("ASAP",style: TextStyle(fontFamily: "Regular",fontSize: 18,
                  color: Color(ColorValues.WHITE_COLOR)),textAlign: TextAlign.center,),
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
                width: MediaQuery.of(context).size.width*0.41,
                decoration: BoxDecoration(
                  color: Color(ColorValues.WHITE_COLOR),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("Chose Date",style: TextStyle(fontFamily: "Regular",fontSize: 18,
                  color: Color(ColorValues.THEME_COLOR)),textAlign: TextAlign.center,),
                ),
              ),
             ),
             ),
            Positioned(
              top:71,
              left: 20,
              right: 20,
              child: Container(
                height: MediaQuery.of(context).size.height*0.20,
                width: MediaQuery.of(context).size.width,
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
                child: TableCalendar( 
                  startDay: DateTime.now(),
                  
                  initialCalendarFormat: CalendarFormat.week,
                  calendarStyle: CalendarStyle(
                    highlightToday: false,
                    
                    holidayStyle: TextStyle(color: Color(ColorValues.BLACK_COLOR)),
                    weekdayStyle: TextStyle(color: Color(ColorValues.BLACK_COLOR)),
                    weekendStyle: TextStyle(color: Color(ColorValues.BLACK_COLOR)),
                    selectedColor: Color(ColorValues.THEME_COLOR),
                    selectedStyle: TextStyle(color: Color(ColorValues.WHITE_COLOR))
                  ),
                  headerStyle: HeaderStyle(
                    headerPadding: EdgeInsets.symmetric(vertical: 1),
                    titleTextStyle: TextStyle(color: Color(ColorValues.THEME_COLOR),fontFamily: "Regular",fontSize: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                      color: Color(ColorValues.LIGHT_GRAY)
                    ),
                    centerHeaderTitle: true,
                    formatButtonVisible: false,
                    ),
                    builders: CalendarBuilders(
                      dayBuilder: (context,date,events)=>
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xffF1F2F6),
                        ),
                        child: Center(
                          child: Text(date.day.toString(),
                          style: TextStyle(color: Color(ColorValues.BLACK_COLOR),fontSize: 17,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        ),
                      ),
                      selectedDayBuilder:(context,date,events)=>
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(ColorValues.THEME_COLOR),
                        ),
                        child: Center(
                          child: Text(date.day.toString(),
                          style: TextStyle(color: Color(ColorValues.WHITE_COLOR),fontSize: 17,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        ),
                      )
                    ),
                   onDaySelected:(date,events,context){
                     print(date.toString());
                   },
        /*firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        calendarFormat: _calendarFormat,
          onFormatChanged: (format) {
         setState(() {
          _calendarFormat = format;
  });
},*/ calendarController: _controller,
              
                ),
              ),
            ),
            Positioned(
              top:MediaQuery.of(context).size.height*0.35,
              left: 20,
              right: 20,
              child: Container(
                height: MediaQuery.of(context).size.height*0.36,
                width: MediaQuery.of(context).size.width,
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
                child: ListView(
                  children: [
                  Container(
                    height: 42,
                    color: Color(0xffF6F6F6),
                    child: Center(child: Text("Available Time",style: TextStyle(color: Color(ColorValues.THEME_COLOR),fontFamily: "Regular",fontSize: 16),textAlign: TextAlign.center,)),
                  ),
                ],),
              ),
            ),
            Positioned(
              bottom: 45,
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
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 38,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(ColorValues.THEME_COLOR),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text("CONTINUE",style: TextStyle(fontFamily: "Regular",fontSize: 15,
                      color: Color(ColorValues.WHITE_COLOR)),textAlign: TextAlign.center,),),
                ),
  
             ),
             ),
        ]),
      ),);
  }
}
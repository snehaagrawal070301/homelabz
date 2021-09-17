import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/Models/TimeSlot.dart';
import 'package:homelabz/Screens/bottomNavigationBar.dart';
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

  int index=-1;
  CalendarController _controller;
  List<TimeSlot> slots = [];


  @override
  void initState(){
    super.initState();
    _controller=CalendarController();
    fillDataInList();
  }

  void fillDataInList(){
    slots.add( TimeSlot("08:00","09:00"));
    slots.add( TimeSlot("09:00","10:00"));
    slots.add( TimeSlot("10:00","11:00"));
    slots.add( TimeSlot("11:00","12:00"));
    slots.add( TimeSlot("12:00","01:00"));
    slots.add( TimeSlot("01:00","02:00"));

    print(slots.length);
  }

  @override
  Widget build(BuildContext context) {
    String convertedDateTime;
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
                                child: Text("Chose Date",style: TextStyle(fontFamily: "Regular",fontSize: 18,
                                    color: Color(ColorValues.THEME_COLOR)),textAlign: TextAlign.center,),
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
                child: Column(
                  children: [
                    Container(
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
                        calendarController: _controller,
                         onDaySelected:(date,events,context){
                           //print(date.toString());
                           convertedDateTime ="${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                           print(convertedDateTime);
                         },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 26),
                      height: MediaQuery.of(context).size.height*0.33,
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
//                      child: Column(
//                        children: [
//                          Container(
//                            height: 42,
//                            color: Color(0xffF6F6F6),
//                            child: Center(child: Text("Available Time",style: TextStyle(color: Color(ColorValues.THEME_COLOR),fontFamily: "Regular",fontSize: 16),textAlign: TextAlign.center,)),
//                          ),
                          child:Container(
                            margin: EdgeInsets.all(30.0),
                          child:GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 18.0,
                                  childAspectRatio: MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height / 4),
                                ),

                                itemCount: slots.length,
                                itemBuilder: (BuildContext ctx, pos) {
                                  return GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      print(pos);
                                      index=pos;
                                     // CELL_COLOR= const Color(0xff21C8BE);
                                    });
                                    },
                                    child: index==pos?
                                    Container(
                                        width: 30,
                                        height: 20,
                                        decoration: BoxDecoration(
                                        color: Color(ColorValues.THEME_COLOR),
                                    borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Text(slots[pos].startTime,
                                    style: TextStyle(color: Color(ColorValues.WHITE_COLOR),fontSize: 12),),
                                    Text(" - ",
                                            style: TextStyle(color: Color(ColorValues.WHITE_COLOR),fontSize: 12),),
                                          Text(slots[pos].endTime,
                                            style: TextStyle(color: Color(ColorValues.WHITE_COLOR),fontSize: 12),)
                                        ],
                                      ),
                                    ):
                                    Container(
                                      width: 30,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Color(ColorValues.CELL_COLOR),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(slots[pos].startTime,
                                            style: TextStyle(color: Color(ColorValues.WHITE_COLOR),fontSize: 12),),
                                          Text(" - ",
                                            style: TextStyle(color: Color(ColorValues.WHITE_COLOR),fontSize: 12),),
                                          Text(slots[pos].endTime,
                                            style: TextStyle(color: Color(ColorValues.WHITE_COLOR),fontSize: 12),)
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          ),
                    GestureDetector(
                      onTap: (){
                        if(index==-1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AppointmentScreen(convertedDateTime,
                                          null)));
                        }
                        else{
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AppointmentScreen(convertedDateTime,
                                          slots[index].startTime)));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 26,left: 25,right: 25),
                        height: 40,
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
                        ],),
                    ),

                  ],
                ),
              ),
        ),
      bottomNavigationBar: BottomNavigation(),
      );
  }
}
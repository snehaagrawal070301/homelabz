import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/Models/TimeSlot.dart';
import 'package:homelabz/Screens/BookingUpdate.dart';
import 'package:homelabz/Screens/BookingsListScreen.dart';
import 'package:homelabz/Screens/AsapScreen.dart';
import 'package:homelabz/Screens/BottomNavBar.dart';
import 'package:homelabz/components/MyUtils.dart';
import 'package:homelabz/components/ColorValues.dart';
import 'package:homelabz/constants/Constants.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'BookingScreen.dart';

class CalData {
  String month, year, weekDay;
  DateTime day;

  CalData(this.month, this.year, this.weekDay, this.day);
}

class ChooseDateScreen extends StatefulWidget {
  final bool isEditBooking;
  final int bookingId;

  const ChooseDateScreen(this.isEditBooking, this.bookingId);

  @override
  State<StatefulWidget> createState() {
    return ChooseDateScreenState();
  }
}

class ChooseDateScreenState extends State<ChooseDateScreen> {
  int index = -1;
  CalendarController _controller;
  List<TimeSlot> slots = [];
  String todayDateTime =
      "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
  int temp;
  String convertedDateTime =
      "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
  DateTime today = DateTime.now();
  DateTime initialDay;
  DateTime endingDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  List<CalData> calDataList = [];

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    initialDay = dateTime.subtract(Duration(days: dateTime.weekday - 1));
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    endingDay =
        dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    fillDataInList();
    // prepareCalData();
    // print(findFirstDateOfTheWeek(today));
    // print(findLastDateOfTheWeek(today));
  }

  void fillDataInList() {
    DateTime today = DateTime.now();
    slots.add(TimeSlot("07:00", "08:00"));
    slots.add(TimeSlot("08:00", "09:00"));
    slots.add(TimeSlot("09:00", "10:00"));
    slots.add(TimeSlot("10:00", "11:00"));
    slots.add(TimeSlot("11:00", "12:00"));
    slots.add(TimeSlot("12:00", "13:00"));
    slots.add(TimeSlot("13:00", "14:00"));
    slots.add(TimeSlot("14:00", "15:00"));
    slots.add(TimeSlot("15:00", "16:00"));
    slots.add(TimeSlot("16:00", "17:00"));
    slots.add(TimeSlot("17:00", "18:00"));
    slots.add(TimeSlot("18:00", "19:00"));

    print(slots.length);
  }

  void prepareCalData() {
    DateTime today = DateTime.now();
    print(today.month.toString());
    print(today.year.toString());
    print(today.weekday.toString());
    print(today);
    for(int i=0; i<=6;i++) {
      DateTime today = DateTime.now().add(Duration(days:i));
      calDataList.add(CalData(today.month.toString(), today.year.toString(), today.weekday.toString(), today));
      print(calDataList.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorValues.WHITE_COLOR),
      appBar: AppBar(
        backgroundColor: Color(ColorValues.WHITE_COLOR),
        leading: IconButton(
          icon: ImageIcon(
            AssetImage('assets/images/back_arrow.png'),
            color: Color(ColorValues.THEME_COLOR),
            size: 20,
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => BookingsListScreen()));
          },
        ),
        title: Text(
          "Booking",
          style: TextStyle(
              fontFamily: "Regular",
              fontSize: 18,
              color: Color(ColorValues.THEME_COLOR)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height ,
          color: Color(ColorValues.WHITE_COLOR),
          child: Stack(
            children: [
              Container(
                // height: MediaQuery.of(context).size.height*0.18,
                width: MediaQuery.of(context).size.width,
                color: Color(ColorValues.THEME_COLOR),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 25, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.41,
                          decoration: BoxDecoration(
                            color: Color(ColorValues.WHITE_COLOR),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Choose Date",
                              style: TextStyle(
                                  fontFamily: "Regular",
                                  fontSize: 18,
                                  color: Color(ColorValues.THEME_COLOR)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AsapScreen(widget.isEditBooking, widget.bookingId)));
                        },
                        child: Container(
                          height: 36,
                          width: MediaQuery.of(context).size.width * 0.41,
                          decoration: BoxDecoration(
                            color: Color(ColorValues.THEME_COLOR),
                            border: Border.all(
                                color: Color(ColorValues.WHITE_COLOR)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "ASAP",
                              style: TextStyle(
                                  fontFamily: "Regular",
                                  fontSize: 18,
                                  color: Color(ColorValues.WHITE_COLOR)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 75,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(ColorValues.WHITE_COLOR),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                              spreadRadius: 0.5,
                            )
                          ]),
                      child: TableCalendar(
//                          calendarFormat: _calendarFormat,
//                          onFormatChanged: (format) {
//                            setState(() {
//                              _calendarFormat = format;
//                            });
//                          },
                        availableGestures: AvailableGestures.none,
                        startDay: DateTime.now(),
                        //for end day
                        // endDay: endingDay,
                        initialCalendarFormat: _calendarFormat,
                        calendarStyle: CalendarStyle(
                            highlightToday: false,
                            holidayStyle: TextStyle(
                                color: Color(ColorValues.BLACK_COLOR)),
                            weekdayStyle: TextStyle(
                                color: Color(ColorValues.BLACK_COLOR)),
                            weekendStyle: TextStyle(
                                color: Color(ColorValues.BLACK_COLOR)),
                            selectedColor: Color(ColorValues.THEME_COLOR),
                            selectedStyle: TextStyle(
                                color: Color(ColorValues.WHITE_COLOR))),
                        headerStyle: HeaderStyle(
                          //formatButtonShowsNext: false,
                          //for left right arrow
                          leftChevronVisible: true,
                          rightChevronVisible: true,
                          headerPadding: EdgeInsets.symmetric(vertical: 5),
                          titleTextStyle: TextStyle(
                              color: Color(ColorValues.THEME_COLOR),
                              fontFamily: "Regular",
                              fontSize: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)),
                              color: Color(ColorValues.LIGHT_GRAY)),
                          centerHeaderTitle: true,
                          formatButtonVisible: false,
                        ),
                        onDaySelected: (date, events, e) {
                          setState(() {
                            index=-1;
                          });
                          print(date.toUtc());
                          convertedDateTime =
                              "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                          print(convertedDateTime);
                        },
                        builders: CalendarBuilders(
                            dayBuilder: (context, date, events) => Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF1F2F6),
                                  ),
                                  child: Center(
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(
                                          color: Color(ColorValues.BLACK_COLOR),
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            selectedDayBuilder: (context, date, events) =>
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Color(ColorValues.THEME_COLOR),
                                  ),
                                  child: Center(
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(
                                          color: Color(ColorValues.WHITE_COLOR),
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )),
                        calendarController: _controller,
                        // onDaySelected: (date, events, context) {
                        //   print(date.toString());
                        //   convertedDateTime =
                        //       "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                        //   print(convertedDateTime);
                        // },
                      ),
                    ),

                    Container(
                        margin: EdgeInsets.only(top: 25),
                        // height: MediaQuery.of(context).size.height * 0.33,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Color(ColorValues.WHITE_COLOR),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                                spreadRadius: 0.5,
                              )
                            ]),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 42,
                                color: Color(0xffF6F6F6),
                                child: Center(
                                    child: Text(
                                  "Available Time",
                                  style: TextStyle(
                                      color: Color(ColorValues.THEME_COLOR),
                                      fontFamily: "Regular",
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              Container(
                                margin: EdgeInsets.all(20.0),
                                height: MediaQuery.of(context).size.height * 0.35,
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 18.0,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              4),
                                    ),
                                    shrinkWrap: true,
                                    primary: false,
                                    scrollDirection: Axis.vertical,
                                    itemCount: slots.length,
                                    itemBuilder: (BuildContext ctx, pos) {
                                      return 1 == validateSlot(convertedDateTime, slots[pos].startTime + ":00")
                                          ? GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  print(pos);
                                                  index = pos;
                                                  // CELL_COLOR= const Color(0xff21C8BE);
                                                });
                                              },
                                              child: index == pos
                                                  ? Container(
                                                      width: 30,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              ColorValues
                                                                  .THEME_COLOR),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            slots[pos]
                                                                .startTime,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    ColorValues
                                                                        .WHITE_COLOR),
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            " - ",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    ColorValues
                                                                        .WHITE_COLOR),
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            slots[pos].endTime,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    ColorValues
                                                                        .WHITE_COLOR),
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 30,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              ColorValues
                                                                  .CELL_COLOR),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            slots[pos]
                                                                .startTime,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    ColorValues
                                                                        .WHITE_COLOR),
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            " - ",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    ColorValues
                                                                        .WHITE_COLOR),
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            slots[pos].endTime,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    ColorValues
                                                                        .WHITE_COLOR),
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                            )
                                          : Container(
                                              width: 30,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color: Color(ColorValues
                                                          .CELL_COLOR)
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    slots[pos].startTime,
                                                    style: TextStyle(
                                                        color: Color(ColorValues
                                                            .WHITE_COLOR),
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    " - ",
                                                    style: TextStyle(
                                                        color: Color(ColorValues
                                                            .WHITE_COLOR),
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    slots[pos].endTime,
                                                    style: TextStyle(
                                                        color: Color(ColorValues
                                                            .WHITE_COLOR),
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                            );
                                    }),
                              ),
                            ])),
                    GestureDetector(
                      onTap: () {
                        //call booking Screen here
                        callBookingScreen();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 30, left: 25, right: 25, bottom: 20),
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(ColorValues.THEME_COLOR),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "CONTINUE",
                            style: TextStyle(
                                fontFamily: "Regular",
                                fontSize: 15,
                                color: Color(ColorValues.WHITE_COLOR)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(""),
    );
  }

  // void showToast(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.CENTER,
  //     timeInSecForIosWeb: 1,
  //   );
  // }

  void callBookingScreen() {
    if (convertedDateTime == null) {
      convertedDateTime =
          "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
      print(convertedDateTime);
    }

    if (index == -1) {
      // Navigator.push(context, MaterialPageRoute(
      //         builder: (context) => AppointmentScreen(convertedDateTime, null)));
      MyUtils.showCustomToast(Constants.SLOT_VALIDATION, true, context);
      // showToast("Please choose slot!");
    } else {
      String startTime = slots[index].startTime + ":00";
      String endTime = slots[index].endTime + ":00";
      if (widget.isEditBooking) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BookingUpdate(widget.bookingId,convertedDateTime, startTime, endTime)));
      }else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BookingScreen(convertedDateTime, startTime, endTime)));
      }
    }
  }

  int validateSlot(String time, String slot) {
    // validate slot time with current time
    if (convertedDateTime == null) {
      convertedDateTime =
          "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
      print(convertedDateTime);
    }
    String input = convertedDateTime + " " + slot;
    DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(input);
    DateTime currentDateTime = DateTime.now();

    if (tempDate.compareTo(currentDateTime) == 1) {
      return 1;
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => BookingScreen(convertedDateTime, slot,slot)));
    } else {
      return 0;
//      showToast("You can not select past time!");
    }
  }
}

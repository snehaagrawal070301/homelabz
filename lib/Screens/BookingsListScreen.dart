import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homelabz/Models/BookingListResponse.dart';
import 'package:homelabz/Screens/BookingDetails.dart';
import 'package:homelabz/Screens/ChooseDateScreen.dart';
import 'package:homelabz/Screens/MyDrawer.dart';
import 'package:homelabz/Screens/NotificationScreen.dart';
import 'package:homelabz/Screens/BottomNavBar.dart';
import 'package:homelabz/components/ColorValues.dart';
import 'package:homelabz/constants/Constants.dart';
import 'package:homelabz/constants/ValidationMsgs.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:homelabz/components/MyUtils.dart';

class BookingsListScreen extends StatefulWidget {
  @override
  _BookingsListScreenState createState() => _BookingsListScreenState();
}

class _BookingsListScreenState extends State<BookingsListScreen> {
  SharedPreferences preferences;
  List<UpcomingBookingList> _list;
  BookingListResponse _model;
  var isData = true;

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    callBookingList();
  }

  Future<void> callBookingList() async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();

    try {
      setState(() {
        isData = true;
      });

      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.BOOKING_LIST_BY_CRITERIA);
      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH:
            "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };
      Map map = {
        Constants.PATIENT_ID: preferences.getString(Constants.ID),
        Constants.LIST_TYPE: ["UPCOMING"],
      };
      // make POST request
      var response =
          await _ioClient.post(url, headers: headers, body: json.encode(map));
      // check the status code for the result
      String body = response.body;
      print(body);

      if (response.statusCode == 200) {
        _list = [];
        _model = BookingListResponse.fromJson(json.decode(body));
        _list.addAll(_model.upcomingBookingList);

        setState(() {
          isData = true;
        });
      }else{
        setState(() {
          isData = false;
        });
        var data = json.decode(body);
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
      await dialog.hide();

    } catch (ex) {
      setState(() {
        isData = true;
      });
      await dialog.hide();
    }
  }

  String getDayDateMonth(String inputDate) {
    // String to date
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(inputDate);
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    final String formatted = formatter.format(tempDate);
    return formatted;
  }

  void onConfirmed() {
    // Fluttertoast.showToast(
    //   msg: "clicked!",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.CENTER,
    //   timeInSecForIosWeb: 1,
    // );
  }

  showPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: 300,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel))
                      ],
                    ),
                    Image(
                        image: AssetImage(
                            "assets/images/call_appointment.png"))
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(ColorValues.WHITE_COLOR),
        appBar: AppBar(
          backgroundColor: Color(ColorValues.WHITE_COLOR),
          leading: Builder(
            builder: (context) => IconButton(
              icon: ImageIcon(
                AssetImage('assets/images/drawer.png'),
                color: Color(ColorValues.THEME_TEXT_COLOR),
                size: 50,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Text(
            "Make an Appointment",
            style: TextStyle(
                fontFamily: "Regular",
                fontSize: 18,
                color: Color(ColorValues.THEME_COLOR)),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Color(ColorValues.THEME_COLOR),
              ),
              onPressed: () {
                // call notification screen here
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => NotificationScreen()));
              },
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(clipBehavior: Clip.none, children: [
            Container(
              color: Color(ColorValues.THEME_COLOR),
              child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  color: Color(ColorValues.THEME_COLOR),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseDateScreen()));
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.50,
                          decoration: BoxDecoration(
                            color: Color(ColorValues.WHITE_COLOR),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "BOOK APPOINTMENT",
                              style: TextStyle(
                                  fontFamily: "Regular",
                                  fontSize: 12,
                                  color: Color(ColorValues.THEME_COLOR)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Positioned(
              top: 80,
              left: 10,
              right: 10,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(ColorValues.WHITE_COLOR),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 7.0,
                        spreadRadius: 1.0,
                      )
                    ]),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      _list == null ? "" : "Upcoming Appointments",
                      style: TextStyle(
                          color: Color(ColorValues.BLACK_COLOR),
                          fontSize: 14,
                          fontFamily: "Regular"),
                    )),
              ),
            ),
            Positioned(
              top: 120,
              left: 15,
              right: 15,
              bottom: 5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder<List<UpcomingBookingList>>(
                    builder: (BuildContext context, AsyncSnapshot<List<UpcomingBookingList>> snapshot) {
                  if (_list != null && _list.length > 0) {
                    return RefreshIndicator(
                      onRefresh: callBookingList,
                          child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              // physics: const ScrollPhysics(),
                              // shrinkWrap: true,
                              itemCount: _list.length,
                              itemBuilder: (BuildContext context, int pos) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BookingDetails(_list[pos].id)));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 10, 15, 20),
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(15),
                                              height: 22,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width * 0.4,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff21C07D),
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              child: Center(
                                                  child: GestureDetector(
                                                onTap: () {
//                                                  onConfirmed();
//                                                  showPopup(context);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                                  child: Text(
                                                    _list[pos].bookingStatus == null
                                                        ? ""
                                                        : _list[pos].bookingStatus,
                                                    // "Confirmed",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color(
                                                            ColorValues.WHITE_COLOR),
                                                        fontFamily: "Regular"),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              )),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  child: Image(
                                                    height: 60,
                                                    width: 60,
                                                    image: AssetImage(
                                                        "assets/images/profile_pic.png"),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 7.55),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          child: Text(
                                                        // "Union Laboratory",
                                                        _list[pos].lab.user.name,
                                                        style: TextStyle(
                                                            color: Color(ColorValues
                                                                .THEME_COLOR),
                                                            fontFamily: "Regular",
                                                            fontSize: 14),
                                                      )),
                                                      Row(
                                                        children: [
                                                          Image(
                                                              image: AssetImage(
                                                                  "assets/images/star.png"),
                                                              height: 9,
                                                              width: 50),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                            "(47)",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Regular",
                                                                fontSize: 10,
                                                                color: Color(ColorValues
                                                                    .LIGHT_TEXT_COLOR)),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: Text(
                                                "\$" + _list[pos].amount.toString(),
                                                //r"$ 50",

                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: Color(
                                                        ColorValues.THEME_COLOR),
                                                    fontFamily: "Regular"),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 14.55),
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/dashedLine.png"),
                                              width: 270,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                        _list[pos].date == null?
                                            Container(
                                                margin: EdgeInsets.fromLTRB(30,15,10,20),
                                              decoration: BoxDecoration(
                                                  color: Color(ColorValues.GRAY_BG),
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                                              ),
                                                child:Container(
                                                  margin: EdgeInsets.fromLTRB(30,15,10,20),
                                                    child: Text(ValidationMsgs.PHLEBOTOMIST_MSG,
                                                      style:TextStyle(
                                                          color: Color(ColorValues.BLACK_COL),
                                                          fontSize: 14,))))
                                        :Container(
                                          margin: EdgeInsets.only(
                                              top: 20, left: 30, bottom: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // _list[pos].isASAP == true ?

                                              _list[pos].date == null
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          // height: 70,
                                                          width: 35,
                                                          color: Color(
                                                              ColorValues.DATE_BG),
                                                          child: Text(
                                                            "A\nS\nA\nP",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    ColorValues
                                                                        .THEME_COLOR),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            textAlign:
                                                                TextAlign.center,
                                                          ))
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                  5, 10, 5, 10),
                                                          width: 45,
                                                          // height: 85,
                                                          color: Color(
                                                              ColorValues.DATE_BG),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  MyUtils.getDayOfWeek("${_list[pos].date}"),
                                                                  // "TUE",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          ColorValues
                                                                              .LIGHT_TEXT_COLOR),
                                                                      fontSize: 11),
                                                                ),
                                                                Text(
                                                                  MyUtils.getDateOfMonth("${_list[pos].date}"),
                                                                  // "25",
                                                                  style: TextStyle(
                                                                      fontSize: 21,
                                                                      color: Color(
                                                                          0xff21CDC0),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  MyUtils.getMonthName("${_list[pos].date}"),
                                                                  // "Feb",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          ColorValues
                                                                              .LIGHT_TEXT_COLOR),
                                                                      fontSize: 11),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                  // : Container(
                                                  //     padding: EdgeInsets.fromLTRB(
                                                  //         5, 10, 5, 10),
                                                  //     width: 45,
                                                  //     // height: 85,
                                                  //     color: Color(
                                                  //         ColorValues.DATE_BG),
                                                  //     child: Center(
                                                  //       child: Column(
                                                  //         mainAxisAlignment:
                                                  //             MainAxisAlignment
                                                  //                 .center,
                                                  //         crossAxisAlignment:
                                                  //             CrossAxisAlignment
                                                  //                 .center,
                                                  //         children: [
                                                  //           Text(
                                                  //             MyUtils.getDayOfWeek("${_list[pos].date}"),
                                                  //             // "TUE",
                                                  //             style: TextStyle(
                                                  //                 color: Color(
                                                  //                     ColorValues
                                                  //                         .LIGHT_TEXT_COLOR),
                                                  //                 fontSize: 12),
                                                  //           ),
                                                  //           Text(
                                                  //             MyUtils.getDateOfMonth("${_list[pos].date}"),
                                                  //             // "25",
                                                  //             style: TextStyle(
                                                  //                 fontSize: 22,
                                                  //                 color: Color(
                                                  //                     0xff21CDC0),
                                                  //                 fontWeight:
                                                  //                     FontWeight
                                                  //                         .bold),
                                                  //           ),
                                                  //           Text(
                                                  //             MyUtils.getMonthName("${_list[pos].date}"),
                                                  //             // "Feb",
                                                  //             style: TextStyle(
                                                  //                 color: Color(
                                                  //                     ColorValues
                                                  //                         .LIGHT_TEXT_COLOR),
                                                  //                 fontSize: 12),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 0, horizontal: 7),
                                                  height: 67,
                                                  child: VerticalDivider(
                                                      color:
                                                          Color(ColorValues.GREY))),

                                              _list[pos].phlebotomist == null
                                                  ? Expanded(
                                                    child: Container(
                                                    margin: EdgeInsets.fromLTRB(2,5,15,10),
                                                    decoration: BoxDecoration(
                                                        color: Color(ColorValues.GRAY_BG),
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                    ),
                                                    child:Container(
                                                        margin: EdgeInsets.fromLTRB(15,15,10,20),
                                                        child: Text(ValidationMsgs.PHLEBOTOMIST_MSG,
                                                            style:TextStyle(
                                                              color: Color(ColorValues.BLACK_COL),
                                                              fontSize: 14,)))),
                                                  )
                                                  : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _list[pos].phlebotomist ==
                                                              null
                                                          ? "Phlebotomist"
                                                          : _list[pos]
                                                                      .phlebotomist
                                                                      .name ==
                                                                  null
                                                              ? "Phlebotomist"
                                                              : _list[pos]
                                                                  .phlebotomist
                                                                  .name,
                                                      // "Phelbotomist Name",
                                                      style: TextStyle(
                                                          color: Color(ColorValues
                                                              .BLACK_TEXT_COL),
                                                          fontFamily: "Regular",
                                                          fontSize: 13),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, bottom: 10),
                                                      child: Row(
                                                        children: [
                                                          Image(
                                                              image: AssetImage(
                                                                  "assets/images/clock.png"),
                                                              height: 17,
                                                              width: 17),
                                                          SizedBox(
                                                            width: 7,
                                                          ),
                                                          Text(
                                                              _list[pos].timeFrom ==
                                                                      null
                                                                  ? "--:-- "
                                                                  :
                                                              MyUtils.changeTimeFormat("${_list[pos].timeFrom}"),
                                                              // "04:00PM",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Regular",
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xff3D4461),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      "Change Date & Time",
                                                      style: TextStyle(
                                                          color: Color(0xff21CDC0),
                                                          fontFamily: "Regular",
                                                          fontSize: 12),
                                                    ),
                                                  ]),

                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                  } else {
                    return Center(
                      child:  isData? new Container(
                        child: Center(
                          child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Image(
                                    height: 250,
                                    width: 200,
                                    image: AssetImage("assets/images/Nodatafound.jpg"),
                                  ),
                                ),
                                Text("No data available!"),
                              ]),
                        ),
                      ): new Container(),
                    );
                  }
                }),
              ),
            ),
          ]),
        ),
//      bottomNavigationBar: ConvexAppBar(
//          color: Color(ColorValues.THEME_COLOR),
//          backgroundColor: Color(ColorValues.THEME_COLOR),
//          items: [
//            TabItem(icon: Icons.home, title: "Home"),
//          ]),
        bottomNavigationBar: BottomNavBar(""),
        drawer: MyDrawer(),
      ),
    );
  }

}

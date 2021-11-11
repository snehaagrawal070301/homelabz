import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homelabz/Screens/BottomNavBar.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:homelabz/constants/ConstantMsg.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class CallForBooking extends StatefulWidget {
  @override
  _CallForBookingState createState() => _CallForBookingState();
}

class _CallForBookingState extends State<CallForBooking> {
  String _url = 'tel:+919876543210';

//  var newString = _url.substring(0, 5);

  @override
  void initState() {
    super.initState();
    callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(ColorValues.WHITE_COLOR),
        leading: IconButton(
          icon: ImageIcon(
            AssetImage('assets/images/back_arrow.png'),
            color: Color(ColorValues.THEME_COLOR),
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Call for Appointment",
          style: TextStyle(
              fontFamily: "Regular",
              fontSize: 18,
              color: Color(ColorValues.THEME_COLOR)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Image(
                image: AssetImage("assets/images/call_appointment.png"),
                height: MediaQuery.of(context).size.height * 0.27,
                width: MediaQuery.of(context).size.width * 0.66,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 38, right: 38),
              height: MediaQuery.of(context).size.height * 0.19,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(ColorValues.WHITE_COLOR),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 7.0,
                      spreadRadius: 0,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "To book appointment call on the\nToll Free Number",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(ColorValues.BLACK_COLOR),
                          fontFamily: "Medium"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Tel:  +919876543210",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(ColorValues.BLACK_COLOR),
                          fontFamily: "Black"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _launchURL,
              child: Container(
                  margin: EdgeInsets.only(top: 45, right: 30, left: 30),
                  height: 38,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color(ColorValues.THEME_COLOR),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "CALL        ",
                        style: TextStyle(
                            fontFamily: "Regular",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(ColorValues.WHITE_COLOR)),
                        textAlign: TextAlign.center,
                      ),
                      Image(
                        image: AssetImage("assets/images/contact.png"),
                        color: Color(ColorValues.WHITE_COLOR),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
//      bottomNavigationBar: BottomNavigation(),
    );
//    return Scaffold(
//        backgroundColor: Color(ColorValues.WHITE_COLOR),
//    appBar: AppBar(
//    backgroundColor: Color(ColorValues.WHITE_COLOR),
//    leading: IconButton(
//    icon: Icon(
//    Icons.arrow_back,
//    color: Color(ColorValues.THEME_COLOR),
//    ),
//    onPressed: () {
//    Navigator.pop(context);
//    },
//    ),
//    title: Text(
//    "Call for Appointment",
//    style: TextStyle(
//    fontFamily: "Regular",
//    fontSize: 18,
//    color: Color(ColorValues.THEME_COLOR)),
//    ),
//    ),
//    body: SingleChildScrollView(
//      child: Column(
//          mainAxisSize: MainAxisSize.max,
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            Container(
//                width: MediaQuery.of(context).size.width,
//                height: 250.0,
//                color: Colors.transparent,
//                child: Container(
//                    width: MediaQuery.of(context).size.width,
//                    decoration: BoxDecoration(
//                        color: const Color(ColorValues.THEME_TEXT_COLOR),
//                        borderRadius: BorderRadius.only(
//                            bottomLeft: Radius.circular(25.0),
//                            bottomRight: Radius.circular(25.0))),
//                    child: Row(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Expanded(
//                            flex: 5,
//                            child: Padding(
//                                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
//                                child: new Padding(
//                                  padding: EdgeInsets.fromLTRB(
//                                      10.0, 0.0, 0.0, 0.0),
//                                  child: new Wrap(
//                                    children: [
//                                      new Container(
//                                        margin: EdgeInsets.fromLTRB(
//                                            5.0, 5.0, 0.0, 3.0),
//                                        alignment: Alignment.centerLeft,
//                                        child: Text(
//                                          'Welcome To...',
//                                          style: TextStyle(
//                                            color: Color(ColorValues.WHITE),
//                                            fontSize: 22.0,
//                                          ),
//                                        ),
//                                      ),
//                                      new Container(
//                                          margin: EdgeInsets.fromLTRB(
//                                              5.0, 0.0, 0.0, 5.0),
//                                          alignment: Alignment.centerLeft,
//                                          child: Align(
//                                            alignment: Alignment.centerLeft,
//                                            child: Text(
//                                              'Homelabs',
//                                              textAlign: TextAlign.left,
//                                              style: TextStyle(
//                                                color:
//                                                Color(ColorValues.WHITE),
//                                                fontSize: 16.0,
//                                                fontFamily: "customLight",
//                                              ),
//                                            ),
//                                          ))
//                                    ],
//                                  ),
//                                )),
//                          ),
//                          //Add image here
//                          Expanded(
//                              flex: 5,
//                              child: Padding(
//                                  padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
//                                  child: Image.asset(
//                                    'assets/images/signin_icon.png',
//                                  )))
//                        ]))),
//            Container(
//                padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
//                child: Align(
//                    alignment: Alignment.centerLeft,
//                    child: new Text(
//                      "Toll Free Number",
//                      style: TextStyle(
//                          color: const Color(ColorValues.THEME_TEXT_COLOR),
//                          fontSize: 18,
//                          fontWeight: FontWeight.bold),
//                    ))),
//            Container(
//              padding: EdgeInsets.only(left: 20),
//                child: Align(
//                    alignment: Alignment.centerLeft,
//                    child:Text("number",style: TextStyle(fontSize: 16),)
//                )
//            ),
//            Container(
//              margin: EdgeInsets.only(top:50),
//                  height: 35,
//                  width: 150,
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(10),
//                    color: Color(ColorValues.THEME_TEXT_COLOR),
//                  ),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//                      TextButton(
//                        child: Text(
//                          "CALL",
//                          style: TextStyle(
//                              fontSize: 16,
//                              fontFamily: "Regular",
//                              fontWeight: FontWeight.w700,
//                              color: Colors.white),
//                        ),
//                        onPressed:_launchURL,
//                      ),
//                      Image(
//                        image: AssetImage("assets/images/contact.png"),
//                        color: Color(ColorValues.WHITE_COLOR),
//                      )
//                    ],
//                  ),
//                ),
//
//          ]),
//    ),
//    );
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void callApi() async {
    try {
      var url = Uri.parse(ApiConstants.CALL_API);
      Map<String, String> headers = {
        ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
      };
      // make POST request
      Response response = await get(
        url,
        headers: headers,
      );
      // check the status code for the result
      String body = response.body;
      print(body);
//      var data = json.decode(body);
//      print(data);
      if (response.statusCode == 200) {
        print("success");
//        _labs = [];
//        LabResponse model = LabResponse.fromJson(json.decode(body));
//        _labs.add(model);
      }
    } catch (ex) {
      print("ERROR+++++++++++++  ${ex}");
    }
  }
}

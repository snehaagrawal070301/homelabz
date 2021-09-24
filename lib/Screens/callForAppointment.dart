import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:homelabz/constants/ConstantMsg.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class CallforAppointment extends StatefulWidget {
  @override
  _CallforAppointmentState createState() => _CallforAppointmentState();
}

class _CallforAppointmentState extends State<CallforAppointment> {
  String _url= 'tel:+919827510000';
  @override
  void initState(){
    super.initState();
    callApi();
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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                height: 250.0,
                color: Colors.transparent,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(ColorValues.THEME_TEXT_COLOR),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0))),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: new Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: new Wrap(
                                    children: [
                                      new Container(
                                        margin: EdgeInsets.fromLTRB(
                                            5.0, 5.0, 0.0, 3.0),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Welcome To...',
                                          style: TextStyle(
                                            color: Color(ColorValues.WHITE),
                                            fontSize: 22.0,
                                          ),
                                        ),
                                      ),
                                      new Container(
                                          margin: EdgeInsets.fromLTRB(
                                              5.0, 0.0, 0.0, 5.0),
                                          alignment: Alignment.centerLeft,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Homelabs',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:
                                                Color(ColorValues.WHITE),
                                                fontSize: 16.0,
                                                fontFamily: "customLight",
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                )),
                          ),
                          //Add image here
                          Expanded(
                              flex: 5,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
                                  child: Image.asset(
                                    'assets/images/signin_icon.png',
                                  )))
                        ]))),
            Container(
                padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      "Toll Free Number",
                      style: TextStyle(
                          color: const Color(ColorValues.THEME_TEXT_COLOR),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ))),
            Container(
              padding: EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child:Text("number",style: TextStyle(fontSize: 16),)
                )
            ),
            Container(
              margin: EdgeInsets.only(top:50),
                  height: 35,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(ColorValues.THEME_TEXT_COLOR),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(
                          "CALL",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        onPressed:_launchURL,
                      ),
                      Image(
                        image: AssetImage("assets/images/contact.png"),
                        color: Color(ColorValues.WHITE_COLOR),
                      )
                    ],
                  ),
                ),

          ]),
    ),
    );
  }
  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

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

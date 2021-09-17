import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:homelabz/constants/ConstantMsg.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _dob = new TextEditingController();
  TextEditingController _education = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  bool _flag = false;

  SharedPreferences preferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    _name.text = preferences.getString(ConstantMsg.NAME);
    _phone.text = preferences.getString(ConstantMsg.MOBILE_NUM);
    _dob.text = preferences.getString(ConstantMsg.DOB);
    _education.text = preferences.getString(ConstantMsg.EDUCATION);
    _address.text = preferences.getString(ConstantMsg.ADDRESS);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorValues.THEME_TEXT_COLOR),
      body: SingleChildScrollView(
        child: Stack(clipBehavior: Clip.none, children: [
          // Container(
          //   alignment: Alignment.center,
          //   child: Text("Profile"),
          // ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: const Color(ColorValues.WHITE),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0))),
          ),
          Positioned(
            top:70,
            left: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/images/profile_pic.png'),
            ),
          ),
          Positioned(
              top: 140,
              left: 70,
              right: 0,
              child: InkWell(
                  onTap: () {
                    changeProfilePic();
                  },
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/images/Camera.png'),
                  ))),
          Positioned(
            top: 150,
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: Container(
                margin: EdgeInsets.fromLTRB(40, 50, 40, 50),
                decoration: BoxDecoration(
                  color: Color(ColorValues.WHITE),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 7.0, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _name,
                          onEditingComplete: () {
                            _flag = true;
                          },
                          autofocus: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "Regular",
                            color: Color(ColorValues.BLACK_TEXT_COL),
                          ),
                          decoration: new InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              fontSize: 12,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w700,
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            icon: ImageIcon(
                              AssetImage("assets/images/user_name.png"),
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 10,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w400,
                              color: Color(ColorValues.BLACK_TEXT_COL),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _phone,
                          onEditingComplete: () {
                            _flag = true;
                          },
                          autofocus: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "Regular",
                            color: Color(ColorValues.BLACK_TEXT_COL),
                          ),
                          decoration: new InputDecoration(
                            labelText: 'Phone',
                            labelStyle: TextStyle(
                              fontSize: 12,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w700,
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            icon: ImageIcon(
                              AssetImage("assets/images/contact.png"),
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 10,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w400,
                              color: Color(ColorValues.BLACK_TEXT_COL),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _dob,
                          onEditingComplete: () {
                            _flag = true;
                          },
                          autofocus: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "Regular",
                            color: Color(ColorValues.BLACK_TEXT_COL),
                          ),
                          decoration: new InputDecoration(
                            labelText: 'Date of Birth',
                            labelStyle: TextStyle(
                              fontSize: 12,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w700,
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            icon: ImageIcon(
                              AssetImage("assets/images/calendar.png"),
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 10,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w400,
                              color: Color(ColorValues.BLACK_TEXT_COL),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _education,
                          onEditingComplete: () {
                            _flag = true;
                          },
                          autofocus: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "Regular",
                            color: Color(ColorValues.BLACK_TEXT_COL),
                          ),
                          decoration: new InputDecoration(
                            labelText: 'Education',
                            labelStyle: TextStyle(
                              fontSize: 12,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w700,
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            icon: ImageIcon(
                              AssetImage("assets/images/eduction.png"),
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 10,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w400,
                              color: Color(ColorValues.BLACK_TEXT_COL),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _address,
                          onEditingComplete: () {
                            _flag = true;
                          },
                          autofocus: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "Regular",
                            color: Color(ColorValues.BLACK_TEXT_COL),
                          ),
                          decoration: new InputDecoration(
                            labelText: 'Address',
                            labelStyle: TextStyle(
                              fontSize: 12,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w700,
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            icon: ImageIcon(
                              AssetImage("assets/images/location.png"),
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 10,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w400,
                              color: Color(ColorValues.BLACK_TEXT_COL),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(ColorValues.THEME_TEXT_COLOR),
                        ),
                        child: TextButton(
                          onPressed: () {
                            updateUserDetails();
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Color(ColorValues.WHITE), fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ]),
      ),
    );
  }

  void changeProfilePic() {
    print("camera clicked");
  }

  Future<void> updateUserDetails() async {
    // if (_flag == true) {
    try {
      print("body+++++");
      var url = Uri.parse(ApiConstants.UPDATE_USER_DETAILS);
      Map<String, String> headers = {
        ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
        ConstantMsg.HEADER_AUTH: "bearer 21238666-9347-4557-ab21-8b272e601621",
        // ConstantMsg.HEADER_AUTH: "bearer "+ preferences.getString(ConstantMsg.ACCESS_TOKEN)!.trim().toString(),
      };
      Map map = {
        ConstantMsg.ID: preferences.getString(ConstantMsg.ID),
        ConstantMsg.NAME: _name.text,
        // ConstantMsg.MOBILE_NUM: _phone.text,
        ConstantMsg.MOBILE_NUM: 3333333301,
        ConstantMsg.DOB: _dob.text,
        ConstantMsg.EDUCATION: _education.text,
        ConstantMsg.ADDRESS: _address.text,
      };
      // make POST request
      Response response =
      await post(url, headers: headers, body: json.encode(map));
      // check the status code for the result
      String body = response.body;

      var data = json.decode(body);

      print(data);
    } catch (ex) {
      print("Error+++++" + ex.toString());
    }
    // }
  }
}
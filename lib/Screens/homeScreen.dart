import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homelabz/Models/ErrorModel.dart';
import 'package:homelabz/Screens/MakeAppointmentScreen.dart';
import 'package:homelabz/Screens/bottomNavigationBar.dart';
import 'package:homelabz/Screens/callForAppointment.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:homelabz/constants/ConstantMsg.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  TextEditingController name = TextEditingController();
  // String mobile;
  TextEditingController mobileController = TextEditingController();
  TextEditingController otp = TextEditingController();
  SharedPreferences preferences;
  String mobile;

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorValues.THEME_COLOR),
      appBar: AppBar(
        backgroundColor: Color(ColorValues.THEME_COLOR),
        elevation: 0,
        title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Expanded(flex:2,child: Image(image: AssetImage('assets/images/Menu.png'),height: 15.7,width: 26,)),
                  Expanded(
                    flex: 10,
                    child: Text(
                      "Welcome to HomeLabz!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(ColorValues.WHITE_COLOR),
                        fontFamily: "Regular",
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        //call Profile Screen\
                        showToast("clicked");
                      },
                      child: Image(
                        image: AssetImage('assets/images/profile.png'),
                        height: 44,
                        width: 44,
                      ),
                    ),
                  ),
                ],)
        ),
      body:
      // SingleChildScrollView(
      //   child:
        Stack(children: [
          Positioned(
            top:MediaQuery.of(context).size.height * 0.125,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Color(ColorValues.WHITE_COLOR),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0))),
            ),
          ),
          // Positioned(
          //   left: 5,
          //   top: 5,
          //   width: MediaQuery.of(context).size.width,
          //   height: 100,
          //   child: Container(
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           //Expanded(flex:2,child: Image(image: AssetImage('assets/images/Menu.png'),height: 15.7,width: 26,)),
          //           Expanded(
          //             flex: 10,
          //             child: Text(
          //               "Welcome to HomeLabz!",
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 color: Color(ColorValues.WHITE_COLOR),
          //                 fontFamily: "Regular",
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 18.0,
          //               ),
          //             ),
          //           ),
          //           Expanded(
          //             flex: 2,
          //             child: GestureDetector(
          //               onTap: () {},
          //               child: Image(
          //                 image: AssetImage('assets/images/profile.png'),
          //                 height: 44,
          //                 width: 44,
          //               ),
          //             ),
          //           ),
          //         ],
          //       )),
          // ),
          Positioned(
            top: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(top: 9, bottom: 25, left: 50, right: 50),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Color(ColorValues.WHITE_COLOR),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 7.0,
                          spreadRadius: 0.0,
                        )
                      ]),
                  child: Image.asset('assets/images/homeScreenLogo.png'),
                ),
              ],
            ),
          ),
          Positioned(
            top: -80,
            left: 0,
            right: 0,
            child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.44,
                    left: 25,
                    right: 25),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                    children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // showToast("clicked");
                                  if(preferences.getString(ConstantMsg.LOGIN_STATUS)==null) {
                                    print(preferences.getString(ConstantMsg.LOGIN_STATUS));
                                    _bottomSheet(context);
                                  }
                                  else{
                                    callUpcomingScreen();
                                  }
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.17,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Color(ColorValues.THEME_COLOR),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/Appointment.png'),
                                            height: 40,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Make an\nAppointment ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "Regular",
                                              color: Color(ColorValues.WHITE_COLOR),
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
//                    SizedBox(width: 20.0),
                        Expanded(
                          flex: 1,
                          child: Column(children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CallforAppointment()));
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.17,
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Color(ColorValues.THEME_COLOR),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          image:
                                              AssetImage('assets/images/call.png'),
                                          height: 40,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Call for\nAppointment",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Regular",
                                            color: Color(ColorValues.WHITE_COLOR),
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
//                SizedBox(height: 25.0),
                  Container(
                    margin: EdgeInsets.only(top:25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.17,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Color(ColorValues.THEME_COLOR),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/vault.png'),
                                            height: 50,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Vault",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "Regular",
                                              color: Color(ColorValues.WHITE_COLOR),
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
//                    SizedBox(width: 20.0),
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
//                              if(preferences.getString(ConstantMsg.LOGIN_STATUS)==null) {
//                                print(preferences.getString(ConstantMsg.LOGIN_STATUS));
//                                showToast("no data available");
//                              }
//                              else {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) =>
//                                            History()));
//                              }
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.17,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Color(ColorValues.THEME_COLOR),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/history.png'),
                                            height: 40,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "History",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "Regular",
                                              color: Color(ColorValues.WHITE_COLOR),
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ])),
          ),
        ]),
      // ),
        bottomNavigationBar: BottomNavigation(),

    );
  }

  _bottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return FittedBox(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(ColorValues.WHITE_COLOR),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(top: 20, left: 17, bottom: 15),
                      child: Text(
                        "Login or Register",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff000000),
                          fontFamily: "Regular",
                        ),
                      ),
                    ),
                    Divider(
                      height: 2,
                      color: Color(ColorValues.BLACK_COLOR),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _bottomSheet1(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 30, bottom: 10, left: 25, right: 25),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        height: 35,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Color(ColorValues.THEME_COLOR),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                            child: Text(
                          "Continue with Phone",
                          style: TextStyle(
                            color: Color(ColorValues.WHITE_COLOR),
                            fontFamily: "Regular",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      height: 35,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(ColorValues.BLACK_COLOR)),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 52),
                            child: Image(
                              image: AssetImage("assets/images/googleIcon.png"),
                              height: 14,
                              width: 14,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Continue with Google",
                                style: TextStyle(
                                  color: Color(ColorValues.BLACK_COLOR),
                                  fontFamily: "Regular",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(ColorValues.BLACK_TEXT_COL),
                                fontFamily: "Regular",
                              ),
                              textAlign: TextAlign.center,
                            ))),
                  ],
                ),
            ),
          );
        });
  }

  _bottomSheet1(context) {
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (context) {
          return FittedBox(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(ColorValues.WHITE_COLOR),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 38),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(ColorValues.THEME_COLOR),
                        fontFamily: "Regular",
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    child: Image(
                      image: AssetImage("assets/images/RegisterIcon.png"),
                      height: 65,
                      width: 65,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Enter Your Mobile Number",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(ColorValues.BLACK_COLOR),
                        fontFamily: "Black",
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(
                        child: Text(
                      "We will send you one time\npassword(OTP)",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(ColorValues.BLACK_TEXT_COL),
                        fontFamily: "Regular",
                      ),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      width: MediaQuery.of(context).size.width,
                      child:IntlPhoneField(
                        keyboardType: TextInputType.phone,
                        controller: mobileController,
                        decoration: InputDecoration(
                          hintText: "Enter Mobile Number",
                          hintStyle: TextStyle(
                            color: Color(0xffBDBDBD),
                            fontSize: 12.0,
                            fontFamily: "Regular",
                          ),
                        ),
                        onChanged: (phone) {

                          print(phone.completeNumber);
                          mobile=phone.completeNumber;
                        },
                      ),
//                      child: TextFormField(
//                        textAlign: TextAlign.center,
//                        keyboardType: TextInputType.phone,
//                        controller: mobile,
//                        validator: (mobile) {
//                            return mobile.isEmpty ? ConstantMsg.NAME_VALIDATION : null;
//                          },
//                        decoration: InputDecoration(
//                          hintText: "Enter Mobile Number",
//                          hintStyle: TextStyle(
//                            color: Color(0xffBDBDBD),
//                            fontSize: 12.0,
//                            fontFamily: "Regular",
//                          ),
//                        ),
//                      )
                  ),
                  GestureDetector(
                    onTap: () {
                      if (mobileController.text.toString() != null && mobileController.text.toString().length>0) {
                        // String mobileNumber = mobileController.text.toString();
                        isnewUser(mobile);
//                        Navigator.pop(context);
//                        _bottomSheet2(context);
                      } else {
                        showToast(ConstantMsg.MOB_VALIDATION);
                      }

                    },
                    child: Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.53,
                      margin: EdgeInsets.symmetric(vertical: 25),
                      decoration: BoxDecoration(
                        color: Color(ColorValues.THEME_COLOR),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        "SEND",
                        style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: 14,
                          fontFamily: "Bold",
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _bottomSheet2(context, String mobileNumber) {
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (context) {
          return FittedBox(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(ColorValues.WHITE_COLOR),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(top: 20, left: 17, bottom: 15),
                      child: Text(
                        "Login or Register",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(ColorValues.BLACK_TEXT_COL),
                          fontFamily: "Regular",
                        ),
                      ),
                    ),
                    Divider(
                      height: 2,
                      color: Color(ColorValues.BLACK_COLOR),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.only(left: 27, bottom: 5),
                      height: 38,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(ColorValues.BLACK_COLOR)),
                          color: Color(ColorValues.LIGHT_GRAY),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TextFormField(
                        controller: name,
                        keyboardType: TextInputType.text,
//                      validator: (value) {
//                        value.isEmpty
//                            ? 'Enter Your Name'
//                            : RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
//                            .hasMatch(value)
//                            ? 'Enter a Valid Name'
//                            : value.length < 3
//                            ? 'Name must contain more than 3 characters'
//                            : null;
//                      },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Full Name",
                          hintStyle: TextStyle(
                            color: Color(ColorValues.BLACK_TEXT_COL),
                            fontSize: 12.0,
                            fontFamily: "Regular",
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (name.text != null && name.text.toString().length>0) {
                          signIn(mobileNumber);
                        } else {
                          showToast(ConstantMsg.NAME_VALIDATION);
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 22),
                          padding: EdgeInsets.symmetric(horizontal: 27),
                          height: 33,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                              color: Color(ColorValues.THEME_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Center(
                              child: Text(
                            "Continue",
                            style: TextStyle(
                              color: Color(ColorValues.WHITE_COLOR),
                              fontSize: 14,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ))),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _bottomSheet1(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 12, bottom: 10),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(ColorValues.BLACK_TEXT_COL)),
                              textAlign: TextAlign.center,
                            )))
                  ],
                ),

            ),
          );
        });
  }

  _bottomSheet3(context, String mobileNumber) {
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (context) {
          return FittedBox(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(ColorValues.WHITE_COLOR),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: Text(
                        "Verify Account",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Regular",
                            color: Color(ColorValues.THEME_COLOR)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 33),
                      child: Text(
                        "Mobile Verification has\nsuccessfully done",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(ColorValues.BLACK_COLOR),
                          fontFamily: "Black",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Center(
                          child:
                          RichText(
                            text: new TextSpan(
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(text: 'To complete your registration, we have sent\nan OTP to '),
                                new TextSpan(text: '${this.mobile}', style: new TextStyle(fontWeight: FontWeight.bold)),
                                new TextSpan(text: ' to verify'),
                              ],
                            ),
                          )
                      //     Text(
                      //   "To complete your registration, we have sent\nan OTP to ${this.mobileController.text.toString()} to verify",
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: "Regular",
                      //       color: Color(ColorValues.BLACK_TEXT_COL)),
                      //   textAlign: TextAlign.center,
                      // )
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      margin: EdgeInsets.only(
                        top: 30,
                      ),
                      child: TextField(
                        controller: otp,
                        textAlign: TextAlign.center,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Regular",
                          color: Color(ColorValues.BLACK_TEXT_COL),
                        ),
                        decoration: new InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: "Regular",
                            fontWeight: FontWeight.w700,
                            color: Color(ColorValues.THEME_TEXT_COLOR),
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 24,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "If you didn’t recieve your code ?",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Regular",
                                color: Color(0xff707070)),
                            textAlign: TextAlign.center,
                          ),
                          GestureDetector(
                            onTap: (){
                              generateOTP(mobileNumber);
                            },
                            child: Text("Resend",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Regular",
                                    color: Color(ColorValues.THEME_COLOR)),
                                textAlign: TextAlign.center),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if(otp.text!=null && otp.text.length>0){
                        callLoginApi(mobileNumber);
                        }
                        else{
                          showToast(ConstantMsg.OTP_VALIDATION);
                        }
                      },
                      child: Container(
                        height: 33,
                        width: MediaQuery.of(context).size.width * 0.53,
                        margin: EdgeInsets.only(top: 26, bottom: 15),
                        decoration: BoxDecoration(
                          color: Color(ColorValues.THEME_COLOR),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          "VERIFY",
                          style: TextStyle(
                              color: Color(ColorValues.WHITE_COLOR),
                              fontFamily: "Regular",
                              fontSize: 14),
                        )),
                      ),
                    )
                  ],
                ),
              ),
          );
        });
  }

  void callLoginApi(String mobileNumber) async {
    // String mobile = mobileController.text.toString();
    try {
      var url = Uri.parse(ApiConstants.VERIFY_OTP_API);
      Map<String, String> headers = {"Content-type": "application/json"};
      Map mapBody = {
        ConstantMsg.MOBILE_NUM: mobileNumber,
        ConstantMsg.OTP: otp.text,
        ConstantMsg.ROLE:"ROLE_PATIENT"

//        ConstantMsg.MOBILE_NUM: "1111111110",
//        ConstantMsg.OTP: 123456
      };
      // make POST request
      Response response =
          await post(url, headers: headers, body: json.encode(mapBody));

      String body = response.body;
      var data = json.decode(body);

      if(response.statusCode==200) {
        print(body);
        if (data["oAuthResponse"].toString() != null) {
          preferences.setString(ConstantMsg.LOGIN_STATUS, "true");

          preferences.setString(ConstantMsg.ACCESS_TOKEN,
              data['oAuthResponse']['access_token'].toString());

          preferences.setString(ConstantMsg.TOKEN_TYPE,
              data['oAuthResponse']['token_type'].toString());

          preferences.setString(ConstantMsg.ID,
              data['userModel']['id'].toString());

          preferences.setString(ConstantMsg.NAME,
              data['userModel']['name'].toString());

          preferences.setString(ConstantMsg.MOBILE_NUM,
              data['userModel']['mobileNumber'].toString());
        }

        callUpcomingScreen();
      }
    } catch (e) {
      print("Error+++++" + e.toString());
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  void callUpcomingScreen() {
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => MakeAppointmentScreen()));
  }

  void isnewUser(String mobileNumber) async {
    try {
      var url = Uri.parse(ApiConstants.NEW_USER);
      Map<String, String> headers = {"Content-type": "application/json"};
      Map mapBody = {
        ConstantMsg.MOBILE_NUM: mobileNumber,
      };
      // make POST request
      Response response =
      await post(url, headers: headers, body: json.encode(mapBody));

      String body = response.body;
      //var data = json.decode(body);

      if(response.statusCode==200) {
        print(body);
        if(body=="false"){
          // Navigator.pop(context);
          // _bottomSheet3(context);
          signIn(mobileNumber);
        }
        else{
          Navigator.pop(context);
          _bottomSheet2(context, mobileNumber);
        }
      }
    }
     catch (e) {
      print("Error+++++" + e.toString());
    }
  }

  void signIn(String mobileNumber) async {
    try {
      var url = Uri.parse(ApiConstants.SIGN_IN_API);
      Map<String, String> headers = {"Content-type": "application/json"};

      Map mapBody;
      String userName = name.text.toString();

      if(userName!=null && userName.length>0){
        mapBody = {
          ConstantMsg.MOBILE_NUM: mobileNumber,
          ConstantMsg.NAME:userName,
          ConstantMsg.ROLE:"ROLE_PATIENT",
        };
      }else{
        mapBody = {
          ConstantMsg.MOBILE_NUM: mobileNumber,
          ConstantMsg.ROLE:"ROLE_PATIENT",
        };
      }

      // make POST request
      Response response =
          await post(url, headers: headers, body: json.encode(mapBody));

      String body = response.body;
      //var data = json.decode(body);

      if(response.statusCode==200) {
        print(body);
        showToast("Code has been sent to your mobile number");
        Navigator.pop(context);
        _bottomSheet3(context, mobileNumber);
      }else {
        var data = json.decode(body);
        ErrorModel model = ErrorModel.fromJson(data);
        showToast(model.message);
      }

    }
    catch (e) {
      print("Error+++++" + e.toString());
    }
  }

  void generateOTP(String mobileNumber) async {
    try {
      var url = Uri.parse(ApiConstants.GENERATE_OTP_API);
      Map<String, String> headers = {"Content-type": "application/json"};
      Map mapBody = {
        ConstantMsg.MOBILE_NUM: mobileNumber,
        ConstantMsg.ROLE:"ROLE_PATIENT",
      };
      // make POST request
      Response response =
          await post(url, headers: headers, body: json.encode(mapBody));

      String body = response.body;
      //var data = json.decode(body);

      if(response.statusCode==200) {
        print(body);
        showToast("The code has been sent to your mobile number. Please check!");
      }

    }
    catch (e) {
      print("Error+++++" + e.toString());
    }

    // var text = new RichText(
    //   text: new TextSpan(
    //     style: new TextStyle(
    //       fontSize: 14.0,
    //       color: Colors.black,
    //     ),
    //     children: <TextSpan>[
    //       new TextSpan(text: 'To complete your registration, we have sent\nan OTP to'),
    //       new TextSpan(text: '${this.mobileController.text.toString()}', style: new TextStyle(fontWeight: FontWeight.bold)),
    //       new TextSpan(text: 'to verify'),
    //     ],
    //   ),
    // );

  }
}

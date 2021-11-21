import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homelabz/Models/ErrorModel.dart';
import 'package:homelabz/Screens/History.dart';
import 'package:homelabz/Screens/HomeScreen.dart';
import 'package:homelabz/components/MyUtils.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:homelabz/constants/Constants.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  SharedPreferences preferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DrawerHeader(
                  decoration:
                      BoxDecoration(color: Color(ColorValues.THEME_TEXT_COLOR)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(ColorValues.WHITE),
                          shape: BoxShape.circle),
                      width: 120,
                      height: 120,
                      child: Image.asset('assets/images/logo.png',
                          height: 90, width: 90),
                    ),
                  )),
              ListTile(
                onTap: () => callSettingsScreen(),
                leading: ImageIcon(
                  AssetImage('assets/images/vault.png'),
                  color: Color(ColorValues.THEME_TEXT_COLOR),
                  size: 28,
                ),
                title: Text(
                  'Vault',
                  style: TextStyle(
                    color: Color(ColorValues.THEME_TEXT_COLOR),
                    fontSize: 16.0,
                  ),
                ),
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                height: 2,
                color: Color(ColorValues.GREY_TEXT_COLOR),
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => History())),
                leading: ImageIcon(
                  AssetImage('assets/images/history.png'),
                  color: Color(ColorValues.THEME_TEXT_COLOR),
                  size: 25,
                ),
                title: Text(
                  'History',
                  style: TextStyle(
                    color: Color(ColorValues.THEME_TEXT_COLOR),
                    fontSize: 16.0,
                  ),
                ),
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                height: 2,
                color: Color(ColorValues.GREY_TEXT_COLOR),
              ),
              ListTile(
              onTap: () => callSettingsScreen(),
                leading: ImageIcon(
                  AssetImage('assets/images/settings.png'),
                  color: Color(ColorValues.THEME_TEXT_COLOR),
                  size: 20,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    color: Color(ColorValues.THEME_TEXT_COLOR),
                    fontSize: 16.0,
                  ),
                ),
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                height: 2,
                color: Color(ColorValues.GREY_TEXT_COLOR),
              ),
              ListTile(
                onTap: (){
                  // callLogout();
                  showAlertDialog(context);
                },
                leading: ImageIcon(
                  AssetImage('assets/images/logout.png'),
                  color: Color(ColorValues.THEME_TEXT_COLOR),
                  size: 20,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(ColorValues.THEME_TEXT_COLOR),
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  callSettingsScreen() {
//     Navigator.push(
//         context,
//         new MaterialPageRoute(
//             builder: (BuildContext context) => SettingsScreen()));
  }

  callLogout() async {
    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.LOGOUT);
      Map<String, String> headers = {"Content-type": "application/json",
        Constants.HEADER_AUTH: "bearer " + preferences.getString(Constants.ACCESS_TOKEN)
      };

      // make POST request
      var response = await _ioClient.post(url, headers: headers);

      print(response.statusCode);
      String body = response.body;

      if (response.statusCode == 200) {
        print(body);
        // Fluttertoast.showToast(
        //   msg: "Logout",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.CENTER,
        //   timeInSecForIosWeb: 1,
        // );

        preferences.setString(Constants.LOGIN_STATUS,"false");

        Navigator.of(context).pushAndRemoveUntil(
          // the new route
          MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(),
          ),

          // this function should return true when we're done removing routes
          // but because we want to remove all other screens, we make it
          // always return false
              (Route route) => false,
        );

      } else {
        var data = json.decode(body);
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
    } catch (e) {}

  }

    showAlertDialog(BuildContext context) {
      // set up the button
      Widget okButton = FlatButton(
        child: Text("OK", style: TextStyle(
          color: Color(ColorValues.THEME_TEXT_COLOR),
        ),),
        onPressed: () {
         callLogout();
        },
      );

      Widget cancelButton = FlatButton(
        child: Text("Cancel", style: TextStyle(
          color: Color(ColorValues.THEME_TEXT_COLOR),
        ),),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Logout"),
        content: Text("Do you really want to logout?"),
        actions: [
          cancelButton,
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homelabz/Models/GlobalDataModel.dart';
import 'package:homelabz/components/ColorValues.dart';
import 'package:homelabz/components/MyUtils.dart';
import 'package:homelabz/constants/Constants.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/io_client.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsentFormScreen extends StatefulWidget {
  const ConsentFormScreen({Key key}) : super(key: key);

  @override
  _ConsentFormScreenState createState() => _ConsentFormScreenState();
}

class _ConsentFormScreenState extends State<ConsentFormScreen> {
  bool isConsent = false;
  SharedPreferences preferences;
  List<GlobalDataModel> globalDataList;
  String pdfPath;

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    callApi();
  }

  void callApi() async {
    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.CALL_API);
      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
      };
      // make POST request
      var response = await _ioClient.get(url, headers: headers);
      // check the status code for the result
      String body = response.body;
      print(body);
      var data = json.decode(body);
      if (response.statusCode == 200) {
        globalDataList = [];

        List list = data;
        for (var obj in list) {
          GlobalDataModel model = GlobalDataModel.fromJson(obj);
          globalDataList.add(model);

          if (model.code.compareTo("CONSENT_PDF_PATH") == 0) {
            pdfPath = model.value;
          }
        }
        setState(() {});
      } else {
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
    } catch (ex) {
      print("ERROR+++++++++++++  ${ex}");
    }
  }

  Future<void> updateConsent() async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();

    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.UPDATE_CONSENT);
      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH: "bearer " +
            preferences.getString(Constants.ACCESS_TOKEN),
      };
      print(preferences.getString(Constants.ACCESS_TOKEN));

      Map map = {
        Constants.ID: preferences.getString(Constants.ID),
        Constants.IS_CONSENT: isConsent,
      };
      // make POST request
      var response =
      await _ioClient.post(url, headers: headers, body: json.encode(map));

      // check the status code for the result
      String body = response.body;
      print(body);
      // var data = json.decode(body);

      if (response.statusCode == 200) {
        preferences.setString(Constants.IS_CONSENT,"true");
        print("doneeeeee!!!!!!");
        Navigator.pop(context);
      } else {
        // MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
      await dialog.hide();
    } catch (ex) {
      await dialog.hide();
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
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Consent Form",
            style: TextStyle(
                fontFamily: "Regular",
                fontSize: 18,
                color: Color(ColorValues.THEME_COLOR)),
          ),
        ),
        body: Container(
          child: Center(
            child: Text(
              "show pdf here",
              style: TextStyle(
                color: Color(ColorValues.THEME_TEXT_COLOR),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Checkbox(
                        checkColor: Color(ColorValues.WHITE),
                        activeColor: Color(ColorValues.THEME_TEXT_COLOR),
                        value: this.isConsent,
                        onChanged: (bool value) {
                          setState(() {
                            this.isConsent = value;
                          });
                        },
                      ),
                    ),
                    Container(
                        child: Text("I accept all the terms and conditions!",
                            style:
                                TextStyle(fontFamily: "Regular", fontSize: 16),
                            textAlign: TextAlign.center)),
                  ]),
            ),
            Container(
              //  alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontFamily: "Regular",
                            fontSize: 16,
                            color: Color(ColorValues.BLACK_COL)),
                      ),
                    )),
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 15, top: 20, bottom: 20),
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      decoration: isConsent
                          ? BoxDecoration(
                              color: const Color(ColorValues.THEME_TEXT_COLOR),
                              borderRadius: BorderRadius.circular(5),
                            )
                          : BoxDecoration(
                              color: const Color(ColorValues.GRAY),
                              borderRadius: BorderRadius.circular(5),
                            ),
                      child: TextButton(
                        onPressed: () {
                          if (isConsent) {
                            // Update Consent api
                            updateConsent();
                          } else {
                            MyUtils.showCustomToast(
                                Constants.TnC_VALIDATION, true, context);
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Color(ColorValues.WHITE), fontSize: 16),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ));
  }
}

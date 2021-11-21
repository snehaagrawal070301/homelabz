import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homelabz/Models/NotificationModel.dart';
import 'package:homelabz/components/MyUtils.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:homelabz/constants/Constants.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> dataList;
  SharedPreferences preferences;
  var isData = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    getNotificationsList();
  }

  Future<void> getNotificationsList() async {
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

      var url = Uri.parse(ApiConstants.GET_NOTIFICATION_LIST +
          preferences.getString(Constants.ID).toString());

      print(preferences.getString(Constants.ACCESS_TOKEN));
      print(preferences.getString(Constants.ID));

      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH:
        "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };
      // make GET request
      var response = await _ioClient.get(url, headers: headers,);
      // check the status code for the result
      String body = response.body;
      print(body);

      if (response.statusCode == 200) {
        dataList = [];
        var data = json.decode(body);
        List list = data;

        for (var obj in list) {
          NotificationModel model = NotificationModel.fromJson(obj);
          dataList.add(model);
        }

        setState(() {
          isData = true;
        });
      } else {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorValues.THEME_TEXT_COLOR),
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
          "Notification",
          style: TextStyle(
              fontFamily: "Regular",
              fontSize: 18,
              color: Color(ColorValues.THEME_COLOR)),
        ),
      ),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: const Color(ColorValues.WHITE),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0))),
            ),
            Positioned(
              top: 60,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 30),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: RefreshIndicator(
                  onRefresh: getNotificationsList,
                  child: dataList != null && dataList.length > 0
                      ? ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      // physics: const ScrollPhysics(),
                      // shrinkWrap: true,
                      itemCount: dataList.length,
                      itemBuilder: (BuildContext context, int pos) {
                        return Card(
                            elevation: 8,
                            child: Container(
                              margin:
                              EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                              child: new Column(
                                children: [
                                  new Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new Container(
                                            margin:
                                            const EdgeInsets.fromLTRB(
                                                5.0, 5.0, 5.0, 0.0),
                                            // color: Colors.transparent,
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  0.0),
                                              child: Image.asset(
                                                'assets/images/ic_launcher.png',
                                                height: 40.0,
                                                width: 40.0,
                                              ),
                                            )),
                                        flex: 0,
                                      ),
                                      new Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              10.0, 0, 0, 0),
                                          child: new Container(
                                            margin:
                                            const EdgeInsets.fromLTRB(
                                                0.0, 0, 0, 5.0),
                                            child: new Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                new Container(
                                                  margin: const EdgeInsets
                                                      .fromLTRB(
                                                      0.0, 10, 0, 5.0),
                                                  child: new Text(
                                                    dataList != null &&
                                                        dataList[pos]
                                                            .description !=
                                                            null
                                                        ? dataList[pos]
                                                        .description
                                                        : "",
                                                    // 'Lorem ipsum dolor sit amet, consectetur '
                                                    //     'adip isc ing elit. Arcu nibh venenatis.',
                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Color(ColorValues
                                                            .BLACK_TEXT_COL),
                                                        fontFamily:
                                                        "customRegular"),
                                                  ),
                                                ),
                                                new Container(
                                                  margin: const EdgeInsets
                                                      .fromLTRB(
                                                      0.0, 5, 0, 5.0),
                                                  child: new Text(
                                                    dataList[pos]
                                                        .createdDate,
                                                    // MyUtils.getTimeDifferance(dataList[pos].createdDate),
                                                    // "2 Hours Ago",
                                                    style: new TextStyle(
                                                        fontSize: 9.0,
                                                        color: ColorValues
                                                            .TIME_NOTITFICAITON,
                                                        fontFamily:
                                                        "customLight"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      })
                      : isData
                      ? new Container()
                      : new Container(
                    child: Center(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Image(
                            height: 250,
                            width: 200,
                            image: AssetImage(
                                "assets/images/Nodatafound.jpg"),
                          ),
                        ),
                        Text("No data available!"),
                      ]),
                    ),
                  ),
                ),
//                           }),
              ),
            )
          ],
        ),
      ),
    );
  }

}

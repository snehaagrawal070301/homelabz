import 'package:flutter/material.dart';
import 'package:homelabz/components/ColorValues.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(ColorValues.THEME_TEXT_COLOR),
        appBar: AppBar(
          backgroundColor: Color(ColorValues.THEME_TEXT_COLOR),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Settings',
            style: TextStyle(color: Color(ColorValues.WHITE), fontSize: 20),
          ),
          leading: IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/back_arrow.png'),
              color: Color(ColorValues.WHITE),
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body:
    // SingleChildScrollView(
    //       child:
          Stack(children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: const Color(ColorValues.WHITE),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0))),
              ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2.6,
              top: 5,
              width: 100,
              height: 100,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/profile_pic.png'),
              ),
            ),
            Positioned(
                top: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
                        child: Text(
                          'Account',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(ColorValues.RADIO_BLACK),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color(ColorValues.DARK_GREY),
                                blurRadius: 2.0,
                                offset: Offset(0.0, 0.50))
                          ],
                        ),
                        child: Card(
                            child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                'Notification Settings',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(ColorValues.BLACK_COL),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Image.asset(
                                  'assets/images/arrow.png',
                                  color: Color(ColorValues.BLACK_COL),
                                  height: 15,
                                  width: 10,
                                )),
                          ],
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
                        child: Text(
                          'App',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(ColorValues.RADIO_BLACK),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color(ColorValues.DARK_GREY),
                                blurRadius: 2.0,
                                offset: Offset(0.0, 0.50))
                          ],
                        ),
                        child: Card(
                            child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                'About App',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(ColorValues.BLACK_COL),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Image.asset(
                                  'assets/images/arrow.png',
                                  color: Color(ColorValues.BLACK_COL),
                                  height: 15,
                                  width: 10,
                                )),
                          ],
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color(ColorValues.DARK_GREY),
                                blurRadius: 2.0,
                                offset: Offset(0.0, 0.50))
                          ],
                        ),
                        child: Card(
                            child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                'Share with friends',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(ColorValues.BLACK_COL),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Image.asset(
                                  'assets/images/arrow.png',
                                  color: Color(ColorValues.BLACK_COL),
                                  height: 15,
                                  width: 10,
                                )),
                          ],
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color(ColorValues.DARK_GREY),
                                blurRadius: 2.0,
                                offset: Offset(0.0, 0.50))
                          ],
                        ),
                        child: Card(
                            child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                'Rate us on App store',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(ColorValues.BLACK_COL),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Image.asset(
                                  'assets/images/arrow.png',
                                  color: Color(ColorValues.BLACK_COL),
                                  height: 15,
                                  width: 10,
                                )),
                          ],
                        )),
                      ),
                    ]))
          ]),
        // )
    );
  }
}

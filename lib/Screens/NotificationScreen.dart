import 'package:flutter/material.dart';
import 'package:homelabz/components/colorValues.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class NotificationData {
  String msg, time;

  NotificationData(this.msg, this.time);

  @override
  String toString() {
    return '{ ${this.msg}, ${this.time} }';
  }
}

class _NotificationScreenState extends State<NotificationScreen> {

  List dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(ColorValues.THEME_TEXT_COLOR),
          leading: IconButton(
            // iconSize: 20,
            icon: Icon(
              Icons.arrow_back,
              color: Color(ColorValues.WHITE),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Notification",style: TextStyle(fontFamily: "Regular",fontSize: 18,
              color: Color(ColorValues.WHITE)),),
        ),
        backgroundColor: Color(ColorValues.THEME_TEXT_COLOR),
        body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                  color: const Color(ColorValues.WHITE),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0))),
              child: Container(
                margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: Card(
                            elevation: 8,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                              child: new Column(
                                children: [
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5.0, 5.0, 5.0, 0.0),
                                            // color: Colors.transparent,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(0.0),
                                              child: Image.asset(
                                                'assets/images/profile_pic.png',
                                                height: 40.0,
                                                width: 40.0,
                                              ),
                                            )),
                                        flex: 0,
                                      ),
                                      new Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                          child: new Container(
                                            margin:
                                            const EdgeInsets.fromLTRB(0.0, 0, 0, 5.0),
                                            child: new Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,

                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 10, 0, 5.0),
                                                  child: new Text(
                                                    // lis[index].title,

                                                    'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',

                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Color(
                                                            ColorValues.BLACK_TEXT_COL),
                                                        fontFamily: "customRegular"),
                                                  ),
                                                ),
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 5, 0, 5.0),
                                                  child: new Text(
                                                    //lis[index].created,
                                                    "2 Hours Ago",
                                                    /*item.weight
                                                          .replaceAll(".00", "") +
                                                          " " +
                                                          item.unit*/
                                                    style: new TextStyle(
                                                        fontSize: 9.0,
                                                        color: ColorValues
                                                            .TIME_NOTITFICAITON,
                                                        fontFamily: "customLight"),
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
                                  // new Container(
                                  //   height: 0.5,
                                  //   color: ColorValues.TIME_NOTITFICAITON,
                                  //
                                  // ),
                                ],
                              ),
                            ))
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: Card(
                            elevation: 8,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                              child: new Column(
                                children: [
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5.0, 5.0, 5.0, 0.0),
                                            // color: Colors.transparent,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(0.0),
                                              child: Image.asset(
                                                'assets/images/profile_pic.png',
                                                height: 40.0,
                                                width: 40.0,
                                              ),
                                            )),
                                        flex: 0,
                                      ),
                                      new Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                          child: new Container(
                                            margin:
                                            const EdgeInsets.fromLTRB(0.0, 0, 0, 5.0),
                                            child: new Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,

                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 10, 0, 5.0),
                                                  child: new Text(
                                                    // lis[index].title,

                                                    'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',

                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Color(
                                                            ColorValues.BLACK_TEXT_COL),
                                                        fontFamily: "customRegular"),
                                                  ),
                                                ),
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 5, 0, 5.0),
                                                  child: new Text(
                                                    //lis[index].created,
                                                    "2 Hours Ago",
                                                    /*item.weight
                                                          .replaceAll(".00", "") +
                                                          " " +
                                                          item.unit*/
                                                    style: new TextStyle(
                                                        fontSize: 9.0,
                                                        color: ColorValues
                                                            .TIME_NOTITFICAITON,
                                                        fontFamily: "customLight"),
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
                                  // new Container(
                                  //   height: 0.5,
                                  //   color: ColorValues.TIME_NOTITFICAITON,
                                  //
                                  // ),
                                ],
                              ),
                            ))
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: Card(
                            elevation: 8,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                              child: new Column(
                                children: [
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5.0, 5.0, 5.0, 0.0),
                                            // color: Colors.transparent,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(0.0),
                                              child: Image.asset(
                                                'assets/images/profile_pic.png',
                                                height: 40.0,
                                                width: 40.0,
                                              ),
                                            )),
                                        flex: 0,
                                      ),
                                      new Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                          child: new Container(
                                            margin:
                                            const EdgeInsets.fromLTRB(0.0, 0, 0, 5.0),
                                            child: new Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,

                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 10, 0, 5.0),
                                                  child: new Text(
                                                    // lis[index].title,

                                                    'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',

                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Color(
                                                            ColorValues.BLACK_TEXT_COL),
                                                        fontFamily: "customRegular"),
                                                  ),
                                                ),
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 5, 0, 5.0),
                                                  child: new Text(
                                                    //lis[index].created,
                                                    "2 Hours Ago",
                                                    /*item.weight
                                                          .replaceAll(".00", "") +
                                                          " " +
                                                          item.unit*/
                                                    style: new TextStyle(
                                                        fontSize: 9.0,
                                                        color: ColorValues
                                                            .TIME_NOTITFICAITON,
                                                        fontFamily: "customLight"),
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
                                  // new Container(
                                  //   height: 0.5,
                                  //   color: ColorValues.TIME_NOTITFICAITON,
                                  //
                                  // ),
                                ],
                              ),
                            ))
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: Card(
                            elevation: 8,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                              child: new Column(
                                children: [
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5.0, 5.0, 5.0, 0.0),
                                            // color: Colors.transparent,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(0.0),
                                              child: Image.asset(
                                                'assets/images/profile_pic.png',
                                                height: 40.0,
                                                width: 40.0,
                                              ),
                                            )),
                                        flex: 0,
                                      ),
                                      new Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                          child: new Container(
                                            margin:
                                            const EdgeInsets.fromLTRB(0.0, 0, 0, 5.0),
                                            child: new Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,

                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 10, 0, 5.0),
                                                  child: new Text(
                                                    // lis[index].title,

                                                    'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',

                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Color(
                                                            ColorValues.BLACK_TEXT_COL),
                                                        fontFamily: "customRegular"),
                                                  ),
                                                ),
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 5, 0, 5.0),
                                                  child: new Text(
                                                    //lis[index].created,
                                                    "2 Hours Ago",
                                                    /*item.weight
                                                          .replaceAll(".00", "") +
                                                          " " +
                                                          item.unit*/
                                                    style: new TextStyle(
                                                        fontSize: 9.0,
                                                        color: ColorValues
                                                            .TIME_NOTITFICAITON,
                                                        fontFamily: "customLight"),
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
                                  // new Container(
                                  //   height: 0.5,
                                  //   color: ColorValues.TIME_NOTITFICAITON,
                                  //
                                  // ),
                                ],
                              ),
                            ))),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: Card(
                            elevation: 8,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                              child: new Column(
                                children: [
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5.0, 5.0, 5.0, 0.0),
                                            // color: Colors.transparent,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(0.0),
                                              child: Image.asset(
                                                'assets/images/profile_pic.png',
                                                height: 40.0,
                                                width: 40.0,
                                              ),
                                            )),
                                        flex: 0,
                                      ),
                                      new Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                          child: new Container(
                                            margin:
                                            const EdgeInsets.fromLTRB(0.0, 0, 0, 5.0),
                                            child: new Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,

                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 10, 0, 5.0),
                                                  child: new Text(
                                                    // lis[index].title,

                                                    'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',

                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Color(
                                                            ColorValues.BLACK_TEXT_COL),
                                                        fontFamily: "customRegular"),
                                                  ),
                                                ),
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 5, 0, 5.0),
                                                  child: new Text(
                                                    //lis[index].created,
                                                    "2 Hours Ago",
                                                    /*item.weight
                                                          .replaceAll(".00", "") +
                                                          " " +
                                                          item.unit*/
                                                    style: new TextStyle(
                                                        fontSize: 9.0,
                                                        color: ColorValues
                                                            .TIME_NOTITFICAITON,
                                                        fontFamily: "customLight"),
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
                                  // new Container(
                                  //   height: 0.5,
                                  //   color: ColorValues.TIME_NOTITFICAITON,
                                  //
                                  // ),
                                ],
                              ),
                            ))),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: Card(
                            elevation: 8,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                              child: new Column(
                                children: [
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5.0, 5.0, 5.0, 0.0),
                                            // color: Colors.transparent,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(0.0),
                                              child: Image.asset(
                                                'assets/images/profile_pic.png',
                                                height: 40.0,
                                                width: 40.0,
                                              ),
                                            )),
                                        flex: 0,
                                      ),
                                      new Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                          child: new Container(
                                            margin:
                                            const EdgeInsets.fromLTRB(0.0, 0, 0, 5.0),
                                            child: new Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,

                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 10, 0, 5.0),
                                                  child: new Text(
                                                    // lis[index].title,

                                                    'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',

                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Color(
                                                            ColorValues.BLACK_TEXT_COL),
                                                        fontFamily: "customRegular"),
                                                  ),
                                                ),
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 5, 0, 5.0),
                                                  child: new Text(
                                                    //lis[index].created,
                                                    "2 Hours Ago",
                                                    /*item.weight
                                                          .replaceAll(".00", "") +
                                                          " " +
                                                          item.unit*/
                                                    style: new TextStyle(
                                                        fontSize: 9.0,
                                                        color: ColorValues
                                                            .TIME_NOTITFICAITON,
                                                        fontFamily: "customLight"),
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
                                  // new Container(
                                  //   height: 0.5,
                                  //   color: ColorValues.TIME_NOTITFICAITON,
                                  //
                                  // ),
                                ],
                              ),
                            ))),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: Card(
                            elevation: 8,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                              child: new Column(
                                children: [
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5.0, 5.0, 5.0, 0.0),
                                            // color: Colors.transparent,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(0.0),
                                              child: Image.asset(
                                                'assets/images/profile_pic.png',
                                                height: 40.0,
                                                width: 40.0,
                                              ),
                                            )),
                                        flex: 0,
                                      ),
                                      new Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                          child: new Container(
                                            margin:
                                            const EdgeInsets.fromLTRB(0.0, 0, 0, 5.0),
                                            child: new Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,

                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 10, 0, 5.0),
                                                  child: new Text(
                                                    // lis[index].title,

                                                    'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',

                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: Color(
                                                            ColorValues.BLACK_TEXT_COL),
                                                        fontFamily: "customRegular"),
                                                  ),
                                                ),
                                                new Container(
                                                  margin: const EdgeInsets.fromLTRB(
                                                      0.0, 5, 0, 5.0),
                                                  child: new Text(
                                                    //lis[index].created,
                                                    "2 Hours Ago",
                                                    /*item.weight
                                                          .replaceAll(".00", "") +
                                                          " " +
                                                          item.unit*/
                                                    style: new TextStyle(
                                                        fontSize: 9.0,
                                                        color: ColorValues
                                                            .TIME_NOTITFICAITON,
                                                        fontFamily: "customLight"),
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
                                  // new Container(
                                  //   height: 0.5,
                                  //   color: ColorValues.TIME_NOTITFICAITON,
                                  //
                                  // ),
                                ],
                              ),
                            ))),
                  ],
                ),
              ),
            )));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       backgroundColor: Color(ColorValues.THEME_TEXT_COLOR),
  //       body: SingleChildScrollView(
  //           child: Container(
  //         margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
  //         width: MediaQuery.of(context).size.width,
  //         // height: MediaQuery.of(context).size.height * 0.8,
  //         decoration: BoxDecoration(
  //             color: const Color(ColorValues.WHITE),
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(50.0),
  //                 topRight: Radius.circular(50.0))),
  //         child: Container(
  //           margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
  //           child: Column(
  //             children: [
  //               Container(
  //                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
  //                   child: Card(
  //                       elevation: 8,
  //                       child: Container(
  //                         margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
  //                         child: new Column(
  //                           children: [
  //                             new Row(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: <Widget>[
  //                                 new Expanded(
  //                                   child: new Container(
  //                                       margin: const EdgeInsets.fromLTRB(
  //                                           5.0, 5.0, 5.0, 0.0),
  //                                       // color: Colors.transparent,
  //                                       child: ClipRRect(
  //                                         borderRadius: BorderRadius.circular(0.0),
  //                                         child: Image.asset(
  //                                           'assets/images/profile_pic.png',
  //                                           height: 40.0,
  //                                           width: 40.0,
  //                                         ),
  //                                       )),
  //                                   flex: 0,
  //                                 ),
  //                                 new Expanded(
  //                                   child: Padding(
  //                                     padding:
  //                                         const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
  //                                     child: new Container(
  //                                       margin:
  //                                           const EdgeInsets.fromLTRB(0.0, 0, 0, 5.0),
  //                                       child: new Column(
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //
  //                                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                                         children: [
  //                                           new Container(
  //                                             margin: const EdgeInsets.fromLTRB(
  //                                                 0.0, 10, 0, 5.0),
  //                                             child: new Text(
  //                                               // lis[index].title,
  //
  //                                               'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',
  //
  //                                               style: new TextStyle(
  //                                                   fontSize: 12.0,
  //                                                   color: Color(
  //                                                       ColorValues.BLACK_TEXT_COL),
  //                                                   fontFamily: "customRegular"),
  //                                             ),
  //                                           ),
  //                                           new Container(
  //                                             margin: const EdgeInsets.fromLTRB(
  //                                                 0.0, 5, 0, 5.0),
  //                                             child: new Text(
  //                                               //lis[index].created,
  //                                               "2 Hours Ago",
  //                                               /*item.weight
  //                                                         .replaceAll(".00", "") +
  //                                                         " " +
  //                                                         item.unit*/
  //                                               style: new TextStyle(
  //                                                   fontSize: 9.0,
  //                                                   color: ColorValues
  //                                                       .TIME_NOTITFICAITON,
  //                                                   fontFamily: "customLight"),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   flex: 1,
  //                                 ),
  //                               ],
  //                             ),
  //                             // new Container(
  //                             //   height: 0.5,
  //                             //   color: ColorValues.TIME_NOTITFICAITON,
  //                             //
  //                             // ),
  //                           ],
  //                         ),
  //                       ))
  //               ),
  //               Container(
  //                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
  //                   child: Card(
  //                       elevation: 8,
  //                       child: Container(
  //                         margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
  //                         child: new Column(
  //                           children: [
  //                             new Row(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: <Widget>[
  //                                 new Expanded(
  //                                   child: new Container(
  //                                       margin: const EdgeInsets.fromLTRB(
  //                                           5.0, 5.0, 5.0, 0.0),
  //                                       // color: Colors.transparent,
  //                                       child: ClipRRect(
  //                                         borderRadius: BorderRadius.circular(0.0),
  //                                         child: Image.asset(
  //                                           'assets/images/profile_pic.png',
  //                                           height: 40.0,
  //                                           width: 40.0,
  //                                         ),
  //                                       )),
  //                                   flex: 0,
  //                                 ),
  //                                 new Expanded(
  //                                   child: Padding(
  //                                     padding:
  //                                     const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
  //                                     child: new Container(
  //                                       margin:
  //                                       const EdgeInsets.fromLTRB(0.0, 0, 0, 5.0),
  //                                       child: new Column(
  //                                         crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //
  //                                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                                         children: [
  //                                           new Container(
  //                                             margin: const EdgeInsets.fromLTRB(
  //                                                 0.0, 10, 0, 5.0),
  //                                             child: new Text(
  //                                               // lis[index].title,
  //
  //                                               'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',
  //
  //                                               style: new TextStyle(
  //                                                   fontSize: 12.0,
  //                                                   color: Color(
  //                                                       ColorValues.BLACK_TEXT_COL),
  //                                                   fontFamily: "customRegular"),
  //                                             ),
  //                                           ),
  //                                           new Container(
  //                                             margin: const EdgeInsets.fromLTRB(
  //                                                 0.0, 5, 0, 5.0),
  //                                             child: new Text(
  //                                               //lis[index].created,
  //                                               "2 Hours Ago",
  //                                               /*item.weight
  //                                                         .replaceAll(".00", "") +
  //                                                         " " +
  //                                                         item.unit*/
  //                                               style: new TextStyle(
  //                                                   fontSize: 9.0,
  //                                                   color: ColorValues
  //                                                       .TIME_NOTITFICAITON,
  //                                                   fontFamily: "customLight"),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   flex: 1,
  //                                 ),
  //                               ],
  //                             ),
  //                             // new Container(
  //                             //   height: 0.5,
  //                             //   color: ColorValues.TIME_NOTITFICAITON,
  //                             //
  //                             // ),
  //                           ],
  //                         ),
  //                       ))
  //               ),
  //               Container(
  //                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
  //                   child: Card(
  //                       elevation: 8,
  //                       child: Container(
  //                         margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
  //                         child: new Column(
  //                           children: [
  //                             new Row(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: <Widget>[
  //                                 new Expanded(
  //                                   child: new Container(
  //                                       margin: const EdgeInsets.fromLTRB(
  //                                           5.0, 5.0, 5.0, 0.0),
  //                                       // color: Colors.transparent,
  //                                       child: ClipRRect(
  //                                         borderRadius: BorderRadius.circular(0.0),
  //                                         child: Image.asset(
  //                                           'assets/images/profile_pic.png',
  //                                           height: 40.0,
  //                                           width: 40.0,
  //                                         ),
  //                                       )),
  //                                   flex: 0,
  //                                 ),
  //                                 new Expanded(
  //                                   child: Padding(
  //                                     padding:
  //                                     const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
  //                                     child: new Container(
  //                                       margin:
  //                                       const EdgeInsets.fromLTRB(0.0, 0, 0, 5.0),
  //                                       child: new Column(
  //                                         crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //
  //                                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                                         children: [
  //                                           new Container(
  //                                             margin: const EdgeInsets.fromLTRB(
  //                                                 0.0, 10, 0, 5.0),
  //                                             child: new Text(
  //                                               // lis[index].title,
  //
  //                                               'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',
  //
  //                                               style: new TextStyle(
  //                                                   fontSize: 12.0,
  //                                                   color: Color(
  //                                                       ColorValues.BLACK_TEXT_COL),
  //                                                   fontFamily: "customRegular"),
  //                                             ),
  //                                           ),
  //                                           new Container(
  //                                             margin: const EdgeInsets.fromLTRB(
  //                                                 0.0, 5, 0, 5.0),
  //                                             child: new Text(
  //                                               //lis[index].created,
  //                                               "2 Hours Ago",
  //                                               /*item.weight
  //                                                         .replaceAll(".00", "") +
  //                                                         " " +
  //                                                         item.unit*/
  //                                               style: new TextStyle(
  //                                                   fontSize: 9.0,
  //                                                   color: ColorValues
  //                                                       .TIME_NOTITFICAITON,
  //                                                   fontFamily: "customLight"),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   flex: 1,
  //                                 ),
  //                               ],
  //                             ),
  //                             // new Container(
  //                             //   height: 0.5,
  //                             //   color: ColorValues.TIME_NOTITFICAITON,
  //                             //
  //                             // ),
  //                           ],
  //                         ),
  //                       ))),
  //               Container(
  //                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
  //                   child: Card(
  //                       elevation: 8,
  //                       child: Container(
  //                         margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
  //                         child: new Column(
  //                           children: [
  //                             new Row(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: <Widget>[
  //                                 new Expanded(
  //                                   child: new Container(
  //                                       margin: const EdgeInsets.fromLTRB(
  //                                           5.0, 5.0, 5.0, 0.0),
  //                                       // color: Colors.transparent,
  //                                       child: ClipRRect(
  //                                         borderRadius: BorderRadius.circular(0.0),
  //                                         child: Image.asset(
  //                                           'assets/images/profile_pic.png',
  //                                           height: 40.0,
  //                                           width: 40.0,
  //                                         ),
  //                                       )),
  //                                   flex: 0,
  //                                 ),
  //                                 new Expanded(
  //                                   child: Padding(
  //                                     padding:
  //                                     const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
  //                                     child: new Container(
  //                                       margin:
  //                                       const EdgeInsets.fromLTRB(0.0, 0, 0, 5.0),
  //                                       child: new Column(
  //                                         crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //
  //                                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                                         children: [
  //                                           new Container(
  //                                             margin: const EdgeInsets.fromLTRB(
  //                                                 0.0, 10, 0, 5.0),
  //                                             child: new Text(
  //                                               // lis[index].title,
  //
  //                                               'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',
  //
  //                                               style: new TextStyle(
  //                                                   fontSize: 12.0,
  //                                                   color: Color(
  //                                                       ColorValues.BLACK_TEXT_COL),
  //                                                   fontFamily: "customRegular"),
  //                                             ),
  //                                           ),
  //                                           new Container(
  //                                             margin: const EdgeInsets.fromLTRB(
  //                                                 0.0, 5, 0, 5.0),
  //                                             child: new Text(
  //                                               //lis[index].created,
  //                                               "2 Hours Ago",
  //                                               /*item.weight
  //                                                         .replaceAll(".00", "") +
  //                                                         " " +
  //                                                         item.unit*/
  //                                               style: new TextStyle(
  //                                                   fontSize: 9.0,
  //                                                   color: ColorValues
  //                                                       .TIME_NOTITFICAITON,
  //                                                   fontFamily: "customLight"),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   flex: 1,
  //                                 ),
  //                               ],
  //                             ),
  //                             // new Container(
  //                             //   height: 0.5,
  //                             //   color: ColorValues.TIME_NOTITFICAITON,
  //                             //
  //                             // ),
  //                           ],
  //                         ),
  //                       ))),
  //               Container(
  //                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
  //                   child: Card(
  //                       elevation: 8,
  //                       child: Container(
  //                         margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
  //                         child: new Column(
  //                           children: [
  //                             new Row(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: <Widget>[
  //                                 new Expanded(
  //                                   child: new Container(
  //                                       margin: const EdgeInsets.fromLTRB(
  //                                           5.0, 5.0, 5.0, 0.0),
  //                                       // color: Colors.transparent,
  //                                       child: ClipRRect(
  //                                         borderRadius: BorderRadius.circular(0.0),
  //                                         child: Image.asset(
  //                                           'assets/images/profile_pic.png',
  //                                           height: 40.0,
  //                                           width: 40.0,
  //                                         ),
  //                                       )),
  //                                   flex: 0,
  //                                 ),
  //                                 new Expanded(
  //                                   child: Padding(
  //                                     padding:
  //                                     const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
  //                                     child: new Container(
  //                                       margin:
  //                                       const EdgeInsets.fromLTRB(0.0, 0, 0, 5.0),
  //                                       child: new Column(
  //                                         crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //
  //                                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                                         children: [
  //                                           new Container(
  //                                             margin: const EdgeInsets.fromLTRB(
  //                                                 0.0, 10, 0, 5.0),
  //                                             child: new Text(
  //                                               // lis[index].title,
  //
  //                                               'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',
  //
  //                                               style: new TextStyle(
  //                                                   fontSize: 12.0,
  //                                                   color: Color(
  //                                                       ColorValues.BLACK_TEXT_COL),
  //                                                   fontFamily: "customRegular"),
  //                                             ),
  //                                           ),
  //                                           new Container(
  //                                             margin: const EdgeInsets.fromLTRB(
  //                                                 0.0, 5, 0, 5.0),
  //                                             child: new Text(
  //                                               //lis[index].created,
  //                                               "2 Hours Ago",
  //                                               /*item.weight
  //                                                         .replaceAll(".00", "") +
  //                                                         " " +
  //                                                         item.unit*/
  //                                               style: new TextStyle(
  //                                                   fontSize: 9.0,
  //                                                   color: ColorValues
  //                                                       .TIME_NOTITFICAITON,
  //                                                   fontFamily: "customLight"),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   flex: 1,
  //                                 ),
  //                               ],
  //                             ),
  //                             // new Container(
  //                             //   height: 0.5,
  //                             //   color: ColorValues.TIME_NOTITFICAITON,
  //                             //
  //                             // ),
  //                           ],
  //                         ),
  //                       ))),
  //               Container(
  //                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
  //                   child: Card(
  //                       elevation: 8,
  //                       child: Container(
  //                         margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
  //                         child: new Column(
  //                           children: [
  //                             new Row(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: <Widget>[
  //                                 new Expanded(
  //                                   child: new Container(
  //                                       margin: const EdgeInsets.fromLTRB(
  //                                           5.0, 5.0, 5.0, 0.0),
  //                                       // color: Colors.transparent,
  //                                       child: ClipRRect(
  //                                         borderRadius: BorderRadius.circular(0.0),
  //                                         child: Image.asset(
  //                                           'assets/images/profile_pic.png',
  //                                           height: 40.0,
  //                                           width: 40.0,
  //                                         ),
  //                                       )),
  //                                   flex: 0,
  //                                 ),
  //                                 new Expanded(
  //                                   child: Padding(
  //                                     padding:
  //                                     const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
  //                                     child: new Container(
  //                                       margin:
  //                                       const EdgeInsets.fromLTRB(0.0, 0, 0, 5.0),
  //                                       child: new Column(
  //                                         crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //
  //                                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                                         children: [
  //                                           new Container(
  //                                             margin: const EdgeInsets.fromLTRB(
  //                                                 0.0, 10, 0, 5.0),
  //                                             child: new Text(
  //                                               // lis[index].title,
  //
  //                                               'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',
  //
  //                                               style: new TextStyle(
  //                                                   fontSize: 12.0,
  //                                                   color: Color(
  //                                                       ColorValues.BLACK_TEXT_COL),
  //                                                   fontFamily: "customRegular"),
  //                                             ),
  //                                           ),
  //                                           new Container(
  //                                             margin: const EdgeInsets.fromLTRB(
  //                                                 0.0, 5, 0, 5.0),
  //                                             child: new Text(
  //                                               //lis[index].created,
  //                                               "2 Hours Ago",
  //                                               /*item.weight
  //                                                         .replaceAll(".00", "") +
  //                                                         " " +
  //                                                         item.unit*/
  //                                               style: new TextStyle(
  //                                                   fontSize: 9.0,
  //                                                   color: ColorValues
  //                                                       .TIME_NOTITFICAITON,
  //                                                   fontFamily: "customLight"),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   flex: 1,
  //                                 ),
  //                               ],
  //                             ),
  //                             // new Container(
  //                             //   height: 0.5,
  //                             //   color: ColorValues.TIME_NOTITFICAITON,
  //                             //
  //                             // ),
  //                           ],
  //                         ),
  //                       ))),
  //             ],
  //           ),
  //         ),
  //       )));
  // }
}

import 'package:flutter/material.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List dataList;
  SharedPreferences preferences;

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

  void getNotificationsList(){
//    dataList = [];
//    dataList.add("1");
//    dataList.add("2");
//    dataList.add("3");
//    dataList.add("4");
//    print("++++++++++ ${dataList.length}");


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorValues.THEME_TEXT_COLOR),
      appBar: AppBar(
        centerTitle: true,
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: BoxDecoration(
                  color: const Color(ColorValues.WHITE),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0))),
            ),

        dataList != null && dataList.length>0?
        Positioned(
            top: 60,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child:
              ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  // physics: const ScrollPhysics(),
                  // shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int pos) {
                    return
                      Card(
                          elevation: 8,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                            child: new Column(
                              children: [
                                new Row(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Expanded(
                                      child: new Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              5.0, 5.0, 5.0, 0.0),
                                          // color: Colors.transparent,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(0.0),
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
                                        padding: const EdgeInsets.fromLTRB(
                                            10.0, 0, 0, 0),
                                        child: new Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0.0, 0, 0, 5.0),
                                          child: new Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,

                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              new Container(
                                                margin:
                                                const EdgeInsets.fromLTRB(
                                                    0.0, 10, 0, 5.0),
                                                child: new Text(
                                                  // lis[index].title,

                                                  'Lorem ipsum dolor sit amet, consectetur adip isc ing elit. Arcu nibh venenatis.',

                                                  style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: Color(ColorValues
                                                          .BLACK_TEXT_COL),
                                                      fontFamily:
                                                      "customRegular"),
                                                ),
                                              ),
                                              new Container(
                                                margin:
                                                const EdgeInsets.fromLTRB(
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
                                // new Container(
                                //   height: 0.5,
                                //   color: ColorValues.TIME_NOTITFICAITON,
                                //
                                // ),
                              ],
                            ),
                          )
                      );
                  }
              ),
//                           }),
            ),
          ):
        Positioned(
            top: 50,
            bottom: 0,
            right: 0,
            left: 0,
            child:Center(
              child: Column(
                children: [
                  Image(
                    image: AssetImage("assets/images/Nodatafound.jpg"),
                  ),
                  Text("No data available!"),
                ],
              ),
            )
        ),

          ],
        ),
      ),
    );
  }

}

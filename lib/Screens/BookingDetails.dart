import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homelabz/Models/BookingDetailsModel.dart';
import 'package:homelabz/Models/PrescriptionModel.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:homelabz/constants/ConstantMsg.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PaymentScreen.dart';

class BookingDetails extends StatefulWidget {
  final int bookingId;

  const BookingDetails(this.bookingId);

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  SharedPreferences preferences;
  BookingDetailsModel _model;
  List<PrescriptionModel> prescriptionList = [];

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    callBookingDetailsApi();
  }

  callBookingDetailsApi() async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();

    try {
      var url = Uri.parse(ApiConstants.GET_BOOKING_DETAILS + widget.bookingId.toString());
      print(url);
      print(preferences.getString(ConstantMsg.ACCESS_TOKEN));
      Map<String, String> headers = {
        ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
        ConstantMsg.HEADER_AUTH:
        "bearer " + preferences.getString(ConstantMsg.ACCESS_TOKEN),
      };
      // make GET request
      Response response = await get(
        url,
        headers: headers,
      );
      // check the status code for the result
      String body = response.body;
      print(body);

      if (response.statusCode == 200) {
        _model = BookingDetailsModel.fromJson(json.decode(body));
        setState(() {
          if(_model.bookingStatus!=null){
          }
        });
        getDocUrl();
      }
      await dialog.hide();
    } catch (ex) {
      await dialog.hide();
    }
  }

  getDocUrl() async {
    try {
      String booking = widget.bookingId.toString();
      Map<String, String> headers = {
        ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
        ConstantMsg.HEADER_AUTH:
        "bearer " + preferences.getString(ConstantMsg.ACCESS_TOKEN),
      };

      var uri = Uri.parse(ApiConstants.DOWNLOAD_ALL_DOCS+booking);

      // make GET request with query params
      final response = await get(uri, headers: headers);
      // check the status code for the result
      String body = response.body;
      print(body);
      var data = json.decode(body);
      List list = data;

      if (response.statusCode == 200) {
        // prescriptionList = [];
        // sampleList = [];

        for (int i = 0; i < list.length; i++) {
          PrescriptionModel model = PrescriptionModel.fromJson(data[i]);
          if(model.category.compareTo(ConstantMsg.CAT_PRESCRIPTION)==0) {
            prescriptionList.add(model);
          }
          // else if(model.category.compareTo(ConstantMsg.CAT_SAMPLE)==0) {
          //   sampleList.add(model);
          // }

          setState(() {

          });
        }

      }
    } catch (ex) {

    }
  }

  void callPaymentScreen() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => PaymentScreen(widget.bookingId,"BookingDetails")));
  }

  Future<void> downloadPrescription(String imagePath) async {
      try {
        var url = Uri.parse(ApiConstants.GET_DOWNLOAD_URL);
        Map<String, String> headers = {
          ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
          ConstantMsg.HEADER_AUTH:
          "bearer " + preferences.getString(ConstantMsg.ACCESS_TOKEN),
        };

        Map map = {
          ConstantMsg.KEY_PATH: imagePath,
        };

        // make POST request
        Response response = await post(url, headers: headers, body: json.encode(map));
        // check the status code for the result
        String body = response.body;
        print(body);

        var data = json.decode(body);
        if (response.statusCode == 200) {
          String keyPath = data["keyPath"];
          String imageUrl = data["presignedURL"];

          showImage(context, imageUrl);
        }
      } catch (ex) {}
    }

  void showImage(context, imageUrl) {
    showDialog(context: context, builder: (context){
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        child: Container(
          height: 250,
          width: 250,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                          Icons.cancel
                      ),
                    )
                  ],
                ),
                Image.network(
                  imageUrl,
                  width: 250,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ),
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(ColorValues.THEME_TEXT_COLOR),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(ColorValues.WHITE),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Booking Details",
          style: TextStyle(
              fontFamily: "Regular",
              fontSize: 18,
              color: Color(ColorValues.WHITE)),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        padding: EdgeInsets.only(top:10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Patient: ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(
                            ColorValues.THEME_TEXT_COLOR),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Booking ID:',
                      style: TextStyle(
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                        color: Color(
                            ColorValues.THEME_TEXT_COLOR),
                      ),
                    ),
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      _model == null
                          ? ""
                          : _model.patient.name == null
                          ? ""
                          : _model.patient.name,
                      // 'Patient name here ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(
                            ColorValues.BLACK_TEXT_COL),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      '${widget.bookingId}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(
                            ColorValues.BLACK_TEXT_COL),
                      ),
                    ),
                  ),

                ],
              ),

              Container(
                margin: EdgeInsets.fromLTRB(0, 25, 0, 15),
                child: Divider(
                  indent: 0,
                  endIndent: 0,
                  height: 2,
                  color: Color(ColorValues.GREY_TEXT_COLOR),
                ),
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Status: ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(
                              ColorValues.THEME_TEXT_COLOR),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        _model == null
                            ? ""
                            : _model.bookingStatus == null
                            ? ""
                            : _model.bookingStatus,
                        // 'New',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(
                              ColorValues.BLACK_TEXT_COL),
                        ),
                      ),
                    ),

                  ],
                ),

              ),

              Container(
                margin: EdgeInsets.fromLTRB(0, 15, 0, 25),
                child: Divider(
                  indent: 0,
                  endIndent: 0,
                  height: 2,
                  color: Color(ColorValues.GREY_TEXT_COLOR),
                ),
              ),

              Container(
                // margin: EdgeInsets.only(top: 5),
                child: Text(
                  'Address Details:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.THEME_TEXT_COLOR),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  _model == null
                      ? ""
                      : _model.address == null
                      ? ""
                      : _model.address,

                  // 'house no. 345A, Vijay Nagar, Indore',
                  style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.BLACK_TEXT_COL),
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 5),
              //   child: Text(
              //     'Indore',
              //     style: TextStyle(
              //       fontSize: 14,
              //       // fontWeight: FontWeight.bold,
              //       color: Color(
              //           ColorValues.BLACK_TEXT_COL),
              //     ),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  _model == null
                      ? ""
                      : _model.patient.mobileNumber == null
                      ? ""
                      : _model.patient.mobileNumber,

                  // '+918937846355',
                  style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.BLACK_TEXT_COL),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 25),
                child: Text(
                  'Doctor Details:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.THEME_TEXT_COLOR),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  _model != null && _model.doctor != null ?
                      _model.doctor.name :" ",
                  style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.BLACK_TEXT_COL),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  _model != null && _model.doctor != null ?
                  _model.doctor.mobileNumber :" ",
                  style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.BLACK_TEXT_COL),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 25),
                child: Text(
                  'Lab Details:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.THEME_TEXT_COLOR),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  _model == null
                      ? ""
                      : _model.lab.user.name == null
                      ? ""
                      : _model.lab.user.name,
                  // 'Lab name here',
                  style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.BLACK_TEXT_COL),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  _model == null
                      ? ""
                      : _model.lab.user.mobileNumber == null
                      ? ""
                      : _model.lab.user.mobileNumber,
                  // 'rating etc',
                  style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.BLACK_TEXT_COL),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  _model == null
                      ? ""
                      : _model.lab.user.address == null
                      ? ""
                      : _model.lab.user.address,

                  style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.BLACK_TEXT_COL),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 25),
                child: Text(
                  'Billing Details:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.THEME_TEXT_COLOR),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Payment Method: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(
                              ColorValues.BLACK_TEXT_COL),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Online',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(
                              ColorValues.BLACK_TEXT_COL),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Amount: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(
                              ColorValues.BLACK_TEXT_COL),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        _model == null
                            ? ""
                            : _model.amount == null
                            ? ""
                            : "\$"+_model.amount.toString(),
                        // '\$100',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(
                              ColorValues.BLACK_TEXT_COL),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Payment Status: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(
                              ColorValues.BLACK_TEXT_COL),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        _model == null
                            ? ""
                            : _model.paymentStatus == null
                            ? ""
                            :_model.paymentStatus,
                        // 'Paid',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(
                              ColorValues.BLACK_TEXT_COL),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              // payment Code
              _model == null
                  ? Container()
                  : _model.paymentStatus == null
                  ? Container()
                  :_model.paymentStatus.compareTo("Unpaid")==0?
              GestureDetector(
                onTap: () {
                  callPaymentScreen();
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: 20, bottom: 10, left: 25, right: 25),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  height: 35,

                  decoration: BoxDecoration(
                      color: Color(ColorValues.THEME_COLOR),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                      child: Text(
                        "Pay Now",
                        style: TextStyle(
                          color: Color(ColorValues.WHITE_COLOR),
                          fontFamily: "Regular",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )),
                ),
              )
                  :Container(),

              Container(
                margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                padding: EdgeInsets.only(left: 20),
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(ColorValues.LIGHT_GRAY),
                  border: Border.all(
                      color: Color(ColorValues.BLACK_COLOR), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          prescriptionList.length > 0
                              ? Container(
                            alignment: Alignment.centerRight,
                            height: 35,
                            width:
                            MediaQuery.of(context).size.width / 3,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: prescriptionList.length,
                                itemBuilder:
                                    (BuildContext context, int pos) {
                                  return GestureDetector(
                                      onTap: () {
                                        downloadPrescription(prescriptionList[pos].path);
                                      },
                                      child: Container(
                                          height: 50,
                                          child: Stack(
                                            children: [
                                              Container(
                                                margin: EdgeInsets
                                                    .fromLTRB(5, 5, 5, 5),
                                                child: Image(
                                                  image: AssetImage(
                                                      "assets/images/prescription_logo.jpg"),
                                                  height: 30,
                                                  width: 30,
                                                  alignment: Alignment
                                                      .centerLeft,
                                                ),
                                              ),
                                            ],
                                          ))
                                  );
                                }),
                          )
                              : new Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width / 3,
                          ),

                        ],
                      ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(0, 25, 0, 15),
                child: Divider(
                  indent: 0,
                  endIndent: 0,
                  height: 2,
                  color: Color(ColorValues.GREY_TEXT_COLOR),
                ),
              ),

              Container(
                child: Text(
                  'View Invoice',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.THEME_TEXT_COLOR),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(0, 15, 0, 25),
                child: Divider(
                  indent: 0,
                  endIndent: 0,
                  height: 2,
                  color: Color(ColorValues.GREY_TEXT_COLOR),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  Container(
                    child:Image(image: AssetImage("assets/images/contact.png"),color: Color(
                        ColorValues.THEME_TEXT_COLOR),height: 23,width: 23,),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      'Reach out to us ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(
                            ColorValues.BLACK_TEXT_COL),
                      ),
                    ),
                  ),


                ],
              ),
              GestureDetector(
                onTap: () {
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: 20, bottom: 10, left: 25, right: 25),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  height: 35,

                  decoration: BoxDecoration(
                      color: Color(ColorValues.THEME_COLOR),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                      child: Text(
                        "Need Help?",
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

            ],
          ),
        ),
      ),
    );
  }

}

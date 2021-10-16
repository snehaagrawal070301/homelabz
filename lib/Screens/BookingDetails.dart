import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homelabz/Models/BookingDetailsModel.dart';
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

      }
      await dialog.hide();
    } catch (ex) {
      await dialog.hide();
    }
  }

  void callPaymentScreen() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => PaymentScreen(widget.bookingId,"BookingDetails")));
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
                  "",
                  // _model == null
                  //     ? ""
                  //     : _model.lab.user.address == null
                  //     ? ""
                  //     : _model.lab.user.address,
                  // 'Lab Address here',
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

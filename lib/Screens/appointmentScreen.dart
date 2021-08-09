import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/Screens/paymentScreen.dart';
import 'package:homelabz/components/colorValues.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppointmentScreenState();
  }
}

class AppointmentScreenState extends State<AppointmentScreen> {
  String type = 'Preferred Lab';
  String gender = "male";
  TextEditingController address = TextEditingController();
  TextEditingController dob = TextEditingController();
  File imageFile;
  DateTime selectedDate;

  Future<Null> selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2022),
        fieldLabelText: 'Date of Birth',
        fieldHintText: 'yyyy-MM-dd',
        helpText: 'Select Date of Birth',
        // Can be used as title
        // cancelText: 'Not now',
        // confirmText: 'Book',
        //Theme
        // builder: (context, child) {
        //   return Theme(
        //     data: ThemeData.light(), // This will change to light theme.
        //     child: child,
        //   );
        // },
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter date in valid range',
        initialDatePickerMode: DatePickerMode.year,
        context: context);
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(ColorValues.WHITE_COLOR),
        appBar: AppBar(
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
            "Appointment",
            style: TextStyle(
                fontFamily: "Regular",
                fontSize: 18,
                color: Color(ColorValues.THEME_COLOR)),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
              children: [

//              margin: EdgeInsets.only(
//                  bottom: MediaQuery.of(context).size.height * 68),

              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    color: Color(ColorValues.THEME_COLOR),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 32),
                            child: Text(
                              "Patient Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: "Regular",
                                  color: Color(0xffFFFFFF)),
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Image(
                              height: 57,
                              width: 103,
                              image: AssetImage("assets/images/appointmentUndraw.png"),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(ColorValues.WHITE_COLOR),
                    height: MediaQuery.of(context).size.height,
                  )
                ],
              ),

            Positioned(
              left: 15,
              right: 15,
              top: 98,
              child: Container(
                //height: MediaQuery.of(context).size.height * 0.58,
                height: 600,
                width: MediaQuery.of(context).size.width,
//                alignment: Alignment.center,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 30, right: 20, left: 20),
                        padding: EdgeInsets.only(left: 15),
                        height: 38,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(ColorValues.LIGHT_GRAY),
                          border: Border.all(
                              color: Color(ColorValues.BLACK_COLOR), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: type,
                            iconSize: 24,
                            dropdownColor: Color(ColorValues.WHITE_COLOR),
                            iconEnabledColor: Color(ColorValues.BLACK_COLOR),
                            focusColor: Color(ColorValues.WHITE_COLOR),
                            elevation: 16,
                            style: TextStyle(
                                color: Color(ColorValues.BLACK_TEXT_COL),
                                fontSize: 12,
                                fontFamily: "Regular"),
                            onChanged: (String newValue) {
                              setState(() {
                                type = newValue;
                              });
                            },
                            items: <String>[
                              'Preferred Lab',
                              'Electronic bank transfer'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 24, right: 20, left: 20),
                      padding: EdgeInsets.only(left: 5),
                      height: 38,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(ColorValues.LIGHT_GRAY),
                        border: Border.all(
                            color: Color(ColorValues.BLACK_COLOR), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: address,
                        validator: (value) {
                          return value.isEmpty ? "Please Enter Address" : null;
                        },
                        decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: "Address",
                            hintStyle: TextStyle(
                                color: Color(ColorValues.BLACK_TEXT_COL),
                                fontSize: 12.0,
                                fontFamily: "Regular")),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 24, right: 20, left: 20),
                      height: 38,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(ColorValues.LIGHT_GRAY),
                        border: Border.all(
                            color: Color(ColorValues.BLACK_COLOR), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      /*child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: dob,
                        validator: (value) {
                          return value.isEmpty ? "Please Enter date of birth" : null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                            hintText: "Date of Birth",
                            hintStyle: TextStyle(
                                color: Color(ColorValues.BLACK_TEXT_COL),
                                fontSize: 12.0,
                                fontFamily: "Regular")),
                      ),*/
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (selectedDate == null)
                              Text("Date of Birth",
                                  style: TextStyle(
                                      color: Color(ColorValues.BLACK_TEXT_COL),
                                      fontSize: 12.0,
                                      fontFamily: "Regular"))
                            else
                              TextFormField(
                                controller: dob,
                                enabled: false,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintStyle: TextStyle(
                                      color: Color(ColorValues.TEXT_COL_GREY),
                                      fontSize: 16.0,
                                    )),
                              ),
                            GestureDetector(
                              onTap: () {
                                selectDate(context);
                                print(selectedDate.toString());
                              },
                              child: ImageIcon(
                                AssetImage('assets/images/calendarImage.png'),
                                color: Color(ColorValues.THEME_TEXT_COLOR),
                                size: 25,
                              ),
                            ),

                            /* if(selectedDate == DateTime.now())
                              Text("Date of Birth",
                                style:TextStyle(
                                  color: Color(ColorValues.BLACK_TEXT_COL),
                                  fontSize: 12.0,
                                  fontFamily: "Regular"))
                            else
                               Text(
                                  "${selectedDate.toLocal()}".split(' ')[0],
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                            GestureDetector(
                                onTap: () {
                                  selectDate(context);
                                  print(selectedDate.toString());
                                },
                                child: Icon(Icons.calendar_today)),*/
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 14, left: 20, right: 20),
                      child: Text(
                        "Gender",
                        style: TextStyle(
                            fontFamily: "Black",
                            fontSize: 12,
                            color: Color(ColorValues.BLACK_COLOR)),
                      ),
                    ),
                    Container(
                      height: 36,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 11, left: 20, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  gender = "male";
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(ColorValues.THEME_COLOR),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Male",
                                    style: TextStyle(
                                        fontFamily: "Regular",
                                        fontSize: 12,
                                        color: Color(ColorValues.WHITE_COLOR),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  gender = "female";
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(ColorValues.LIGHT_GRAY),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    border: Border.all(
                                        color: Color(ColorValues.BLACK_COLOR),
                                        width: 1),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Female",
                                    style: TextStyle(
                                        fontFamily: "Regular",
                                        fontSize: 12,
                                        color: Color(ColorValues.THEME_COLOR),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 18, right: 20, left: 20),
                      padding: EdgeInsets.only(left: 18),
                      height: 74,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(ColorValues.LIGHT_GRAY),
                        border: Border.all(
                            color: Color(ColorValues.BLACK_COLOR), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showPicker(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 8, left: 5, right: 5),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/uploadLogo.png"),
                                      height: 28,
                                      width: 25,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                if (imageFile != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      imageFile,
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                              ],
                            ),
                            Container(
                              child: Text(
                                "Upload your prescription",
                                style: TextStyle(
                                    fontFamily: "Regular",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Color(ColorValues.BLACK_TEXT_COL)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                        height: 38,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(ColorValues.THEME_COLOR),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Center(
                          child: Text(
                            "CONTINUE",
                            style: TextStyle(
                                fontFamily: "Regular",
                                fontSize: 15,
                                color: Color(ColorValues.WHITE_COLOR)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
//                    SizedBox(
//                      height: 30,
//                    )
                  ],
                ),
              ),
            ),

          ]),
        ));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Color(ColorValues.WHITE_COLOR),
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Get from gallery
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      imageFile = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      imageFile = image;
    });
  }
}

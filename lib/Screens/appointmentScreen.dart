import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homelabz/Models/LabResponse.dart';
import 'package:homelabz/Models/PreSignedUrlResponse.dart';
import 'package:homelabz/Screens/MakeAppointmentScreen.dart';
import 'package:homelabz/Screens/bottomNavigationBar.dart';
import 'package:homelabz/Screens/paymentScreen.dart';
import 'package:homelabz/constants/ConstantMsg.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentScreen extends StatefulWidget {
  final String date;
  final String slot;

  const AppointmentScreen(this.date, this.slot);

  @override
  State<StatefulWidget> createState() {
    return AppointmentScreenState();
  }
}

class AppointmentScreenState extends State<AppointmentScreen> {
//  final AppointmentScreen obj;
//  AppointmentScreenState({Key key, @required this.obj}) : super(key: key);
  String labName;
  String doctor;
  String gender;
  TextEditingController address = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController dob = TextEditingController();
  File imageFile;
  PreSignedUrlResponse responseModel;
  List<DocumentPresignedURLModelList> urlList;
  String fileExt;

//  DateTime selectedDate;
  String convertedDateTime;
  int pos;
  List<LabResponse> _labs;
  List<String> labNameList=[];
  SharedPreferences preferences;

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
    callAllLabsApi();
  }

  Future selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        fieldLabelText: 'Date of Birth',
        fieldHintText: 'yyyy-MM-dd',
        helpText: 'Select Date of Birth',
        // Can be used as title
        // cancelText: 'Not now',
        // confirmText: 'Book',

        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(
                primary: Color(ColorValues.THEME_TEXT_COLOR),
              ),
            ),
            child: child,
          );
        },
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter date in valid range',
        initialDatePickerMode: DatePickerMode.day,
        context: context);
    if (pickedDate != null) {
      setState(() {
        convertedDateTime =
            "${pickedDate.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

/*
}*/

  void callPaymentScreen(int bookingId) {
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => PaymentScreen(bookingId)));
  }

  void callAllLabsApi() async {
    try {
      var url = Uri.parse(ApiConstants.GET_ALL_LABS);
      Map<String, String> headers = {
        ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
      };
      // make POST request
      Response response = await get(
        url,
        headers: headers,
      );
      // check the status code for the result
      String body = response.body;
      print(body);

      if (response.statusCode == 200) {
        _labs = [];
        labNameList =[];

        var data = json.decode(body);
        List list = data;

        for(int i=0; i<list.length; i++) {
          LabResponse model = LabResponse.fromJson(data[i]);
          _labs.add(model);
          labNameList.add(model.user.name);
        }
        print(labNameList);
      }
    } catch (ex) {
      print("ERROR+++++++++++++  ${ex}");
    }
  }

  void validateData() {
    String addrs = address.text;

//    if(labId==null){
//    showToast();
//    return;
//  }else
    if (addrs != null && addrs.length > 0) {
      if (convertedDateTime != null && convertedDateTime.length > 0) {
        if (gender != null && gender.length > 0) {
          if (imageFile != null) {
            getPreSignedUrl(fileExt);
          } else {
            showToast(ConstantMsg.PRESCRIPTION_VALIDATION);
          }
        } else {
          showToast(ConstantMsg.GENDER_VALIDATION);
        }
      } else {
        showToast(ConstantMsg.DOB_VALIDATION);
      }
    } else {
      showToast(ConstantMsg.ADDRESS_VALIDATION);
    }
  }

  void callBookAppointmentApi() async {
    try {
      var url = Uri.parse(ApiConstants.BOOK_APPOINTMENT);
      Map<String, String> headers = {
        ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
        ConstantMsg.HEADER_AUTH:
            "bearer " + preferences.getString(ConstantMsg.ACCESS_TOKEN),
      };

      Map patient = {
        ConstantMsg.ID: preferences.getString(ConstantMsg.ID),
      };
      Map bookedBy = {
        ConstantMsg.ID: preferences.getString(ConstantMsg.ID),
        ConstantMsg.IMAGE_PATH: urlList[0].keyPath,
        ConstantMsg.IMG_PRE_SIGNED_URL: urlList[0].presignedURL,
      };
      Map lab = {
        ConstantMsg.ID: 1,
      };
      Map mapBody = {
        ConstantMsg.PATIENT: patient,
        ConstantMsg.BOOKED_BY: bookedBy,
        ConstantMsg.LAB: lab,
        ConstantMsg.ADDRESS: address.text,
        ConstantMsg.DATE: "",
        ConstantMsg.GENDER: gender,
        //ConstantMsg.ID: 0,
        ConstantMsg.IS_ASAP: "true",
        ConstantMsg.DOB: convertedDateTime,
      };
      print(mapBody);
      // make POST request
      Response response =
          await post(url, headers: headers, body: json.encode(mapBody));

      String body = response.body;
      var data = json.decode(body);
      print(body);

      if (response.statusCode == 200) {
        int id = data["id"];
        print(id);

        callPaymentScreen(id);
      } else {}
    } catch (e) {
      print("Error+++++" + e.toString());
    }
  }

  /// Get from gallery
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    print(image.path);

    String fileName = (image.path.split('/').last);
    fileExt = "." + (image.path.split('.').last);
    String filePath = image.path.replaceAll("/$fileName", '');

    print("fileName " + fileName);
    print("fileExt " + fileExt);

    setState(() {
      imageFile = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    print(image.path);

    String fileName = (image.path.split('/').last);
    fileExt = "." + (image.path.split('.').last);
    String filePath = image.path.replaceAll("/$fileName", '');

    print("fileName " + fileName);
    print("fileExt " + fileExt);

    setState(() {
      imageFile = image;
    });
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
    );
  }

  Future<void> getPreSignedUrl(String fileExt) async {
    String imageName =
        "image_" + DateTime.now().millisecondsSinceEpoch.toString() + fileExt;
    try {
      var url = Uri.parse(ApiConstants.PRE_SIGNED_URL);
      Map<String, String> headers = {
        ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
        ConstantMsg.HEADER_AUTH:
            "bearer " + preferences.getString(ConstantMsg.ACCESS_TOKEN),
      };

      List list = [];
      Map list1 = {
        ConstantMsg.KEY_NAME: imageName,
      };
      list.add(list1);

      Map mapBody = {
        ConstantMsg.USER_ID: preferences.getString(ConstantMsg.ID),
        ConstantMsg.DOC_CATEGORY: "BOOKING",
        ConstantMsg.PRE_SIGNED_LIST: list
      };
      print(mapBody);
      // make POST request
      Response response =
          await post(url, headers: headers, body: json.encode(mapBody));

      String body = response.body;
      print(body);

      if (response.statusCode == 200) {
        urlList = [];
        responseModel = PreSignedUrlResponse.fromJson(json.decode(body));
        urlList.addAll(responseModel.documentPresignedURLModelList);
        print(urlList[0].presignedURL);
        uploadImage();
      } else {}
    } catch (e) {
      print("Error+++++" + e.toString());
    }
  }

  Future<void> uploadImage() async {
    try {
      var url = Uri.parse(urlList[0].presignedURL);
      // make PUT request
      Response response = await put(url, body: await imageFile.readAsBytes());
      if (response.statusCode == 200) {
        print("=== Success ===");
        if (widget.date == null) {
          callBookAppointmentApi();
        } else {
          callBookAppointmentApiByDate();
        }
      } else {}
    } catch (e) {
      print("Error+++++" + e.toString());
    }
  }

  void callBookAppointmentApiByDate() async {
    try {
      var url = Uri.parse(ApiConstants.BOOK_APPOINTMENT);
      Map<String, String> headers = {
        ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
        ConstantMsg.HEADER_AUTH:
            "bearer " + preferences.getString(ConstantMsg.ACCESS_TOKEN),
      };

      Map patient = {
        ConstantMsg.ID: preferences.get(ConstantMsg.ID),
      };
      Map bookedBy = {
        ConstantMsg.ID: preferences.getString(ConstantMsg.ID),
        ConstantMsg.IMAGE_PATH: urlList[0].keyPath,
        ConstantMsg.IMG_PRE_SIGNED_URL: urlList[0].presignedURL,
      };
      Map lab = {
        ConstantMsg.ID: 1,
      };
      Map mapBody = {
        ConstantMsg.PATIENT: patient,
        ConstantMsg.BOOKED_BY: bookedBy,
        ConstantMsg.LAB: lab,
        ConstantMsg.ADDRESS: address.text,
        ConstantMsg.DATE: widget.date,
        ConstantMsg.GENDER: gender,
        //ConstantMsg.ID: 0,
        ConstantMsg.REMARKS: remarks.text,
        ConstantMsg.IS_ASAP: "false",
        ConstantMsg.DOB: convertedDateTime,
      };
      print(mapBody);
      // make POST request
      Response response =
          await post(url, headers: headers, body: json.encode(mapBody));

      String body = response.body;
      var data = json.decode(body);
      print(body);

      if (response.statusCode == 200) {
        int id = data["id"];
        print(id);
        callPaymentScreen(id);
      } else {}
    } catch (e) {
      print("Error+++++" + e.toString());
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
        child: Container(
          color: Color(ColorValues.WHITE_COLOR),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
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
                            color: Color(ColorValues.WHITE_COLOR)),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Image(
                        height: 60,
                        width: 100,
                        image:
                            AssetImage("assets/images/appointmentUndraw.png"),
                      )),
                ],
              ),
            ),
            Positioned(
              left: 15,
              right: 15,
              top: 98,
              bottom: 10,
              child: Container(
                width: MediaQuery.of(context).size.width,
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
                child: ListView(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            value: labName,
                            iconSize: 24,
                            hint: Text(" Preferred Lab"),
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
//                                pos=labNameList.indexOf(newValue);
//                                print(pos);
                                labName = newValue;
                              });
                            },
                            items: labNameList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )),
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
                            value: doctor,
                            iconSize: 24,
                            hint: Text("Doctor"),
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
                                doctor = newValue;
                              });
                            },
                            items: <String>['Doctor 1', 'Doctor 2']
                                .map<DropdownMenuItem<String>>((String value) {
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
                      margin: EdgeInsets.fromLTRB(20, 24, 20, 10),
                      // margin: EdgeInsets.only(top: 24, right: 20, left: 20),
                      height: 38,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(ColorValues.LIGHT_GRAY),
                        border: Border.all(
                            color: Color(ColorValues.BLACK_COLOR), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (convertedDateTime == null)
                              Text("Date of Birth",
                                  style: TextStyle(
                                      color: Color(ColorValues.BLACK_TEXT_COL),
                                      fontSize: 12.0,
                                      fontFamily: "Regular"))
                            else
                              Text(convertedDateTime,
                                  style: TextStyle(
                                      color: Color(ColorValues.BLACK_TEXT_COL),
                                      fontSize: 12.0,
                                      fontFamily: "Regular")),
                            GestureDetector(
                              onTap: () {
                                selectDate(context);
                              },
                              child: ImageIcon(
                                AssetImage('assets/images/calendarImage.png'),
                                size: 20,
                              ),
                            ),
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
                                    setState(() {
                                      gender = "MALE";
                                    });
                                  },
                                  child: gender == "MALE"
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Color(ColorValues.THEME_COLOR),
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
                                                color: Color(
                                                    ColorValues.WHITE_COLOR),
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          )),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Color(ColorValues.LIGHT_GRAY),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                topLeft: Radius.circular(10)),
                                            border: Border.all(
                                                color: Color(
                                                    ColorValues.BLACK_COLOR),
                                                width: 1),
                                          ),
                                          child: Center(
                                              child: Text(
                                            "Male",
                                            style: TextStyle(
                                                fontFamily: "Regular",
                                                fontSize: 12,
                                                color: Color(ColorValues
                                                    .THEME_TEXT_COLOR),
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          )),
                                        ))),
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      gender = "FEMALE";
                                    });
                                  },
                                  child: gender == "FEMALE"
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Color(ColorValues.THEME_COLOR),
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Female",
                                              style: TextStyle(
                                                  fontFamily: "Regular",
                                                  fontSize: 12,
                                                  color:
                                                      Color(ColorValues.WHITE),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ))
                                      : Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Color(ColorValues.LIGHT_GRAY),
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            border: Border.all(
                                                color: Color(
                                                    ColorValues.BLACK_COLOR),
                                                width: 1),
                                          ),
                                          child: Center(
                                              child: Text(
                                            "Female",
                                            style: TextStyle(
                                                fontFamily: "Regular",
                                                fontSize: 12,
                                                color: Color(
                                                    ColorValues.THEME_COLOR),
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          )),
                                        ))),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                      padding: EdgeInsets.only(left: 20),
                      height: 75,
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
                    Container(
                      margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                      padding: EdgeInsets.only(left: 10),
                      // height: 75,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(ColorValues.LIGHT_GRAY),
                        border: Border.all(
                            color: Color(ColorValues.BLACK_COLOR), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: remarks,
                        decoration: InputDecoration(hintText: "Remarks..!!"),
                        maxLines: 3,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        validateData();
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
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
}

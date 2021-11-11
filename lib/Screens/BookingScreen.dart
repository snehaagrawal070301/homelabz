import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homelabz/Models/DoctorModel.dart';
import 'package:homelabz/Models/LabResponse.dart';
import 'package:homelabz/Models/PreSignedUrlResponse.dart';
import 'package:homelabz/Screens/BottomNavBar.dart';
import 'package:homelabz/Screens/PaymentScreen.dart';
import 'package:homelabz/Screens/address_search.dart';
import 'package:homelabz/Services/place_service.dart';
import 'package:homelabz/constants/ConstantMsg.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UploadData {
  File imageFile;
  String fileExt, imageName;

  UploadData(this.imageFile, this.fileExt, this.imageName);
}

class BookingScreen extends StatefulWidget {
  final String date;
  final String slot;

  const BookingScreen(this.date, this.slot);

  @override
  State<StatefulWidget> createState() {
    return BookingScreenState();
  }
}

class BookingScreenState extends State<BookingScreen> {
//  final AppointmentScreen obj;
//  AppointmentScreenState({Key key, @required this.obj}) : super(key: key);

  String gender;
  // TextEditingController address = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController dob = TextEditingController();
  PreSignedUrlResponse responseModel;
  List<DocumentPresignedURLModelList> urlList;
  String fileExt;
  DateTime selectedDate = DateTime.now();
  List<UploadData> imageList = [];
  ProgressDialog dialog;
  int uploadCount = 0;
  File imageToDisplay;
//  DateTime selectedDate;
  String convertedDateTime;
  int selectedLabId;
  int selectedDoctorId;
  List<LabResponse> _labs;
  List<DoctorResponse> _doctor;
  LabResponse labName;
  DoctorResponse doctorName;
  SharedPreferences preferences;
  String searchAddress="";

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    callAllLabsApi();
    callDoctorApi();
    if(preferences.getString("address")!=null){
    searchAddress = preferences.getString("address");
    }

    if(preferences.getString("dob")!=null){
      convertedDateTime = preferences.getString("dob");
    }

    if(preferences.getString("gender")!=null){
      gender = preferences.getString("gender");
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    print("Date ======== ${widget.date} ======== ${widget.slot}");
    getSharedPreferences();
  }

  Future selectDate(BuildContext context,String selecteddate) async {
    final pickedDate = await showDatePicker(
        initialDate: selectedDate,
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
        selectedDate=pickedDate;
        convertedDateTime =
            "${pickedDate.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }


  void callPaymentScreen(int bookingId) {
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => PaymentScreen(bookingId,"")));
  }

  void callDoctorApi() async {
    try {
      var url = Uri.parse(ApiConstants.GET_ALL_DOCTOR);
      Map<String, String> headers = {
        ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
        ConstantMsg.HEADER_AUTH: "bearer " + preferences.getString(ConstantMsg.ACCESS_TOKEN),
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
        _doctor = [];

        var data = json.decode(body);
        List list = data;

        for (var obj in list) {
          DoctorResponse model = DoctorResponse.fromJson(obj);
          if(model.name!=null && model.name.length>0)
            _doctor.add(model);
        }

        // for (int i = 0; i < list.length; i++) {
        //   DoctorResponse model = DoctorResponse.fromJson(data[i]);
        //   if(model.name!=null && model.name.length>0)
        //   _doctor.add(model);
        // }
        setState(() {});
      }
    } catch (ex) {
      print("ERROR+++++++++++++  ${ex}");
    }
  }

  void callAllLabsApi() async {
    print(widget.date);
    try {
      var url = Uri.parse(ApiConstants.GET_ALL_LABS);
      Map<String, String> headers = {
        ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
        ConstantMsg.HEADER_AUTH: "bearer " + preferences.getString(ConstantMsg.ACCESS_TOKEN),
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

        var data = json.decode(body);
        List list = data;
        for (var obj in list) {
          LabResponse model = LabResponse.fromJson(obj);
          _labs.add(model);
        }
      }
      setState(() {});
    } catch (ex) {
      print("ERROR+++++++++++++  ${ex}");
    }
  }

  void validateData() {
    if (selectedLabId != null) {
      if (searchAddress != null && searchAddress.length > 0) {
        if (convertedDateTime != null && convertedDateTime.length > 0) {
          if (gender != null && gender.length > 0) {
            if (imageList != null && imageList.length>0) {
              getPreSignedUrl();
            } else {
              // showToast(ConstantMsg.PRESCRIPTION_VALIDATION);
              String remarkVal = remarks.text;
              if(remarkVal!=null && remarkVal.length>0){
                if (widget.date == null) {
                  // callBookAppointmentApi();
                  callBookAppointmentApiByDate(true);
                } else {
                  callBookAppointmentApiByDate(false);
                }
              }else{
                showToast(ConstantMsg.REMARKS_VALIDATION);
              }
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
    } else {
      showToast(ConstantMsg.LAB_VALIDATION);
    }
  }


  showAlertDialog(BuildContext context, int pos) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK", style: TextStyle(
        color: Color(ColorValues.THEME_TEXT_COLOR),
      ),),
      onPressed: () {
        removeImage(pos);
        Navigator.of(context).pop();
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
      title: Text("Remove Prescription"),
      content: Text("Do you want to remove this prescription?"),
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

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
    );
  }

  void showImage(context) {
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
                Image.file(
                imageToDisplay,
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

  void removeImage(int pos) async {
    setState(() {
      imageList.removeAt(pos);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Color(ColorValues.WHITE),
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

  _imgFromCamera() async {
    PickedFile pickedFile =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    File imageFile = File(pickedFile.path);
    imageToDisplay=imageFile;
    setData(imageFile);
  }

  _imgFromGallery() async {
    PickedFile pickedFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    File imageFile = File(pickedFile.path);
    imageToDisplay=imageFile;
    setData(imageFile);
  }

  void setData(File imageFile) {
    String fileName = (imageFile.path.split('/').last);
    String fileExt = "." + (imageFile.path.split('.').last);
    String filePath = imageFile.path.replaceAll("/$fileName", '');
    String imageName =
        "image_" + DateTime.now().millisecondsSinceEpoch.toString() + fileExt;

    UploadData model = new UploadData(imageFile, fileExt, imageName);
    imageList.add(model);

    setState(() {
      // imageFile = imageFile;
    });
  }

  Future<void> getPreSignedUrl() async {
    dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();

    try {
      var url = Uri.parse(ApiConstants.PRE_SIGNED_URL);
      Map<String, String> headers = {
        ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
        ConstantMsg.HEADER_AUTH:
            "bearer " + preferences.getString(ConstantMsg.ACCESS_TOKEN),
      };

      List list = [];
      for (int i = 0; i < imageList.length; i++) {
        Map list1 = {
          ConstantMsg.KEY_NAME: imageList[i].imageName,
        };
        list.add(list1);
      }
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
        for (int i = 0; i < urlList.length; i++) {
          uploadImage(urlList[i].presignedURL, imageList[i].imageFile);
        }
      } else {}
    } catch (e) {
      print("Error+++++" + e.toString());
    }
  }

  Future<void> uploadImage(String uploadUrl, File imageFile) async {
    try {
      var url = Uri.parse(uploadUrl);
      // make PUT request
      Response response = await put(url, body: await imageFile.readAsBytes());
      if (response.statusCode == 200) {
        print("=== Success ===");
        uploadCount++;
        if (uploadCount == urlList.length) {
          // call Save api here
          uploadCount=0;
          if (widget.date == null) {
            callBookAppointmentApiByDate(true);
          } else {
            callBookAppointmentApiByDate(false);
          }
        }
      } else {}
    } catch (e) {
      print("Error+++++" + e.toString());
    }
  }

  void callBookAppointmentApiByDate(bool isASAP) async {
    try {
      var url = Uri.parse(ApiConstants.BOOK_APPOINTMENT);
      Map<String, String> headers = {
        ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
        ConstantMsg.HEADER_AUTH:
            "bearer " + preferences.getString(ConstantMsg.ACCESS_TOKEN),
      };
      print(preferences.getString(ConstantMsg.ACCESS_TOKEN));
      Map patient = {
        ConstantMsg.ID: preferences.get(ConstantMsg.ID),
      };
      Map bookedBy = {
        ConstantMsg.ID: preferences.getString(ConstantMsg.ID),
      };
      Map lab = {
        ConstantMsg.ID: selectedLabId,
      };

      List docList;
      if(urlList!=null && urlList.length>0) {
        Map userMap = {ConstantMsg.ID: preferences.getString(ConstantMsg.ID)};
        docList = [];
        for (int i = 0; i < urlList.length; i++) {
          Map list1 = {
            "category": "BOOKING",
            "name": urlList[i].keyName,
            "path": urlList[i].keyPath,
            "user": userMap
          };
          docList.add(list1);
        }
      }

      Map doctor;
      if (selectedDoctorId != null) {
        doctor = {
          ConstantMsg.ID: selectedDoctorId,
        };
      }

      Map mapBody = {
          ConstantMsg.PATIENT: patient,
          ConstantMsg.BOOKED_BY: bookedBy,
          ConstantMsg.LAB: lab,

        if(selectedDoctorId!=null)
          ConstantMsg.DOCTOR: doctor,

          ConstantMsg.ADDRESS: searchAddress,
          ConstantMsg.DATE: widget.date,
          ConstantMsg.TIME_FROM: widget.slot,
          ConstantMsg.GENDER: gender,
          ConstantMsg.REMARKS: remarks.text,
          ConstantMsg.IS_ASAP: isASAP,
          ConstantMsg.DOB: convertedDateTime,

        if(urlList!=null && urlList.length>0)
          ConstantMsg.DOC_LIST: docList,

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

  Future<void> callPlacesApi() async {
    // generate a new token here
    final sessionToken = Uuid().v4();
    final Suggestion result =
    await showSearch(context: context, delegate: AddressSearch(sessionToken)
      // delegate: AddressSearch(sessionToken),
    );
    // This will change the text displayed in the TextField
    if (result != null) {
      final placeDetails = await PlaceApiProvider(sessionToken)
          .getPlaceDetailFromId(result.placeId);
      setState(() {
        print(result.description);
        print(placeDetails.streetNumber);
        print(placeDetails.street);
        print(placeDetails.city);
        print(placeDetails.zipCode);

        if(placeDetails.streetNumber==null){
          searchAddress = "${placeDetails.street}, "+"${placeDetails.city}, "+"${placeDetails.state}, "
              +"${placeDetails.country}";
        }else{
          searchAddress = "${placeDetails.streetNumber}, "+"${placeDetails.street}, "+"${placeDetails.city}, "
              +"${placeDetails.state}, "+"${placeDetails.country}";
        }

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
      body: Container(
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
                      image: AssetImage("assets/images/appointmentUndraw.png"),
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
                    child: _labs != null
                        ? DropdownButtonHideUnderline(
                            child: DropdownButton<LabResponse>(
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
                              onChanged: (LabResponse newValue) {
                                setState(() {
                                  selectedLabId = newValue.id;
                                  print(selectedLabId);
                                  labName = newValue;
                                });
                              },
                              items: _labs.map<DropdownMenuItem<LabResponse>>(
                                  (LabResponse value) {
                                return DropdownMenuItem<LabResponse>(
                                  value: value,
                                  child: Text(value.user.name),
                                );
                              }).toList(),
                            ),
                          )
                        : Container(),
                  ),
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
                    child: _doctor != null
                        ? DropdownButtonHideUnderline(
                            child: DropdownButton<DoctorResponse>(
                              value: doctorName,
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
                              onChanged: (DoctorResponse newValue) {
                                setState(() {
                                  selectedDoctorId = newValue.id;
                                  print(selectedDoctorId);
                                  doctorName = newValue;
                                });
                              },
                              items: _doctor
                                  .map<DropdownMenuItem<DoctorResponse>>(
                                      (DoctorResponse value) {
                                return DropdownMenuItem<DoctorResponse>(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }).toList(),
                            ),
                          )
                        : Container(),
                  ),
                  GestureDetector(
                    onTap: () {
                      callPlacesApi();
                    },
                    child: Container(
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
                      child: new Padding(
                        padding: EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: searchAddress == ""
                              ? Text(
                            "Select Address",
                            style: TextStyle(
                              fontFamily: 'customLight',
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                              color: Color(ColorValues.HINT_COL),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                              : Text(
                            searchAddress,
                            style: TextStyle(
                                color: Color(ColorValues.BLACK_COL),
                                fontSize: 13.0,
                                fontFamily: "Regular"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectDate(context,convertedDateTime);
                    },
                    child: Container(
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
                                if(convertedDateTime!=null)
                                  selectDate(context,convertedDateTime);
                                else
                                  selectDate(context,null);
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
                    margin: EdgeInsets.only(top: 11, left: 20, right: 20, bottom: 10),
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
                                              color: Color(
                                                  ColorValues.WHITE_COLOR),
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        )),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: Color(ColorValues.LIGHT_GRAY),
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
                                              color: Color(
                                                  ColorValues.THEME_TEXT_COLOR),
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
                                          color: Color(ColorValues.THEME_COLOR),
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Female",
                                            style: TextStyle(
                                                fontFamily: "Regular",
                                                fontSize: 12,
                                                color: Color(ColorValues.WHITE),
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ))
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: Color(ColorValues.LIGHT_GRAY),
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
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
                    margin: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              imageList.length > 0
                                  ? Container(
                                      alignment: Alignment.centerRight,
                                      height: 35,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: imageList.length,
                                          itemBuilder:
                                              (BuildContext context, int pos) {
                                            return GestureDetector(
                                                onTap: () {
                                                  showImage(context);
                                                  // download and show
                                                },
                                                child: Container(
                                                    height: 50,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  5, 7, 5, 0),
                                                          child: Image(
                                                            image: AssetImage(
                                                                "assets/images/prescription_logo.jpg"),
                                                            height: 30,
                                                            width: 30,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                          ),
                                                        ),
                                                        Positioned(
                                                            right: 0,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                showAlertDialog(context,pos);
                                                              },
                                                              child: Image(
                                                                image: AssetImage(
                                                                    "assets/images/close_red.png"),
                                                                height: 15,
                                                                width: 15,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              ),
                                                            ))
                                                      ],
                                                    ))
                                                // Container(
                                                //   alignment: Alignment.center,
                                                //   margin: EdgeInsets.only(
                                                //       right: 5),
                                                //   child: Image(
                                                //     image: AssetImage(
                                                //         "assets/images/logout.png"),
                                                //     height: 28,
                                                //     width: 25,
                                                //     alignment: Alignment
                                                //         .centerLeft,
                                                //   ),
                                                // ),
                                                );
                                          }),
                                    )
                                  : new Container(
                                      height: 35,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                    ),

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
                                    height: 30,
                                    width: 30,
                                    // alignment: Alignment.center,
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  // margin: EdgeInsets.all(5),
                                  height: 35,
                                  width: MediaQuery.of(context).size.width / 3,
                                ),
                              )

                              ///////////////////////////////////////////////////////////
                              // if (imageFile != null)
                              //   ClipRRect(
                              //     borderRadius: BorderRadius.circular(10),
                              //     child: Image.file(
                              //       imageFile,
                              //       width: 30,
                              //       height: 30,
                              //       fit: BoxFit.fitHeight,
                              //     ),
                              //   )
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
                    // padding: EdgeInsets.only(left: 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(ColorValues.LIGHT_GRAY),
                      border: Border.all(
                          color: Color(ColorValues.BLACK_COLOR), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: TextFormField(
                        controller: remarks,
                        maxLines: 3,
                        decoration: InputDecoration(
                            border:
                            OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: "Remarks!",
                            hintStyle: TextStyle(
                                color: Color(ColorValues.BLACK_TEXT_COL),
                                fontSize: 12.0,
                                fontFamily: "Regular")),
                      ),
                    ),
                    // TextField(
                    //   controller: remarks,
                    //   decoration: InputDecoration(hintText: "Remarks..!!"),
                    //      style:  TextStyle(fontSize: 12.0,
                    //       fontFamily: "Regular",),
                    //   maxLines: 3,
                    // ),
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
                          "Continue",
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
      bottomNavigationBar: BottomNavBar("bookingScreen"),
    );
  }
}

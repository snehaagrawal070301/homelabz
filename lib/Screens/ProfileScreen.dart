import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homelabz/Models/PreSignedUrlResponse.dart';
import 'package:homelabz/Models/UserDetails.dart';
import 'package:homelabz/Screens/address_search.dart';
import 'package:homelabz/Services/place_service.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:homelabz/constants/ConstantMsg.dart';
import 'package:homelabz/constants/ValidationMsgs.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _name;
  TextEditingController _phone = new TextEditingController();
  TextEditingController _dob = new TextEditingController();
  TextEditingController _education = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  bool _flag = false;
  var isLoading = true;
  String convertedDateTime;
  File imageFile;
  PreSignedUrlResponse responseModel;
  List<DocumentPresignedURLModelList> urlList;
  String fileExt;
  bool uploadFlag = false;
  SharedPreferences preferences;
  Uint8List bytes;
  ProgressDialog dialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    try {
      setState(() {
        isLoading = true;
      });

      var url = Uri.parse(ApiConstants.GET_USER_DETAILS +
          preferences.getString(ConstantMsg.ID).toString());
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
        UserDetails model = UserDetails.fromJson(json.decode(body));
        setState(() {
          _name = new TextEditingController(text: model.name);
          _phone = new TextEditingController(text: model.mobileNumber);
          _dob = new TextEditingController(text: model.dob);
          _education = new TextEditingController(text: model.education);
          _address = new TextEditingController(text: model.address);

          // imageUrl = model.imagePresignedURL;
          if (model.imagePath != null && model.imagePath.length > 0) {
            downloadImageUrl(model.imagePath);
          }
          isLoading = false;
        });
      }
    } catch (ex) {
      setState(() {
        isLoading = true;
      });
    }
  }

  Future<void> downloadImageUrl(String imagePath) async {
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
      Response response =
      await post(url, headers: headers, body: json.encode(map));
      // check the status code for the result
      String body = response.body;
      print(body);

      var data = json.decode(body);
      if (response.statusCode == 200) {
        String keyPath = data["keyPath"];
        String url = data["presignedURL"];

        ByteData imageData = await NetworkAssetBundle(Uri.parse(url)).load("");
        bytes = imageData.buffer.asUint8List();

        setState(() {
          isLoading = false;
        });
      }
    } catch (ex) {}
  }

  void changeProfilePic() {
    // print("camera clicked");
    _showPicker(context);
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
          _address.text = "${placeDetails.street}, "+"${placeDetails.city}, "+"${placeDetails.state}, "
              +"${placeDetails.country}";
        }else{
          _address.text = "${placeDetails.streetNumber}, "+"${placeDetails.street}, "+"${placeDetails.city}, "
              +"${placeDetails.state}, "+"${placeDetails.country}";
        }

      });
    }
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
    imageFile = File(pickedFile.path);

    print(imageFile.path);
    String fileName = (imageFile.path.split('/').last);
    fileExt = "." + (imageFile.path.split('.').last);
    String filePath = imageFile.path.replaceAll("/$fileName", '');

    print("fileName " + fileName);
    print("fileExt " + fileExt);

    setState(() {
      imageFile = imageFile;
      uploadFlag = true;
    });
  }

  _imgFromGallery() async {
    PickedFile pickedFile =
    await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);

    print(imageFile.path);
    String fileName = (imageFile.path.split('/').last);
    fileExt = "." + (imageFile.path.split('.').last);
    String filePath = imageFile.path.replaceAll("/$fileName", '');

    print("fileName " + fileName);
    print("fileExt " + fileExt);

    setState(() {
      imageFile = imageFile;
      uploadFlag = true;
    });
  }

  Future<void> getPreSignedUrl(String fileExt) async {
    String imageName =
        "image_" + DateTime.now().millisecondsSinceEpoch.toString() + fileExt;

    // dialog = new ProgressDialog(context);
    // dialog.style(message: 'Please wait...');
    // await dialog.show();

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
        ConstantMsg.DOC_CATEGORY: "PROFILE_IMAGE",
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
        updateUserDetails();
      } else {}
    } catch (e) {
      print("Error+++++" + e.toString());
    }
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
        _dob.text = convertedDateTime;
      });
    }
  }

  void updateUserDetails() async {
    try {
      var url = Uri.parse(ApiConstants.UPDATE_USER_DETAILS);
      Map<String, String> headers = {
        ConstantMsg.HEADER_CONTENT_TYPE: ConstantMsg.HEADER_VALUE,
        ConstantMsg.HEADER_AUTH:
        "bearer " + preferences.getString(ConstantMsg.ACCESS_TOKEN),
      };

      Map map;
      if (uploadFlag == true) {
        map = {
          ConstantMsg.ID: preferences.getString(ConstantMsg.ID),
          ConstantMsg.NAME: _name.text,
          ConstantMsg.MOBILE_NUM: _phone.text,
          ConstantMsg.DOB: _dob.text,
          ConstantMsg.EDUCATION: _education.text,
          ConstantMsg.ADDRESS: _address.text,
          ConstantMsg.IMAGE_PATH: urlList[0].keyPath,
          ConstantMsg.IMG_PRE_SIGNED_URL: urlList[0].presignedURL,
        };
      } else {
        map = {
          ConstantMsg.ID: preferences.getString(ConstantMsg.ID),
          ConstantMsg.NAME: _name.text,
          ConstantMsg.MOBILE_NUM: _phone.text,
          ConstantMsg.DOB: _dob.text,
          ConstantMsg.EDUCATION: _education.text,
          ConstantMsg.ADDRESS: _address.text,
        };
      }

      // make POST request
      Response response =
      await post(url, headers: headers, body: json.encode(map));
      // check the status code for the result
      String body = response.body;
      print(body);

      var data = json.decode(body);
      if (response.statusCode == 200) {
        showToast(ValidationMsgs.PROFILE_UPDATE_SUCCESS);
        preferences.setString(ConstantMsg.NAME, data['name'].toString());
      }
      await dialog.hide();
    } catch (ex) {
      // await dialog.hide();
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: ColorValues.BLACK,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> validateData() async {
    if (_name.text.isEmpty) {
      showToast("Please enter name");
      return;
    }
    FocusScope.of(context).unfocus();
    dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();

    if (uploadFlag == true) {
      getPreSignedUrl(fileExt);
    } else {
      updateUserDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorValues.THEME_TEXT_COLOR),
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
        title: Text("Profile",style: TextStyle(fontFamily: "Regular",fontSize: 18,
            color: Color(ColorValues.WHITE)),),
      ),
      body: SingleChildScrollView(
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
                color: const Color(ColorValues.WHITE),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0))),
          ),
          imageFile != null
              ? Positioned(
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.file(
                  imageFile,
                  width: 85,
                  height: 85,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          )
              : bytes != null
              ? Positioned(
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.memory(
                  bytes,
                  height: 85,
                  width: 85,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
              : Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/images/profile_pic.png'),
            ),
          ),

          Positioned(
              top: 60,
              left: 60,
              right: 0,
              child: InkWell(
                  onTap: () {
                    changeProfilePic();
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/images/Camera.png'),
                  ))),

          Positioned(
            top: 70,
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: isLoading
                ? new Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        ColorValues.TEXT_COLOR)))
                : Container(
                margin: EdgeInsets.fromLTRB(40, 50, 40, 50),
                decoration: BoxDecoration(
                  color: Color(ColorValues.WHITE),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 7.0, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _name,
                          onEditingComplete: () {
                            _flag = true;
                          },
                          autofocus: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Regular",
                            color: Color(ColorValues.BLACK_TEXT_COL),
                          ),
                          decoration: new InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w700,
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            icon: ImageIcon(
                              AssetImage("assets/images/user_name.png"),
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 12,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w400,
                              color: Color(ColorValues.BLACK_TEXT_COL),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _phone,
                          onEditingComplete: () {
                            _flag = true;
                          },
                          autofocus: false,
                          readOnly: true,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Regular",
                            color: Color(ColorValues.BLACK_TEXT_COL),
                          ),
                          decoration: new InputDecoration(
                            labelText: 'Phone',
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w700,
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            icon: ImageIcon(
                              AssetImage("assets/images/contact.png"),
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 10,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w400,
                              color: Color(ColorValues.BLACK_TEXT_COL),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            autofocus: false,
                            readOnly: true,
                            onTap: () {
                              selectDate(context);
                            },
                            controller: _dob,
                            onEditingComplete: () {
                              _flag = true;
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Regular",
                              color: Color(ColorValues.BLACK_TEXT_COL),
                            ),
                            decoration: new InputDecoration(
                              labelText: 'Date of Birth',
                              labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Regular",
                                fontWeight: FontWeight.w700,
                                color: Color(ColorValues.THEME_TEXT_COLOR),
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              icon: ImageIcon(
                                AssetImage("assets/images/calendar.png"),
                                color: Color(ColorValues.THEME_TEXT_COLOR),
                              ),
                              suffixIconConstraints: BoxConstraints(
                                  minHeight: 22, minWidth: 22),
                              suffixIcon: IconButton(
                                icon: ImageIcon(
                                  AssetImage(
                                      "assets/images/cal_sign_up.png"),
                                  color:
                                  Color(ColorValues.THEME_TEXT_COLOR),
                                ),
                              ),
                              hintStyle: TextStyle(
                                fontSize: 10,
                                fontFamily: "Regular",
                                fontWeight: FontWeight.w400,
                                color: Color(ColorValues.BLACK_TEXT_COL),
                              ),
                            ),
                          )),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _education,
                          onEditingComplete: () {
                            _flag = true;
                          },
                          autofocus: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Regular",
                            color: Color(ColorValues.BLACK_TEXT_COL),
                          ),
                          decoration: new InputDecoration(
                            labelText: 'Education',
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w700,
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            icon: ImageIcon(
                              AssetImage("assets/images/eduction.png"),
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 10,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w400,
                              color: Color(ColorValues.BLACK_TEXT_COL),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _address,
                          onTap: () {
                            callPlacesApi();
                          },
                          onEditingComplete: () {
                            _flag = true;
                          },
                          autofocus: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Regular",
                            color: Color(ColorValues.BLACK_TEXT_COL),
                          ),
                          decoration: new InputDecoration(
                            labelText: 'Address',
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w700,
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            icon: ImageIcon(
                              AssetImage("assets/images/location.png"),
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 10,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w400,
                              color: Color(ColorValues.BLACK_TEXT_COL),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 30, horizontal: 40),
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(ColorValues.THEME_TEXT_COLOR),
                        ),
                        child: TextButton(
                          onPressed: () {
                            validateData();
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Color(ColorValues.WHITE),
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
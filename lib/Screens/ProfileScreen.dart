import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homelabz/Models/PreSignedUrlResponse.dart';
import 'package:homelabz/Models/UserDetails.dart';
import 'package:homelabz/Screens/address_search.dart';
import 'package:homelabz/Services/place_service.dart';
import 'package:homelabz/components/MyUtils.dart';
import 'package:homelabz/components/ColorValues.dart';
import 'package:homelabz/constants/Constants.dart';
import 'package:homelabz/constants/ValidationMsgs.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);
  // static File imageFile;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _name;
  DateTime selectedDate=DateTime.now();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _dob = new TextEditingController();

  //TextEditingController _education = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  String gender;
  bool _flag = false;
  var isLoading = true;
  DateTime tempDate = DateTime.now();
  String convertedDateTime;
  File imageFile;
  PreSignedUrlResponse responseModel;
  List<DocumentPresignedURLModelList> urlList;
  String fileExt;
  bool uploadFlag = false;
  SharedPreferences preferences;
  Uint8List bytes;
  ProgressDialog dialog;
  String imageUrl;
  String oldImagePath;
  List<PlatformFile> listOfImages;
  bool _loadingPath = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(_dob.text);
    //print(convertedDateTime);
    _address.text = "";
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

      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.GET_USER_DETAILS + preferences.getString(Constants.ID).toString());
      print(url);
      print(preferences.getString(Constants.ACCESS_TOKEN));
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
        UserDetails model = UserDetails.fromJson(json.decode(body));
        _name = new TextEditingController(text: model.name);
        _phone = new TextEditingController(text: model.mobileNumber);
        if(model.dob!=null)
        _dob = new TextEditingController(text: model.dob);
        //_education = new TextEditingController(text: model.education);
        if(model.address!=null)
        _address = new TextEditingController(text: model.address);
        if(model.email!=null)
        _email = new TextEditingController(text: model.email);
        if(model.gender!=null)
        gender = model.gender.toUpperCase();

        if(model.dob!=null && model.dob.length>0){
          selectedDate = new DateFormat("yyyy-MM-dd").parse(model.dob);
        }

        preferences.setString("name", model.name);
        if(model.dob!=null)
        preferences.setString("dob", model.dob);
        if(model.address!=null)
        preferences.setString("address", model.address);
        if(model.gender!=null)
        preferences.setString("gender", gender);

        if (model.imagePresignedURL != null && model.imagePresignedURL.length > 0) {
          oldImagePath = model.imagePath;
          imageUrl = model.imagePresignedURL;
          preferences.setString("image", imageUrl);
        }
        isLoading = false;

        setState(() {
        });
      }else{
        var data = json.decode(body);
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
    } catch (ex) {
      setState(() {
        isLoading = true;
      });
    }
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
                        // _openFileExplorer();
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

  // void _openFileExplorer() async {
  //   setState(() => _loadingPath = true);
  //   try {
  //     listOfImages = (await FilePicker.platform.pickFiles(
  //         allowMultiple: false,
  //         type: FileType.custom,
  //         allowedExtensions: ['jpg', 'png', 'jpeg']))
  //         ?.files;
  //   } on PlatformException catch (e) {
  //     print("Unsupported operation" + e.toString());
  //   } catch (ex) {
  //     print(ex);
  //   }
  //   if (!mounted) return;
  //     for (var obj in listOfImages) {
  //       // Size check > 5 MB (5000000)
  //       print("size ======= ${obj.size}");
  //       if(obj.size<5000000) {
  //         // File file = File(obj.path);
  //         // // setData(file);
  //         setState(() {
  //           _loadingPath = false;
  //         imageFile = imageFile;
  //         uploadFlag = true;
  //         });
  //       }else{
  //         MyUtils.showCustomToast("File is too big to upload. try with other file", true, context);
  //       }
  //     }
  //
  // }

  Future<void> getPreSignedUrl(String fileExt) async {
    String imageName =
        "image_" + DateTime.now().millisecondsSinceEpoch.toString() + fileExt;

    // dialog = new ProgressDialog(context);
    // dialog.style(message: 'Please wait...');
    // await dialog.show();

    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.PRE_SIGNED_URL);
      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH:
        "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };

      List list = [];
      Map list1 = {
        Constants.KEY_NAME: imageName,
      };
      list.add(list1);

      Map mapBody = {
        Constants.USER_ID: preferences.getString(Constants.ID),
        Constants.DOC_CATEGORY: "PROFILE_IMAGE",
        Constants.PRE_SIGNED_LIST: list
      };
      print(mapBody);
      // make POST request
      var response =
      await _ioClient.post(url, headers: headers, body: json.encode(mapBody));

      String body = response.body;
      print(body);

      if (response.statusCode == 200) {
        urlList = [];
        responseModel = PreSignedUrlResponse.fromJson(json.decode(body));
        urlList.addAll(responseModel.documentPresignedURLModelList);
        print(urlList[0].presignedURL);
        preferences.setString("image", urlList[0].presignedURL);
        uploadImage();
      } else {
        var data = json.decode(body);
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
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
        convertedDateTime =
        "${pickedDate.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
        _dob.text = convertedDateTime;
        selectedDate=pickedDate;
      });
    }
  }

  void updateUserDetails() async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();

    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.UPDATE_USER_DETAILS);
      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH:
        "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };

      Map map;
      if (uploadFlag == true) {
        map = {
          Constants.ID: preferences.getString(Constants.ID),
          Constants.NAME: _name.text,
          Constants.MOBILE_NUM: _phone.text,
          Constants.DOB: _dob.text,
          Constants.EMAIL: _email.text,
          Constants.GENDER:gender,
          Constants.ADDRESS: _address.text,
          Constants.IMAGE_PATH: urlList[0].keyPath,
          Constants.IMG_PRE_SIGNED_URL: urlList[0].presignedURL,
        };
      } else {
        map = {
          Constants.ID: preferences.getString(Constants.ID),
          Constants.NAME: _name.text,
          Constants.MOBILE_NUM: _phone.text,
          Constants.DOB: _dob.text,
          Constants.EMAIL: _email.text,
          Constants.GENDER:gender,
          Constants.ADDRESS: _address.text,
          Constants.IMAGE_PATH:oldImagePath,
        };
      }

      // make POST request
      var response = await _ioClient.post(url, headers: headers, body: json.encode(map));
      // check the status code for the result
      String body = response.body;
      print(body);

      var data = json.decode(body);
      if (response.statusCode == 200) {
        showToast(ValidationMsgs.PROFILE_UPDATE_SUCCESS);
        preferences.setString(Constants.NAME, data['name'].toString());

        String dob = data['dob'].toString();
        if (dob != null && dob.length > 0) preferences.setString("dob", dob);

        String address = data['address'].toString();
        if (address != null && address.length > 0)
          preferences.setString("address", address);

        if(uploadFlag==true){
          String imageUrl = data['imagePresignedURL'].toString();
          preferences.setString("image", imageUrl);
          uploadFlag = false;
        }
      }else{
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
      await dialog.hide();
    } catch (ex) {
      await dialog.hide();
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
      // showToast("Please enter name");
      MyUtils.showCustomToast(ValidationMsgs.NAME_VALIDATION, true, context);
      return;
    }
    if (_email.text.isEmpty) {
      // showToast("Please enter name");
      MyUtils.showCustomToast(ValidationMsgs.EMAIL_VALIDATION, true, context);
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
        backgroundColor: Color(ColorValues.WHITE),
        leading: IconButton(
          // iconSize: 20,
          icon: ImageIcon(
            AssetImage('assets/images/back_arrow.png'),
            color: Color(ColorValues.THEME_COLOR),
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Profile",style: TextStyle(fontFamily: "Regular",fontSize: 18,
            color: Color(ColorValues.THEME_COLOR)),),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Stack(clipBehavior: Clip.none, children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.9,
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
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
                  : imageUrl != null
                  ? Positioned(
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.network(
                      imageUrl,
                      height: 85,
                      width: 85,
                      fit: BoxFit.cover,
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
                  right: 150,
                  child: InkWell(
                    child: Container(
                          height: 40,
                          //width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: GestureDetector(
                            onTap: () {
                                  changeProfilePic();
                            },
                            child: Image.asset('assets/images/Camera.png')),
                        ),
                  )
              ),

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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _name,
                                onSubmitted: (String val){
                                  FocusScope.of(context).unfocus();
                                },
                                onEditingComplete: () {
                                  _flag = true;
                                },
                                autofocus: false,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Regular",
                                  color: Color(ColorValues.BLACK_TEXT_COL),
                                ),
                                decoration: new InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(ColorValues.GRAY)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(ColorValues.THEME_TEXT_COLOR)),
                                  ),
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    height: 0.5,
                                    fontSize: 14,
                                    fontFamily: "Regular",
                                    fontWeight: FontWeight.w700,
                                    color: Color(ColorValues.THEME_TEXT_COLOR).withOpacity(0.5),
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
                                onSubmitted: (String val){
                                  FocusScope.of(context).unfocus();
                                },
                                onEditingComplete: () {
                                  _flag = true;
                                },
                                enabled: false,
                                autofocus: false,
                                readOnly: true,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Regular",
                                  color: Color(ColorValues.BLACK_TEXT_COL),
                                ),
                                decoration: new InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(ColorValues.GRAY)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(ColorValues.THEME_TEXT_COLOR)),
                                  ),
                                  labelText: 'Phone',
                                  labelStyle: TextStyle(
                                    height: 0.5,
                                    fontSize: 14,
                                    fontFamily: "Regular",
                                    fontWeight: FontWeight.w700,
                                    color: Color(ColorValues.THEME_TEXT_COLOR).withOpacity(0.5),
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
                                  onSubmitted: (String val){
                                    FocusScope.of(context).unfocus();
                                  },
                                  onEditingComplete: () {
                                    _flag = true;
                                  },
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Regular",
                                    color: Color(ColorValues.BLACK_TEXT_COL),
                                  ),
                                  decoration: new InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(ColorValues.GRAY)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(ColorValues.THEME_TEXT_COLOR)),
                                    ),
                                    labelText: 'Date of Birth',
                                    labelStyle: TextStyle(
                                      height: 0.5,
                                      fontSize: 14,
                                      fontFamily: "Regular",
                                      fontWeight: FontWeight.w700,
                                      color: Color(ColorValues.THEME_TEXT_COLOR).withOpacity(0.5),
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
                                controller: _email,
                                onSubmitted: (String val){
                                  FocusScope.of(context).unfocus();
                                },
                                onEditingComplete: () {
                                  _flag = true;
                                },
                                autofocus: false,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Regular",
                                  color: Color(ColorValues.BLACK_TEXT_COL),
                                ),
                                decoration: new InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(ColorValues.GRAY)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(ColorValues.THEME_TEXT_COLOR)),
                                  ),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    height: 0.5,
                                    fontSize: 14,
                                    fontFamily: "Regular",
                                    fontWeight: FontWeight.w700,
                                    color: Color(ColorValues.THEME_TEXT_COLOR).withOpacity(0.5),
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
                                onSubmitted: (String val){
                                  FocusScope.of(context).unfocus();
                                },
                                onTap: () {
                                  callPlacesApi();
                                },
                                onEditingComplete: () {
                                  _flag = true;
                                },
                                autofocus: false,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Regular",
                                  color: Color(ColorValues.BLACK_TEXT_COL),
                                ),
                                decoration: new InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(ColorValues.GRAY)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(ColorValues.THEME_TEXT_COLOR)),
                                  ),
                                  labelText: 'Address',
                                  labelStyle: TextStyle(
                                    height: 0.5,
                                    fontSize: 14,
                                    fontFamily: "Regular",
                                    fontWeight: FontWeight.w700,
                                    color: Color(ColorValues.THEME_TEXT_COLOR).withOpacity(0.5),
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
                              margin: EdgeInsets.only(top: 14, left: 20, right: 20),
                              child: Text(
                                "Gender",
                                style: TextStyle(
                                    fontFamily: "Black",
                                    fontSize: 12,
                                    color: Color(ColorValues.THEME_TEXT_COLOR).withOpacity(0.5)),
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
                                                      ColorValues.BLACK_COLOR).withOpacity(0.5),
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
                                                      ColorValues.BLACK_COLOR).withOpacity(0.5),
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
                              margin: EdgeInsets.only(left: 40,right: 40,top:30, bottom: 20),
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color(ColorValues.THEME_TEXT_COLOR),
                                borderRadius: BorderRadius.circular(20),
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
                      ),
                    )),
              ),
            ]),

        ),
      ),
    );
  }
}

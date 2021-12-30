import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:homelabz/Models/PreSignedUrlResponse.dart';
import 'package:homelabz/Models/VaultFoldersModel.dart';
import 'package:homelabz/Screens/BottomNavBar.dart';
import 'package:homelabz/components/MyUtils.dart';
import 'package:homelabz/constants/Constants.dart';
import 'package:homelabz/constants/ValidationMsgs.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/components/ColorValues.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CategoryData {
  String categoryName;

  CategoryData(this.categoryName);
}

class UploadData {
  File imageFile;
  String fileExt, imageName;

  UploadData(this.imageFile, this.fileExt, this.imageName);
}

class UploadDocVault extends StatefulWidget {
  final String type;

  const UploadDocVault({this.type});

  @override
  _UploadDocVaultState createState() => _UploadDocVaultState();
}

class _UploadDocVaultState extends State<UploadDocVault> {
  List<CategoryData> categoryList = [
    new CategoryData("Labs"),
    new CategoryData("Medications"),
    new CategoryData("Miscellaneous")
  ];
  int index = -1;

  SharedPreferences preferences;
  bool _loadingPath = false;
  bool _multiPick = true;
  String _fileName;
  File imageToDisplay;
  List<PlatformFile> listOfImages;
  List<UploadData> imageList = [];
  List<VaultFoldersModel> folderList;

  // List<FolderDetailsResponse> vaultFolderDetailsList;
  ProgressDialog dialog;
  PreSignedUrlResponse responseModel;
  List<DocumentPresignedURLModelList> urlList;
  int uploadCount = 0;
  bool isCreate;

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return SafeArea(
              child: Container(
                color: Color(ColorValues.WHITE),
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text('Photo Library'),
                        onTap: () {
                          // _imgFromGallery();//
                          _openFileExplorer();
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
        });
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      listOfImages = (await FilePicker.platform.pickFiles(
              allowMultiple: _multiPick,
              type: FileType.custom,
              allowedExtensions: ['jpg', 'pdf', 'doc', 'docx', 'png', 'jpeg']))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      for (var obj in listOfImages) {
        // Size check < 5 MB
        print("size ======= ${obj.size}");
        File file = File(obj.path);
        setData(file);
      }
    });
  }

  _imgFromCamera() async {
    PickedFile pickedFile =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    File imageFile = File(pickedFile.path);
    imageToDisplay = imageFile;
    setData(imageFile);
  }

  void setData(File imageFile) {
    String fileName = (imageFile.path.split('/').last);
    String fileExt = "." + (imageFile.path.split('.').last);
    String filePath = imageFile.path.replaceAll("/$fileName", '');
    String imageName = fileName +
        "_" +
        DateTime.now().millisecondsSinceEpoch.toString() +
        fileExt;

    UploadData model = new UploadData(imageFile, fileExt, imageName);
    imageList.add(model);
    setState(() {});
//return model;
  }

  Future<void> getPreSignedUrl() async {
    dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();

    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.PRE_SIGNED_URL);
      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH:
            "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };

      List list = [];
      for (int i = 0; i < imageList.length; i++) {
        Map list1 = {
          Constants.KEY_NAME: imageList[i].imageName,
        };
        list.add(list1);
      }
      Map mapBody = {
        Constants.USER_ID: preferences.getString(Constants.ID),
        Constants.DOC_CATEGORY: "VAULT",
        Constants.PRE_SIGNED_LIST: list
      };
      print(mapBody);
      // make POST request
      var response = await _ioClient.post(url,
          headers: headers, body: json.encode(mapBody));

      String body = response.body;
      print(body);

      if (response.statusCode == 200) {
        urlList = [];
        responseModel = PreSignedUrlResponse.fromJson(json.decode(body));
        urlList.addAll(responseModel.documentPresignedURLModelList);
        for (int i = 0; i < urlList.length; i++) {
          uploadImage(urlList[i].presignedURL, imageList[i].imageFile);
        }
      } else {
        var data = json.decode(body);
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
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
          // call api here
          uploadCount = 0;
          getListOfFolders();
        }
      } else {}
    } catch (e) {
      print("Error+++++" + e.toString());
    }
  }

  Future<void> getListOfFolders() async {
    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.GET_ALL_FOLDERS +
          preferences.getString(Constants.ID).toString());
      // var url = Uri.parse(ApiConstants.GET_ALL_FOLDERS + "713");
      // var url = Uri.parse("http://43.231.127.173:3000/homelabz/api/v1/vault/findAll?userId=713");
      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH:
            "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };

      // make GET request
      var response = await _ioClient.get(url, headers: headers);
      // check the status code for the result
      String body = response.body;
      print(body);

      if (response.statusCode == 200) {
        folderList = [];

        var data = json.decode(body);
        List list = data;
        VaultFoldersModel model;
        if (list.length > 0) {
          for (var obj in list) {
            model = VaultFoldersModel.fromJson(obj);
            folderList.add(model);
            if (categoryList[index].categoryName.compareTo(model.name) == 0) {
              print(categoryList[index].categoryName +
                  " --- " +
                  model.name +
                  "======= Match");
              //call update api here
              isCreate = false;
              break;
            } else {
              print(categoryList[index].categoryName +
                  " --- " +
                  model.name +
                  "======= No Match");
              //call create api here
              isCreate = true;
            }
          }
        } else {
          isCreate = true;
        }

        if (isCreate) {
          callVaultApi(true, null);
        } else {
          callVaultApi(false, model);
        }
      } else {
        var data = json.decode(body);
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
    } catch (ex) {
      print("ERROR+++++++++++++  ${ex}");
    }
  }

  void callVaultApi(bool isCreate, VaultFoldersModel model) async {
    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url;
      if (isCreate) {
        url = Uri.parse(ApiConstants.CREATE_VAULT_FOLDER);
      } else {
        url = Uri.parse(ApiConstants.UPDATE_VAULT_FOLDERS);
      }

      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH:
            "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };
      print(preferences.getString(Constants.ACCESS_TOKEN));

      List docList;
      if (urlList != null && urlList.length > 0) {
        Map userMap = {Constants.ID: preferences.getString(Constants.ID)};
        docList = [];
        for (int i = 0; i < urlList.length; i++) {
          Map list1 = {
            "category": "VAULT",
            "name": urlList[i].keyName,
            "path": urlList[i].keyPath,
            "user": userMap
          };
          docList.add(list1);
        }
      }

      int noOfFiles;
      String folderName;
      if (isCreate) {
        noOfFiles = urlList.length;
        folderName = categoryList[index].categoryName;
      } else {
        noOfFiles = model.noOfFiles + urlList.length;
        folderName = model.name;
      }

      Map mapBody = {
        Constants.DOC_LIST: docList,
        if (isCreate) Constants.ID: "" else Constants.ID: model.id,
        Constants.NAME: folderName,
        Constants.NUMBER_OF_FILES: noOfFiles,
        Constants.USER_ID: preferences.getString(Constants.ID),
      };

      print(mapBody);
      // make POST request
      var response = await _ioClient.post(url,
          headers: headers, body: json.encode(mapBody));

      String body = response.body;
      var data = json.decode(body);
      print(body);

      if (response.statusCode == 200) {
        MyUtils.showCustomToast(
            ValidationMsgs.VAULT_DOC_SUCCESS, false, context);
        Navigator.pop(context);
      } else {
        var data = json.decode(body);
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
      if (dialog != null) await dialog.hide();
    } catch (e) {
      await dialog.hide();
      print("Error+++++" + e.toString());
    }
  }

  void showImage(context, pos) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent.withOpacity(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0)),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.file(
                      imageList[pos].imageFile,
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  showAlertDialog(BuildContext context, int pos) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(
          color: Color(ColorValues.THEME_TEXT_COLOR),
        ),
      ),
      onPressed: () {
        removeImage(pos);
        Navigator.of(context).pop();
      },
    );

    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(
          color: Color(ColorValues.THEME_TEXT_COLOR),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Remove Document"),
      content: Text("Do you want to remove this document?"),
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

  void removeImage(int pos) async {
    setState(() {
      imageList.removeAt(pos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, "check");
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(ColorValues.WHITE_COLOR),
            leading: IconButton(
              icon: ImageIcon(
                AssetImage('assets/images/back_arrow.png'),
                color: Color(ColorValues.THEME_COLOR),
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Upload Doc",
              style: TextStyle(
                  fontFamily: "Regular",
                  fontSize: 18,
                  color: Color(ColorValues.THEME_COLOR)),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
             //   crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 30.0, bottom: 10),
                        child: Text(
                          "Select Category",
                          style: TextStyle(
                              fontFamily: "Regular",
                              fontSize: 16,
                              color: Color(ColorValues.BLACK_TEXT_COL)),
                        )),
                  ),
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0,
                        childAspectRatio: 7.7,
                      ),
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      itemCount: categoryList.length,
                      itemBuilder: (BuildContext ctx, pos) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                print(pos);
                                index = pos;
                                // CELL_COLOR= const Color(0xff21C8BE);
                              });
                            },
                            child: SingleChildScrollView(
                                // child: index != pos ?
                                child: Container(
                              margin: EdgeInsets.only(left: 40, right: 40),
                              height: 40,
                              decoration: index != pos
                                  ? BoxDecoration(
                                      border: Border.all(
                                          color: Color(ColorValues.BLACK_COL)),
                                      borderRadius: BorderRadius.circular(5),
                                    )
                                  : BoxDecoration(
                                      border: Border.all(
                                          color: Color(
                                              ColorValues.THEME_TEXT_COLOR)),
                                      // color: const Color(ColorValues.THEME_TEXT_COLOR),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/check.png"),
                                        height: 20,
                                        width: 20,
                                        color: index != pos
                                            ? Color(ColorValues.WHITE)
                                            : Color(
                                                ColorValues.THEME_TEXT_COLOR),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        categoryList[pos].categoryName,
                                        style: TextStyle(
                                          fontFamily: "Regular",
                                          fontSize: 16,
                                          color: index != pos
                                              ? Color(ColorValues.BLACK_COL)
                                              : Color(
                                                  ColorValues.THEME_TEXT_COLOR),
                                        ),
                                      ),
                                    ),
                                  ]),
                            )));
                      }),
                  imageList != null && imageList.length > 0
                      ? Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 8, top: 50),
                                child: Row(
                                  children: [
                                    Text(
                                      imageList.length > 1
                                          ? "${imageList.length} Files | "
                                          : "${imageList.length} File | ",
                                      style: TextStyle(
                                          fontFamily: "Regular",
                                          fontSize: 16,
                                          color: Color(ColorValues.BLACK_COL)),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        _showPicker(context);
                                      },
                                      child: Text(
                                        "Add More",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontFamily: "Regular",
                                            fontSize: 16,
                                            color: Color(
                                                ColorValues.THEME_TEXT_COLOR)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0,
                                      childAspectRatio: (MediaQuery.of(context)
                                              .size
                                              .width) /
                                          (MediaQuery.of(context).size.height /
                                              1.3),
                                    ),
                                    shrinkWrap: true,
                                    primary: false,
                                    scrollDirection: Axis.vertical,
                                    itemCount: imageList.length,
                                    itemBuilder: (BuildContext ctx, pos) {
                                      return Stack(
                                        children: [
                                          Container(
                                            // margin: EdgeInsets.only(top: 10),
                                            child: GestureDetector(
                                                onTap: () async {
                                                  showImage(context, pos);
                                                },
                                                // child: Image.file(
                                                //   imageList[pos].imageFile,
                                                //   width: 85,
                                                //   height: 85,
                                                //   fit: BoxFit.cover,
                                                // ),
                                                child: Container(
                                                  // margin: EdgeInsets.only(top: 15),
                                                  // height: 120,
                                                  // width: 120,
                                                  decoration: BoxDecoration(
                                                      color: Color(ColorValues
                                                          .GRAY_HEADER_PRESSO_VIEW),
                                                      border: Border.all(
                                                          color: Color(
                                                              ColorValues
                                                                  .BLACK_COL)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  // child: GestureDetector(
                                                  //   onTap: () async {},
                                                  //   child: Padding(
                                                  //     padding: EdgeInsets.only(left: 6),
                                                  //     child: Image(
                                                  //       image: AssetImage(
                                                  //           "assets/images/ic_sample.png"),
                                                  //       // alignment: Alignment.centerLeft,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                )),
                                          ),
                                          Positioned(
                                              right: 10,
                                              bottom: 10,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    showAlertDialog(
                                                        context, pos);
                                                  },
                                                  child: Image(
                                                    image: AssetImage(
                                                        "assets/images/delete_btn.png"),
                                                    height: 18,
                                                    width: 18,
                                                    alignment: Alignment.center,
                                                  )))
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Container(
                              margin: EdgeInsets.only(top: 50, bottom: 20.0),
                              child: DottedBorder(
                                color:
                                    Color(ColorValues.GRAY_HEADER_PRESSO_VIEW),
                                strokeWidth: 1.5,
                                child: Container(
                                  margin: EdgeInsets.all(12),
                                  child: GestureDetector(
                                    onTap: () {
                                      _showPicker(context);
                                    },
                                    child: Text(
                                      "Upload Here",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontFamily: "Regular",
                                          fontSize: 16,
                                          color: Color(
                                              ColorValues.THEME_TEXT_COLOR)),
                                    ),
                                  ),
                                ),
                              )),
                        ),


                ],
              ),
            ),
          ),
          bottomNavigationBar:    Container(
          //  alignment: Alignment.bottomRight,
            margin: EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: "Regular",
                              fontSize: 16,
                              color: Color(ColorValues.BLACK_COL)),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 15, top: 20, bottom: 20),
                    height: 40,
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: imageList.length > 0
                        ? BoxDecoration(
                      color: const Color(
                          ColorValues.THEME_TEXT_COLOR),
                      borderRadius: BorderRadius.circular(5),
                    )
                        : BoxDecoration(
                      color: const Color(ColorValues.GRAY),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Validate Data
                        if (index != -1) {
                          if (imageList.length > 0) {
                            //PreSigned
                            getPreSignedUrl();
                          } else {
                            MyUtils.showCustomToast(
                                "Please attach document",
                                true,
                                context);
                          }
                        } else {
                          MyUtils.showCustomToast(
                              "Please select any category to upload document",
                              true,
                              context);
                        }
                      },
                      child: Text(
                        'Upload',
                        style: TextStyle(
                            color: Color(ColorValues.WHITE),
                            fontSize: 16),
                      ),
                    ),
                  ),
                ]),
          ),

        ));
  }
}

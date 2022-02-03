import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homelabz/Models/FolderDetailsResponse.dart';
import 'package:homelabz/Models/PreSignedUrlResponse.dart';
import 'package:homelabz/Models/VaultFoldersModel.dart';
import 'package:homelabz/Screens/BottomNavBar.dart';
import 'package:homelabz/Screens/UploadDocVault.dart';
import 'package:homelabz/Screens/ViewDocVault.dart';
import 'package:homelabz/components/MyUtils.dart';
import 'package:homelabz/components/ColorValues.dart';
import 'package:homelabz/constants/Constants.dart';
import 'package:homelabz/constants/Values.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadData {
  File imageFile;
  String fileExt, imageName;

  UploadData(this.imageFile, this.fileExt, this.imageName);
}

class CategoryData {
  String categoryName;

  CategoryData(this.categoryName);
}

class Vault extends StatefulWidget {
  const Vault({Key key}) : super(key: key);

  @override
  _VaultState createState() => _VaultState();
}

class _VaultState extends State<Vault> {
  TextEditingController _search = new TextEditingController();
  List<VaultFoldersModel> folderList;
  SharedPreferences preferences;
  File imageToDisplay;
  List<PlatformFile> listOfImages;
  List<UploadData> imageList = [];
  List<CategoryData> categoryList = [
    new CategoryData("Labs"),
    new CategoryData("Medications"),
    new CategoryData("Miscellaneous")
  ];
  int index = -1;
  List<FolderDetailsResponse> vaultFolderDetailsList;
  ProgressDialog dialog;
  PreSignedUrlResponse responseModel;
  List<DocumentPresignedURLModelList> urlList;
  int uploadCount = 0;

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    getListOfFolders();
  }

  Future<void> getListOfFolders() async {
    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.GET_ALL_FOLDERS +
          preferences.getString(Constants.ID).toString());
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

        setState(() {
          for (var obj in list) {
            VaultFoldersModel model = VaultFoldersModel.fromJson(obj);
            folderList.add(model);
          }
        });
      } else {
        var data = json.decode(body);
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
    } catch (ex) {
      print("ERROR+++++++++++++  ${ex}");
    }
  }

  void _navigateAndUpdate(
      BuildContext context, bool isUpload, int id, String name) async {
    if (isUpload) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UploadDocVault(type: "check")),
      );
    } else {
      final result = await Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => ViewDocVault(
                    vaultId: id,
                    type: "check",
                    vaultName: name,
                  )));
    }
    getListOfFolders();
  }

  showConfirmationDialog(BuildContext context, int id) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(
          color: Color(ColorValues.THEME_TEXT_COLOR),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        deleteVaultFolder(id);
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
      title: Text("Delete Vault"),
      content: Text("Do you really want to delete this Vault Folder?"),
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

  Future<void> deleteVaultFolder(int id) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();

    try {
      setState(() {});
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.DELETE_VAULT_FOLDER);
      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH:
            "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };
      Map map = {
        Constants.ID: id,
      };
      // make POST request
      var response =
          await _ioClient.post(url, headers: headers, body: json.encode(map));
      // check the status code for the result
      String body = response.body;
      print(body);

      if (response.statusCode == 200) {
        getListOfFolders();
      } else {
        var data = json.decode(body);
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
      await dialog.hide();
    } catch (ex) {
      await dialog.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Vault",
          style: TextStyle(
              fontFamily: "Regular",
              fontSize: 18,
              color: Color(ColorValues.THEME_COLOR)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Hide DP
              // Container(
              //   margin: EdgeInsets.only(top: 25),
              //   width: 60,
              //   height: 60,
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //   ),
              //   child: Image.asset('assets/images/profile_pic.png'),
              // ),

              Container(
                margin: EdgeInsets.fromLTRB(10, 40, 10, 20),
                child: DottedBorder(
                  color: Color(ColorValues.GRAY_HEADER_PRESSO_VIEW),
                  strokeWidth: 1.5,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          "Save Your Documents",
                          style: TextStyle(
                            fontSize: Values.HEADING_SIZE,
                            fontFamily: "Regular",
                            fontWeight: FontWeight.bold,
                            color: Color(ColorValues.BLACK_TEXT_COL),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Text(
                          "Keep your documents at one Place",
                          style: TextStyle(
                            fontSize: Values.VALUE_SIZE,
                            fontFamily: "Regular",
                            color: Color(ColorValues.BLACK_TEXT_COL),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 40, right: 40, top: 30, bottom: 20),
                        height: 40,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          color: const Color(ColorValues.THEME_TEXT_COLOR),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Call upload screen here
                            _navigateAndUpdate(context, true, 0, "");
                          },
                          child: Text(
                            'Upload',
                            style: TextStyle(
                                color: Color(ColorValues.WHITE), fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //hide search
              // Container(
              //   padding: EdgeInsets.all(12.0),
              //   margin: EdgeInsets.fromLTRB(10, 10, 15, 20),
              //   height: 40,
              //   // width: MediaQuery.of(context).size.width * 0.7,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: BoxDecoration(
              //       color: Color(ColorValues.WHITE),
              //       border: Border.all(color: Color(ColorValues.BLACK_COL)),
              //       borderRadius: BorderRadius.circular(5)),
              //   child: TextField(
              //     controller: _search,
              //     onSubmitted: (String val) {
              //       FocusScope.of(context).unfocus();
              //     },
              //     onChanged: (String val) {
              //       if (val != " " && val.length > 0) {}
              //     },
              //     autofocus: false,
              //     cursorColor: Colors.black,
              //     style: TextStyle(
              //       fontSize: 10,
              //       fontFamily: "Regular",
              //       color: Color(ColorValues.BLACK_TEXT_COL),
              //     ),
              //     decoration: new InputDecoration(
              //       border: InputBorder.none,
              //       focusedBorder: InputBorder.none,
              //       enabledBorder: InputBorder.none,
              //       errorBorder: InputBorder.none,
              //       disabledBorder: InputBorder.none,
              //       contentPadding:
              //           EdgeInsets.only(left: 0, bottom: 10, top: 10, right: 10),
              //       icon: ImageIcon(
              //         AssetImage("assets/images/search_icon.png"),
              //         color: Color(ColorValues.THEME_TEXT_COLOR),
              //       ),
              //       hintText: 'Search ',
              //       hintStyle: TextStyle(
              //         fontSize: 10,
              //         fontFamily: "Regular",
              //         fontWeight: FontWeight.w300,
              //         color: Color(ColorValues.BLACK_TEXT_COL),
              //       ),
              //     ),
              //   ),
              // ),

              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: folderList != null && folderList.length > 0
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio:
                              (MediaQuery.of(context).size.width) /
                                  (MediaQuery.of(context).size.height / 1.1),
                        ),
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        itemCount: folderList.length,
                        itemBuilder: (BuildContext ctx, pos) {
                          return Container(
                              child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Call View screen here
                                        _navigateAndUpdate(
                                            context,
                                            false,
                                            folderList[pos].id,
                                            folderList[pos].name);
                                      },
                                      child: Container(
                                        // margin: EdgeInsets.only(top: 15),
                                        height: 180,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: Color(ColorValues.WHITE),
                                            border: Border.all(
                                                color: Color(
                                                    ColorValues.BLACK_COL)),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        // child: GestureDetector(
                                        //   onTap: () async {},
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5, top: 10),
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/vault_folder_logo.png"),
                                              // alignment: Alignment.centerLeft,
                                            ),
                                          ),
                                        // ),
                                      ),
                                    ),

                                    Positioned(
                                        top: 10,
                                        right: 10,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Color(ColorValues.BLACK_COL),
                                            ),
                                            child: Text(
                                              folderList[pos]
                                                  .noOfFiles
                                                  .toString(),
                                              // "5",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: "Regular",
                                                color: Color(ColorValues.WHITE),
                                              ),
                                            ),
                                          ),
                                        )),
///////////////////// Edit and delete //////////////////////////////////////
//                                     Positioned(
//                                         bottom: 15,
//                                         right: 10,
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             showConfirmationDialog(
//                                                 context, folderList[pos].id);
//                                           },
//                                           child: Image(
//                                             image: AssetImage(
//                                                 "assets/images/delete_btn.png"),
//                                             height: 20,
//                                             width: 20,
//                                             alignment: Alignment.topRight,
//                                           ),
//                                         ))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 25),
                                child: Text(
                                  folderList[pos].name,
                                  //"",
                                  style: TextStyle(
                                    fontSize: Values.HEADING_SIZE,
                                    fontFamily: "Regular",
                                    fontWeight: FontWeight.bold,
                                    color: Color(ColorValues.BLACK_TEXT_COL),
                                  ),
                                ),
                              ),
                              // created / updated date
                              // Container(
                              //   margin: EdgeInsets.only(top: 5),
                              //   child: Text(
                              //     folderList[pos].updatedDate != null
                              //         ? MyUtils.changeDateFormat(folderList[pos].updatedDate)
                              //         : MyUtils.changeDateFormat(folderList[pos].createdDate),
                              //     // "Date",
                              //     style: TextStyle(
                              //       fontSize: Values.VALUE_SIZE,
                              //       fontFamily: "Regular",
                              //       color: Color(ColorValues.BLACK_TEXT_COL),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ));
                        })
                    : Container(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(""),
//      bottomNavigationBar: BottomNavigation(),
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:homelabz/Models/FolderDetailsResponse.dart';
import 'package:homelabz/Models/PreSignedUrlResponse.dart';
import 'package:homelabz/Models/VaultFoldersModel.dart';
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

class CategoryData {
  String categoryName;

  CategoryData(this.categoryName);
}

class UploadData {
  File imageFile;
  String fileExt, imageName;

  UploadData(this.imageFile, this.fileExt, this.imageName);
}

class ViewDocVault extends StatefulWidget {
  final int vaultId;
  final String type;
  final String vaultName;

  const ViewDocVault({this.vaultId, this.type, this.vaultName});

  @override
  _ViewDocVaultState createState() => _ViewDocVaultState();
}

class _ViewDocVaultState extends State<ViewDocVault> {
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
  // List<UploadData> imageList = [];
  // List<FolderDetailsResponse> vaultFolderDetailsList;
  ProgressDialog dialog;
  PreSignedUrlResponse responseModel;
  List<DocumentPresignedURLModelList> urlList;
  int uploadCount = 0;
  List<FolderDetailsResponse> vaultFolderDetailsList;
  int localFileCounter=0;
  Dio dio = Dio();
  double progress = 0.0;
  var path;

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    findByVaultID(widget.vaultId);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState /*You can rename this!*/)
              {
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

  Future<void> setData(File imageFile) async {
    String fileName = (imageFile.path.split('/').last);
    String fileExt = "." + (imageFile.path.split('.').last);
    String filePath = imageFile.path.replaceAll("/$fileName", '');
    String imageName = fileName + "_" + DateTime.now().millisecondsSinceEpoch.toString() + fileExt;

    // UploadData model = new UploadData(imageFile, fileExt, imageName);
    // imageList.add(model);

    FolderDetailsResponse obj = new FolderDetailsResponse(id:1,name:imageName,
        path:"",category:"",user:null);
    obj.imageFile = imageFile;
    obj.isLocal = true;

    vaultFolderDetailsList.add(obj);
    localFileCounter+=1;

    setState(() {
    });

  }

  Future<void> getPreSignedUrl() async {
    dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();

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
      List imageList = [];
      for (int i = 0; i < vaultFolderDetailsList.length; i++) {
        if(vaultFolderDetailsList[i].isLocal) {
          imageList.add(vaultFolderDetailsList[i].imageFile);
          Map list1 = {
            Constants.KEY_NAME: vaultFolderDetailsList[i].name,
          };
          list.add(list1);
        }
      }
      Map mapBody = {
        Constants.USER_ID: preferences.getString(Constants.ID),
        Constants.DOC_CATEGORY: "VAULT",
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
        for (int i = 0; i < urlList.length; i++) {
          uploadImage(urlList[i].presignedURL, imageList[i]);
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
      var response = await put(url, body: await imageFile.readAsBytes());
      if (response.statusCode == 200) {
        print("=== Success ===");
        uploadCount++;
        if (uploadCount == urlList.length) {
          // call api here
          uploadCount = 0;
          callUpdateVaultApi();
        }
      } else {}
    } catch (e) {
      print("Error+++++" + e.toString());
    }
  }

  void showPdfImage(pos){
    // PDFViewScreen
    String fileExt = vaultFolderDetailsList[pos].name.split('.').last;
    print(fileExt);
    if(fileExt.compareTo("pdf")==0){
      // // File file  = File('/data/user/0/com.patient.homelabz/cache/file_picker/file-example_PDF_500_kB.pdf_1648123680886.pdf');
      // File file  = File('com.mr.flutter.plugin.filepicker.FileInfo@6f53233');
      // convertFileToDoc(file);
      // if(doc!=null) {
      //   showPDF(doc);
      // }else{
      //   MyUtils.showCustomToast("no PDF avail", false, context);
      // }
      //uncomment for pdf
      // Navigator.push(
      //       //     context,
      //       //     MaterialPageRoute(
      //       //         builder: (context) =>
      //       //             PDFViewScreen(imageList[pos].imageFile,"")));
    }else{
      showImage(context, pos, "");
    }
  }

  void showImage(BuildContext context, int pos, String imageUrl) {
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
                    if(pos==-1)
                      Image.network(
                        imageUrl,
                      )
                      else
                        Image.file(
                          vaultFolderDetailsList[pos].imageFile,
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
        if(vaultFolderDetailsList[pos].isLocal){
          removeImage(pos);
          Navigator.of(context).pop();
        }else{
          Navigator.of(context).pop();
          deleteFileFromServer(pos);
        }
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
    vaultFolderDetailsList.removeAt(pos);
    setState(() {
    });
  }

  Future<void> deleteFileFromServer(int pos) async {
    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.DELETE_FILE);
      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH:
        "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };

      Map map = {
        Constants.ID: vaultFolderDetailsList[pos].id,
        Constants.PATH: vaultFolderDetailsList[pos].path,
      };

      // make POST request
      var response = await _ioClient.post(url, headers: headers, body: json.encode(map));
      // check the status code for the result
      String body = response.body;
      print(body);

      if (response.statusCode == 200) {
        vaultFolderDetailsList.removeAt(pos);
        setState(() {
        });
        MyUtils.showCustomToast(ValidationMsgs.DELETE_FILE_SUCCESS, false, context);
        // Navigator.of(context).pop();

      }else{
        var data = json.decode(body);
        MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }
    } catch (ex) {}
  }

  Future<void> findByVaultID(int id) async {
    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.FIND_BY_VAULT_ID+id.toString());
      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH: "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };
      // make POST request
      var response = await _ioClient.get(url, headers: headers,);
      // check the status code for the result
      String body = response.body;
      print(body);

      if (response.statusCode == 200) {
        vaultFolderDetailsList = [];

        var data = json.decode(body);
        List list = data;
        for (var obj in list) {
          FolderDetailsResponse model = FolderDetailsResponse.fromJson(obj);
          model.isLocal = false;
          vaultFolderDetailsList.add(model);
        }
        setState(() {});
      }else{
        // var data = json.decode(body);
        // MyUtils.showCustomToast(data['mobileMessage'], true, context);
      }

    } catch (ex) {
      print("ERROR+++++++++++++  ${ex}");
    }
  }

  Future<void> downloadImage(String imagePath) async {
    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.GET_DOWNLOAD_URL);
      Map<String, String> headers = {
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH:
        "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };

      Map map = {
        Constants.KEY_PATH: imagePath,
      };

      // make POST request
      var response = await _ioClient.post(url, headers: headers, body: json.encode(map));
      // check the status code for the result
      String body = response.body;
      print(body);

      var data = json.decode(body);
      if (response.statusCode == 200) {
        String keyPath = data["keyPath"];
        String imageUrl = data["presignedURL"];

        String fileExt = keyPath.split('.').last;

        String fileName = (keyPath.split('/').last);
        print(fileName);

        // showImage(context, -1, imageUrl);

        if(fileExt.compareTo("pdf")==0){
          print("file extension ====== "+fileExt);
          // openPDF(imageUrl);
          // showPDF();
          // startDownloading(fileName, imageUrl);

          // var tempDir = await getTemporaryDirectory();
          // String fullPath = tempDir.path + fileName;
          // print('full path ${fullPath}')

          dirPath();
          downloadInFolder(fileName, imageUrl);

        }else {
          showImage(context,-1, imageUrl);
        }
      }
    } catch (ex) {}
  }

  void dirPath() async {
    path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    print(path);
  }

  Future<void> downloadInFolder(String fileName, String imageUrl) async {
    try {
      dialog = new ProgressDialog(context);
      dialog.style(message: 'Please wait...');
      await dialog.show();

      var response = await dio.get(imageUrl,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response.headers);
      File file = File(path+"/"+fileName);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    int counter = 0;
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
    String count = (received / total * 100).toStringAsFixed(0);
    if(counter==0) {
      counter+=1;
      if (count.compareTo("100") == 0) {
        if(dialog!=null){
          dialog.hide();
        }
        MyUtils.showCustomToast(
            "File Downloaded. Please check downloads folder", false, context);
      }
    }
  }

  void callUpdateVaultApi() async {
    try {
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.UPDATE_VAULT_FOLDERS);

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

      Map mapBody = {
        Constants.DOC_LIST: docList,
        Constants.ID: widget.vaultId,
        Constants.NAME: widget.vaultName,
        Constants.NUMBER_OF_FILES: vaultFolderDetailsList.length,
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
          "View Doc",
          style: TextStyle(
              fontFamily: "Regular",
              fontSize: 18,
              color: Color(ColorValues.THEME_COLOR)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            // height: MediaQuery.of(context).size.height * 0.9,
            // width: MediaQuery.of(context).size.width,
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8, top: 20),
                        child: Row(
                          children: [
                            Text(vaultFolderDetailsList!=null?
                            vaultFolderDetailsList.length==1?
                              "${vaultFolderDetailsList.length} File | ":
                                "${vaultFolderDetailsList.length} Files | ":"",
                              style: TextStyle(
                                  fontFamily: "Regular",
                                  fontSize: 16,
                                  color: Color(ColorValues.BLACK_COL)),),
                            GestureDetector(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: Text("Add More",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontFamily: "Regular",
                                    fontSize: 16,
                                    color: Color(ColorValues.THEME_TEXT_COLOR)),),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: (MediaQuery.of(context).size.width) /
                                  (MediaQuery.of(context).size.height / 1.3),
                            ),
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.vertical,
                            itemCount: vaultFolderDetailsList!=null ? vaultFolderDetailsList.length:0,
                            itemBuilder: (BuildContext ctx, pos) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: GestureDetector(
                                        onTap: () async {
                                          //DownloadImage n show
                                          if(vaultFolderDetailsList[pos].isLocal){
                                             // showImage(context, pos,"");
                                             showPdfImage(pos);
                                          }else{
                                            downloadImage(vaultFolderDetailsList[pos].path);
                                          }
                                        },
                                        child: Container(
                                          height: 180,
                                          width: 120,
                                          // margin: EdgeInsets.only(top: 15),
                                          // decoration: BoxDecoration(
                                          //     color: Color(ColorValues
                                          //         .GRAY_HEADER_PRESSO_VIEW),
                                          //     border: Border.all(
                                          //         color:
                                          //         Color(ColorValues.BLACK_COL)),
                                          //     borderRadius: BorderRadius.circular(5)),
                                          decoration: BoxDecoration(
                                              color: Color(ColorValues.WHITE),
                                              border: Border.all(
                                                  color: Color(
                                                      ColorValues.BLACK_COL)),
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5, top: 10, bottom: 30),
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/vault_folder_logo.png"),
                                              // alignment: Alignment.centerLeft,
                                            ),
                                          ),
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
                                        )
                                    ),
                                  ),

                                  Positioned(
                                    // right: 0,
                                      right: 12,
                                      bottom:27,
                                      child: GestureDetector(
                                          onTap: () {
                                            // if(vaultFolderDetailsList[pos].isLocal){
                                            //   showAlertDialog(context, pos);
                                            // }else{
                                            //   showAlertDialog(context, pos);
                                            // }
                                            showAlertDialog(context, pos);
                                          },
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/delete_btn.png"),
                                            height: 18,
                                            width: 18,
                                            alignment:
                                            Alignment.center,
                                          )
                                      ))
                                ],
                              );
                            }),
                      ),
                    ],
                  ),),

                // Container(
                //   margin: EdgeInsets.all(10.0),
                //   child: Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: <Widget>[
                //         Container(
                //             margin: EdgeInsets.only(top:10.0),
                //             child: GestureDetector(
                //               onTap: (){
                //                 Navigator.of(context).pop();
                //               },
                //               child: Text(
                //                 "Cancel",
                //                 textAlign: TextAlign.end,
                //                 style: TextStyle(
                //                     fontFamily: "Regular",
                //                     fontSize: 16,
                //                     color: Color(ColorValues.BLACK_COL)),
                //               ),
                //             )),
                //
                //         Container(
                //           margin: EdgeInsets.only(left: 20, right: 5, top: 30, bottom: 20),
                //           height: 40,
                //           width: MediaQuery.of(context).size.width / 3,
                //           decoration: localFileCounter>0?BoxDecoration(
                //             color: const Color(ColorValues.THEME_TEXT_COLOR),
                //             borderRadius: BorderRadius.circular(5),
                //           ):BoxDecoration(
                //             color: const Color(ColorValues.GRAY),
                //             borderRadius: BorderRadius.circular(5),
                //           ),
                //           child: TextButton(
                //             onPressed: () {
                //               // Validate Data
                //               if(localFileCounter>0){
                //                 getPreSignedUrl();
                //               }else{
                //                 MyUtils.showCustomToast("Please attach document", true, context);
                //               }
                //             },
                //             child: Text(
                //               'Save',
                //               style:
                //               TextStyle(color: Color(ColorValues.WHITE), fontSize: 16),
                //             ),
                //           ),
                //         ),
                //       ]),
                // ),

              ],
            ),
          ),

        ),
      bottomNavigationBar:
      Container(
        margin: EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top:10.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
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
                margin: EdgeInsets.only(left: 20, right: 5, top: 30, bottom: 20),
                height: 40,
                width: MediaQuery.of(context).size.width / 3,
                decoration: localFileCounter>0?BoxDecoration(
                  color: const Color(ColorValues.THEME_TEXT_COLOR),
                  borderRadius: BorderRadius.circular(5),
                ):BoxDecoration(
                  color: const Color(ColorValues.GRAY),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {
                    // Validate Data
                    if(localFileCounter>0){
                      getPreSignedUrl();
                    }else{
                      MyUtils.showCustomToast("Please attach document", true, context);
                    }
                  },
                  child: Text(
                    'Save',
                    style:
                    TextStyle(color: Color(ColorValues.WHITE), fontSize: 16),
                  ),
                ),
              ),
            ]),
      ),
    )
    );

  }
}

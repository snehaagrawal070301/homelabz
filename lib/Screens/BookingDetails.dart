import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/Models/BookingDetailsModel.dart';
import 'package:homelabz/Models/PrescriptionModel.dart';
import 'package:homelabz/Screens/CallForBooking.dart';
import 'package:homelabz/components/MyUtils.dart';
import 'package:homelabz/components/ColorValues.dart';
import 'package:homelabz/constants/Constants.dart';
import 'package:homelabz/constants/Values.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart';
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
  TextEditingController remarks;
  Dio dio = Dio();
  double progress = 0.0;
  var path;
  ProgressDialog dialog;

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
      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var url = Uri.parse(ApiConstants.GET_BOOKING_DETAILS + widget.bookingId.toString());
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
        _model = BookingDetailsModel.fromJson(json.decode(body));
        setState(() {
          if(_model.bookingStatus!=null){
            if(_model.notes!=null && _model.notes.length>0) {
              remarks = new TextEditingController(text: _model.notes);
            }else{
              remarks = new TextEditingController(text: "No Remarks Available!");
            }
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
        Constants.HEADER_CONTENT_TYPE: Constants.HEADER_VALUE,
        Constants.HEADER_AUTH:
        "bearer " + preferences.getString(Constants.ACCESS_TOKEN),
      };

      HttpClient _client = HttpClient(context: await MyUtils.globalContext);
      _client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient _ioClient = new IOClient(_client);

      var uri = Uri.parse(ApiConstants.DOWNLOAD_ALL_DOCS+booking);

      // make GET request with query params
      final response = await _ioClient.get(uri, headers: headers);
      // check the status code for the result
      String body = response.body;
      print(body);
      var data = json.decode(body);
      List list = data;

      if (response.statusCode == 200) {
        for (int i = 0; i < list.length; i++) {
          PrescriptionModel model = PrescriptionModel.fromJson(data[i]);
          if(model.category.compareTo(Constants.CAT_PRESCRIPTION)==0) {
            prescriptionList.add(model);
          }

          setState(() {});
        }

      }
    } catch (ex) {

    }
  }

  void goToContactPage(){
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => CallForBooking()));
  }

  void callPaymentScreen() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => PaymentScreen(widget.bookingId,"BookingDetails")));
  }

  Future<void> downloadPrescription(String imagePath) async {
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
        print(response);
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

          if(fileExt.compareTo("pdf")==0){
            print("file extension ====== "+fileExt);
            // openPDF(imageUrl);
            // showPDF();
            // startDownloading(fileName, imageUrl);

            // var tempDir = await getTemporaryDirectory();
            // String fullPath = tempDir.path + fileName;
            // print('full path ${fullPath}')

            dirpath();
            downloadInFolder(fileName, imageUrl);

          }else {
            showImage(context, imageUrl);
          }
        }
      } catch (ex) {}
    }

  void dirpath() async {
    path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    print(path);
  }

  void showImage(context, imageUrl) {
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
                    Image.network(
                      imageUrl,
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<void> downloadInFolder(String fileName, String imageUrl) async {
    try {
      dialog = new ProgressDialog(context);
      dialog.style(message: 'Please wait...');
      await dialog.show();

      Response response = await dio.get(imageUrl,
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
      if (count.compareTo("100") == 0) {
        counter+=1;
        if(dialog!=null){
          dialog.hide();
        }
        MyUtils.showCustomToast(
            "File Downloaded. Please check downloads folder", false, context);
      }
    }
  }

////////////////////////////////////////////////////
  void startDownloading(String name, String imageUrl) async {
    // const String url =
    //     'https://firebasestorage.googleapis.com/v0/b/e-commerce-72247.appspot.com/o/195-1950216_led-tv-png-hd-transparent-png.png?alt=media&token=0f8a6dac-1129-4b76-8482-47a6dcc0cd3e';

    try {
      String url = imageUrl;
      // String fileName = "TV.jpg";

      String path = await _getFilePath(name);

      await dio.download(
        url,
        path,
        onReceiveProgress: (recivedBytes, totalBytes) {
          setState(() {
            progress = recivedBytes / totalBytes;
          });


          print(progress);
        },
        deleteOnError: true,
      ).then((_) {
        Navigator.pop(context);
      });
    }catch(ex){
      print(ex);
    }
  }

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$filename";
  }

  void showPDF() {
    showDialog(
        context: context,
        builder: (context)
    {
      // return Scaffold(
      //   appBar: AppBar(
      //     title: const Text('PDFViewer'),
      //   ),
      //   body: Center(
      //     child: doc != null ? PDFViewer(
      //       document: doc,
      //       zoomSteps: 1,
      //       //uncomment below line to preload all pages
      //       // lazyLoad: false,
      //       // uncomment below line to scroll vertically
      //       // scrollDirection: Axis.vertical,
      //
      //       //uncomment below code to replace bottom navigation with your own
      //       /* navigationBuilder:
      //                     (context, page, totalPages, jumpToPage, animateToPage) {
      //                   return ButtonBar(
      //                     alignment: MainAxisAlignment.spaceEvenly,
      //                     children: <Widget>[
      //                       IconButton(
      //                         icon: Icon(Icons.first_page),
      //                         onPressed: () {
      //                           jumpToPage()(page: 0);
      //                         },
      //                       ),
      //                       IconButton(
      //                         icon: Icon(Icons.arrow_back),
      //                         onPressed: () {
      //                           animateToPage(page: page - 2);
      //                         },
      //                       ),
      //                       IconButton(
      //                         icon: Icon(Icons.arrow_forward),
      //                         onPressed: () {
      //                           animateToPage(page: page);
      //                         },
      //                       ),
      //                       IconButton(
      //                         icon: Icon(Icons.last_page),
      //                         onPressed: () {
      //                           jumpToPage(page: totalPages - 1);
      //                         },
      //                       ),
      //                     ],
      //                   );
      //                 }, */
      //     ) :
      //     Container(child: Text("No PDF"),),
      //   ),
      // );
      String downloadingprogress = (progress * 100).toInt().toString();
      return AlertDialog(
        backgroundColor: Colors.black,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator.adaptive(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Downloading: $downloadingprogress%",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ],
        ),
      );
    }
    );
  }
////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(ColorValues.THEME_TEXT_COLOR),
        leading: IconButton(
          icon: ImageIcon(
            AssetImage('assets/images/back_arrow.png'),
            color: Color(ColorValues.WHITE),
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Booking Details",
          style: TextStyle(
              fontFamily: "Regular",
              fontSize: Values.PAGE_HEADING_SIZE,
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
                        fontSize: Values.HEADING_SIZE,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Regular",
                        color: Color(ColorValues.THEME_TEXT_COLOR),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Booking ID:',
                      style: TextStyle(
                        fontSize: Values.HEADING_SIZE,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Regular",
                        color: Color(ColorValues.THEME_TEXT_COLOR),
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
                        fontSize: Values.VALUE_SIZE,
                        fontFamily: "Regular",
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
                        fontSize: Values.VALUE_SIZE,
                        fontFamily: "Regular",
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
                          fontSize: Values.HEADING_SIZE,
                          fontFamily: "Regular",
                          fontWeight: FontWeight.bold,
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
                          fontSize: Values.VALUE_SIZE,
                          fontFamily: "Regular",
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
                    fontSize: Values.HEADING_SIZE,
                    fontFamily: "Regular",
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
                    fontSize: Values.VALUE_SIZE,
                    fontFamily: "Regular",
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
                      : _model.patient.mobileNumber == null
                      ? ""
                      : _model.patient.mobileNumber,

                  // '+918937846355',
                  style: TextStyle(
                    fontSize: Values.VALUE_SIZE,
                    fontFamily: "Regular",
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
                    fontSize: Values.HEADING_SIZE,
                    fontFamily: "Regular",
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
                      _model.doctor.name :"NA",
                  style: TextStyle(
                    fontSize: Values.VALUE_SIZE,
                    fontFamily: "Regular",
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
                    fontSize: Values.HEADING_SIZE,
                    fontFamily: "Regular",
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
                  style: TextStyle(
                    fontSize: Values.VALUE_SIZE,
                    fontFamily: "Regular",
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
                      ? "NA"
                      : _model.lab.user.mobileNumber,
                  // 'rating etc',
                  style: TextStyle(
                    fontSize: Values.VALUE_SIZE,
                    fontFamily: "Regular",
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
                    fontSize: Values.VALUE_SIZE,
                    fontFamily: "Regular",
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
                    fontSize: Values.HEADING_SIZE,
                    fontFamily: "Regular",
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
                          fontSize: Values.VALUE_SIZE,
                          fontFamily: "Regular",
                          color: Color(
                              ColorValues.BLACK_TEXT_COL),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Online',
                        style: TextStyle(
                          fontSize: Values.VALUE_SIZE,
                          fontFamily: "Regular",
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
                          fontSize: Values.VALUE_SIZE,
                          fontFamily: "Regular",
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
                          fontSize: Values.VALUE_SIZE,
                          fontFamily: "Regular",
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
                          fontSize: Values.VALUE_SIZE,
                          fontFamily: "Regular",
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
                          fontSize: Values.VALUE_SIZE,
                          fontFamily: "Regular",
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
                          fontSize: Values.HEADING_SIZE,
                          fontFamily: "Regular",
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )),
                ),
              )
                  :Container(),
///////////////////////////////////////////////////////////////////
              //OLD UI
              // Container(
              //   margin: EdgeInsets.only(top: 20, right: 20, left: 20),
              //   padding: EdgeInsets.only(left: 20),
              //   height: 70,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: BoxDecoration(
              //     color: Color(ColorValues.LIGHT_GRAY),
              //     border: Border.all(
              //         color: Color(ColorValues.BLACK_COLOR), width: 1),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             prescriptionList.length > 0
              //                 ? Container(
              //               alignment: Alignment.centerRight,
              //               height: 35,
              //               width:
              //               MediaQuery.of(context).size.width / 3,
              //               child: ListView.builder(
              //                   scrollDirection: Axis.horizontal,
              //                   itemCount: prescriptionList.length,
              //                   itemBuilder:
              //                       (BuildContext context, int pos) {
              //                     return GestureDetector(
              //                         onTap: () {
              //                           downloadPrescription(prescriptionList[pos].path);
              //                         },
              //                         child: Container(
              //                             height: 50,
              //                             child: Stack(
              //                               children: [
              //                                 Container(
              //                                   margin: EdgeInsets
              //                                       .fromLTRB(5, 5, 5, 5),
              //                                   child: Image(
              //                                     image: AssetImage(
              //                                         "assets/images/prescription_logo.jpg"),
              //                                     height: 30,
              //                                     width: 30,
              //                                     alignment: Alignment
              //                                         .centerLeft,
              //                                   ),
              //                                 ),
              //                               ],
              //                             ))
              //                     );
              //                   }),
              //             )
              //                 : new Container(
              //               height: 35,
              //               width: MediaQuery.of(context).size.width / 3,
              //             ),
              //           ],
              //         ),
              // ),
              ///////////////
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Text(
                  'Prescription',
                  style: TextStyle(
                    fontSize: Values.HEADING_SIZE,
                    fontFamily: "Regular",
                    fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.THEME_TEXT_COLOR),
                  ),
                ),
              ),

              Container(
                  margin: EdgeInsets.only(
                      top: 10, right: 5, left: 5, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(ColorValues.WHITE),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          spreadRadius: 0.5,
                        )
                      ]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: prescriptionList.length > 0
                              ? GridView.builder(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio:
                                (MediaQuery.of(context)
                                    .size
                                    .width) /
                                    (MediaQuery.of(context)
                                        .size
                                        .height /
                                        3),
                              ),
                              shrinkWrap: true,
                              primary: false,
                              scrollDirection: Axis.vertical,
                              itemCount: prescriptionList.length,
                              itemBuilder: (BuildContext ctx, pos) {
                                return Container(
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 8,left: 15),
                                          child: GestureDetector(
                                            onTap: () async {
                                              downloadPrescription(prescriptionList[pos].path);
                                            },
                                            child: Container(
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      child: Image(
                                                        image: AssetImage("assets/images/prescription_logo.jpg"),
                                                        height: 50,
                                                        width: 50,
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ),
                                        ),
                                    ]
                                    ));
                              })
                              : Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Center(child: Text("No Prescription Available")),
                          ),
                        ),
                      ])),

              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Remarks',
                  style: TextStyle(
                    fontSize: Values.HEADING_SIZE,
                    fontFamily: "Regular",
                    fontWeight: FontWeight.bold,
                    color: Color(
                        ColorValues.THEME_TEXT_COLOR),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 15),
                // padding: EdgeInsets.only(left: 5),
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(
                //   color: Color(ColorValues.LIGHT_GRAY),
                //   border: Border.all(
                //       color: Color(ColorValues.BLACK_COLOR), width: 1),
                //   borderRadius: BorderRadius.circular(10),
                // ),
                decoration: BoxDecoration(
                    color: Color(ColorValues.WHITE),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                      )
                    ]),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Regular",
                      color: Color(ColorValues.BLACK_TEXT_COL),
                    ),
                    controller: remarks,
                    maxLines: 2,
                    enabled: false,
                    autofocus: false,
                    readOnly: true,
                    decoration: InputDecoration(
                        border:
                        OutlineInputBorder(borderSide: BorderSide.none),
                        // hintText: "No Remarks Available!",
                        hintStyle: TextStyle(
                            // color: Color(ColorValues.BLACK_TEXT_COL).withOpacity(0.6),
                            color: Color(ColorValues.BLACK_TEXT_COL),
                            fontSize: 12.5,
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
///////////////////////////////////////////////////////////////////
            // Invoice code
            //   Container(
            //     margin: EdgeInsets.fromLTRB(0, 25, 0, 15),
            //     child: Divider(
            //       indent: 0,
            //       endIndent: 0,
            //       height: 2,
            //       color: Color(ColorValues.GREY_TEXT_COLOR),
            //     ),
            //   ),
            //
            //   Container(
            //     child: Text(
            //       'View Invoice',
            //       style: TextStyle(
            //         fontSize: Values.HEADING_SIZE,
            //         fontFamily: "Regular",
            //         fontWeight: FontWeight.bold,
            //         color: Color(
            //             ColorValues.THEME_TEXT_COLOR),
            //       ),
            //     ),
            //   ),
            //
            //   Container(
            //     margin: EdgeInsets.fromLTRB(0, 15, 0, 25),
            //     child: Divider(
            //       indent: 0,
            //       endIndent: 0,
            //       height: 2,
            //       color: Color(ColorValues.GREY_TEXT_COLOR),
            //     ),
            //   ),
     /////////////////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child:Image(image: AssetImage("assets/images/contact.png"),color: Color(
                        ColorValues.THEME_TEXT_COLOR),height: 23,width: 23,),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 15),
                    child: Text(
                      'Reach out to us ',
                      style: TextStyle(
                        fontSize: Values.HEADING_SIZE,
                        fontFamily: "Regular",
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
                  goToContactPage();
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: 20, bottom: 20, left: 25, right: 25),
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
                          fontSize: Values.HEADING_SIZE,
                          fontFamily: "Regular",
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

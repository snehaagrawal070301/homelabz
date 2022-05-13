import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:homelabz/components/ColorValues.dart';
import 'package:homelabz/components/MyUtils.dart';
import 'package:homelabz/constants/Constants.dart';
import 'package:path/path.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;

  const PDFViewerPage({
    Key key,
    @required this.file,
  }) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFViewController controller;
  bool isConsent = false;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: pages >= 2
            ? [
          Center(child: Text(text)),
          IconButton(
            icon: Icon(Icons.chevron_left, size: 32),
            onPressed: () {
              final page = indexPage == 0 ? pages : indexPage - 1;
              controller.setPage(page);
            },
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, size: 32),
            onPressed: () {
              final page = indexPage == pages - 1 ? 0 : indexPage + 1;
              controller.setPage(page);
            },
          ),
        ]
            : null,
      ),
      body:         Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Container(

            height: 200.0,
            padding: EdgeInsets.all(0.0),
            child: PDFView(
              filePath: widget.file.path,
              // autoSpacing: false,
              // swipeHorizontal: true,
              // pageSnap: false,
              // pageFling: false,
              onRender: (pages) => setState(() => this.pages = pages),
              onViewCreated: (controller) =>
                  setState(() => this.controller = controller),
              onPageChanged: (indexPage, _) =>
                  setState(() => this.indexPage = indexPage),
            ),
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Checkbox(
                      checkColor: Color(ColorValues.WHITE),
                      activeColor: Color(ColorValues.THEME_TEXT_COLOR),
                      value: this.isConsent,
                      onChanged: (bool value) {
                        setState(() {
                          this.isConsent = value;
                        });
                      },
                    ),
                  ),
                  Container(
                      child: Text("I accept all the terms and conditions!",
                          style:
                          TextStyle(fontFamily: "Regular", fontSize: 16),
                          textAlign: TextAlign.center)),
                ]),
          ),
          Container(
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
                    margin: EdgeInsets.only(
                        left: 20, right: 15, top: 20, bottom: 20),
                    height: 40,
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: isConsent
                        ? BoxDecoration(
                      color: const Color(ColorValues.THEME_TEXT_COLOR),
                      borderRadius: BorderRadius.circular(5),
                    )
                        : BoxDecoration(
                      color: const Color(ColorValues.GRAY),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (isConsent) {
                          // Update Consent api
                          // updateConsent();
                          MyUtils.showCustomToast(
                              "Update consent", true, context);
                        } else {
                          MyUtils.showCustomToast(
                              Constants.TnC_VALIDATION, true, context);
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Color(ColorValues.WHITE), fontSize: 16),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),

    );
  }
}

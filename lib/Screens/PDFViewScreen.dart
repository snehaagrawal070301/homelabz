import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PDFViewScreen extends StatefulWidget {
  // final File file;
  // final String url;

  // const PDFViewScreen(this.file, this.url);
  const PDFViewScreen();

  @override
  _PDFViewScreenState createState() => _PDFViewScreenState();
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  Future<void> loadDocument() async {
    // File file = File(widget.file.absolute);
    // document = await PDFDocument.fromFile(widget.file.absolute);
    document = await PDFDocument.fromURL("https://pspdfkit.com/downloads/pspdfkit-flutter-quickstart-guide.pdf");
    // document = await PDFDocument.fromAsset('assets/sample.pdf');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDFViewer'),
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
          document: document,
          zoomSteps: 1,
        ),
      ),
    );
  }
}

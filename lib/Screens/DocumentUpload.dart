import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  List<PlatformFile> _paths;
  String _directoryPath;
  PlatformFile file;
  bool _loadingPath = false;
  bool _multiPick = false;

  @override
  void initState() {
    super.initState();
  }
//  void showImage(context,file,ValueChanged<Platform>) {
//    showDialog(context: context, builder: (context){
//      return Dialog(
//        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//        child: Container(
//          height: 250,
//          width: 250,
//          child: Padding(
//            padding: EdgeInsets.all(5.0),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: [
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.end,
//                  children: [
//                    GestureDetector(
//                      onTap: () {
//                        Navigator.pop(context);
//                      },
//                      child: Icon(
//                          Icons.cancel
//                      ),
//                    )
//                  ],
//                ),
//                Image.asset(
//                  imageName,
//                  width: 200,
//                  height: 200,
//                  fit: BoxFit.fitHeight,
//                ),
//              ],
//            ),
//          ),
//        ),
//      );
//    }
//    );
//  }
  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        allowMultiple: _multiPick,
          type: FileType.custom,
          allowedExtensions: ['jpg','png','doc','pdf']
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths.first.extension);
      _fileName =
      _paths != null ? _paths.map((e) => e.name).toString() : '...';
      print(_fileName);
      file = _paths.first;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('File Picker example app'),
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 200.0),
                      child: SwitchListTile.adaptive(
                        title:
                        Text('Pick multiple files', textAlign: TextAlign.right),
                        onChanged: (bool value) =>
                            setState(() => _multiPick = value),
                        value: _multiPick,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                      child: Column(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () => _openFileExplorer(),
                            child: const Text("Open file picker"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                      child: Column(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: ()=>OpenFile.open(file.path),
                            child: const Text("Open picked file"),
                          ),
                        ],
                      ),
                    ),
                    Builder(
                      builder: (BuildContext context) => _loadingPath
                          ? Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: const CircularProgressIndicator(),
                      )
                          : _directoryPath != null
                          ? ListTile(
                        title: const Text('Directory path'),
                        subtitle: Text(_directoryPath),
                      )
                          : _paths != null
                          ? Container(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        height:
                        MediaQuery.of(context).size.height * 0.50,
                        child: Scrollbar(
                            child: ListView.separated(
                              itemCount:
                              _paths != null && _paths.isNotEmpty
                                  ? _paths.length
                                  : 1,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                final bool isMultiPath =
                                    _paths != null && _paths.isNotEmpty;
                                final String name = 'File $index: ' +
                                    (isMultiPath
                                        ? _paths
                                        .map((e) => e.name)
                                        .toList()[index]
                                        : _fileName ?? '...');
                                final path = _paths
                                    .map((e) => e.path)
                                    .toList()[index]
                                    .toString();

                                return ListTile(
                                  title: Text(
                                    name,
                                  ),
                                  subtitle: Text(path),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                              const Divider(),
                            )),
                      )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
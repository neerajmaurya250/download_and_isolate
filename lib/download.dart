import 'dart:io';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

import 'isolate_spawn.dart';

class DownloadFile extends StatefulWidget {
  @override
  _DownloadFileState createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile> {
  double _progress = 0;

  get downloadProgress => _progress;
  bool progress = false;
  List<int> bytes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              var status = await Permission.storage.status;
              if (!status.isGranted) {
                await Permission.storage.request();
              }
              _downloadFile(
                  'https://books.goalkicker.com/PythonBook/PythonNotesForProfessionals.pdf',
                  'file.pdf');
            },
            child: Text('Download'),
          ),
          progress == true
              ? Container(
                  child: Text('Downloading'),
                )
              : Container(),
          ElevatedButton(
            onPressed: () {
              readFile();
            },
            child: Text('Read'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PerformancePage()));
            },
            child: Text('Next'),
          ),
        ],
      )),
    );
  }

  Future<File> _downloadFile(String url, String filename) async {
    String path;
    File file;
    HttpClient httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));

    var response = await request.close();

    var length = response.contentLength;
    if (response.statusCode == 200) {
      setState(() {
        progress = true;
      });
      print('==================> Downloading <=============');

      var bytes = await consolidateHttpClientResponseBytes(response);
      new Directory('/storage/emulated/0/MyFile').create()
          .then((Directory directory) async {
        path = directory.path;
        file = new File('$path/$filename');
        await file.writeAsBytes(bytes);
        print(directory.path);
      });

      // return file;
    } else {
      String error = response.statusCode.toString();
      print('===============> Error <==============>>' + error);
    }
    return file;
  }

  // to read from file
  Future<String> readFile() async {
    String text;
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      String path = dir.path;
      File file = File('$path/filename.pdf');
      print(file.lengthSync());
      text = await file.readAsString();

      print('==================from file===============>>>  ' + text);
    } catch (e) {}
    return text;
  }
}

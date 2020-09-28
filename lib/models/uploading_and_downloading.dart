import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:firebase_storage/firebase_storage.dart';

import 'dart:math';

import 'dart:typed_data';
import 'dart:io';
import 'dart:async';

class MyHomePage_readWrite extends StatefulWidget {
  @override
  _MyHomePage_readWriteState createState() => _MyHomePage_readWriteState();
}

class _MyHomePage_readWriteState extends State<MyHomePage_readWrite> {
  String _path;
  File _cachedFile;

  Future<Null> uploadFile(String filepath) async {
    final ByteData bytes = await rootBundle.load(filepath);
    final Directory tempDir = Directory.systemTemp;
//    final String fileName = "${Random().nextInt(10000)}.jpg";
    final String fileName = 'my-file-1.txt';
    final File file = File('${tempDir.path}/$fileName');
//    final File file = File('gs://my-project-1-206bd.appspot.com/tasks/notes-1.txt');
    file.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);

    final StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask task = ref.putFile(file);
//    final Uri downloadUrl = (await task.future).downloadUrl;
    final String downloadUrl = task.toString();
    _path = downloadUrl;

    _path = downloadUrl.toString();

    print(_path);
  }

  Future<Null> downloadFile(String httpPath) async {
    final RegExp regExp = RegExp('([^?/]*\.(jpg))');
    final String fileName = regExp.stringMatch(httpPath);
    final Directory tempDir = Directory.systemTemp;
    final File file = File('${tempDir.path}/$fileName');

    final StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    final StorageFileDownloadTask downloadTask = ref.writeToFile(file);

    final int byteNumber = (await downloadTask.future).totalByteCount;

    print(byteNumber);

    setState(() => _cachedFile = file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              child: Text('Upload file'),
              color: Colors.blueGrey,
              onPressed: () {
                uploadFile('images/quest-1.txt');
                print('file Uploaded Successfully');
              },
            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: fileNames
//                  .map((name) => GestureDetector(
//                  onTap: () async {
//                    print(name);
//                    await uploadFile(name);
//                  },
//                  child: Image.asset(
//                    name,
//                    width: 125.0,
//                  )))
//                  .toList(),
//            ),
//            Container(
//              color: Colors.black,
//              width: 150.0,
//              height: 150.0,
//              child: _cachedFile != null
//                  ? Image.asset(_cachedFile.path)
//                  : Container(),
//            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _path = 'gs://my-project-1-206bd.appspot.com/tasks/ilai_412.jpeg';
          await downloadFile(_path);
          print('Path Location is: $_path');
          print('Cached file location is : $_cachedFile');
        },
        child: Icon(Icons.cloud_download),
      ),
    );
  }
}

List<String> fileNames = <String>[
  'images/ilai_111.jpeg',
  'images/ilai_321.jpeg',
];

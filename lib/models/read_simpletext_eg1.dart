import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:convert';


class FlutterDemo extends StatefulWidget {

  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
//  var myData = json.decode('images/myfile1.json');
//  String data = await DefaultAssetBundle.of(context).loadString("assets/data.json");
//  final jsonResult = json.decode(data);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reading and Writing Files')),
      body: Center(
        child: Text(
          'This is the body of the scaffold',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: loadJson,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  loadJson() async {
   final ref = await FirebaseStorage.instance.ref().child('my-file-1.txt');
   var url = await ref.getDownloadURL();
   var pathto = await ref.getPath();
   String pathToFile = pathto;
//       'images/myfile1.json';

   print(url);
   print(pathto);
//    String pathToFile='gs://my-project-1-206bd.appspot.com/tasks/myfile1.json';
    String data = await rootBundle.loadString(pathToFile);
    var jsonResult = json.decode(data);
    var myVar1 = jsonResult[0]['question'];
//    print('The user is $new1');
  }
}

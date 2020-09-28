import 'package:flutter/material.dart';
import 'package:flutterappusersignin/pages/exam_list.dart';
import 'package:flutterappusersignin/pages/home_page_reg.dart';
import 'package:flutterappusersignin/services/authentication.dart';
import 'package:flutterappusersignin/pages/root_page.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutterappusersignin/models/uploading_and_downloading.dart';

import 'package:flutterappusersignin/models/read_simple_text.dart';
import 'package:flutterappusersignin/models/read_simpletext_eg1.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'TANGEDCO-AE',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(auth: Auth()));
//        FlutterDemo() // reading json tutorial is here.
//        ReadSimpleText(),
//        MyHomePage_readWrite(),
//        MyCardList()//        new RootPage(auth: Auth()));
  }
}

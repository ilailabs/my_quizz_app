import 'dart:io' as prefix0;
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/my_text.txt');
}


class ReadSimpleText extends StatefulWidget {
  @override
  _ReadSimpleTextState createState() => _ReadSimpleTextState();
}

class _ReadSimpleTextState extends State<ReadSimpleText> {
  var _enterDataField = new TextEditingController();
  String textValue = 'this is a smple string to be written';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read/Write"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 150.0,
//        width: 150.0,
            color: Colors.blue[100],
            padding: const EdgeInsets.all(13.4),
            alignment: Alignment.topCenter,
            child: Text(textValue),
          ),
          FlatButton(
            child: Text('View Path'),
            onPressed: (){
              print('Path to stroe is: ');
            },

          ),

//        child: ListTile(
//          title: TextField(
//            controller: _enterDataField,
//            decoration: InputDecoration(
//                labelText: "Write Something"
//            ),
//          ),
//
//          subtitle: FlatButton(
//            color: Colors.blueGrey[100],
//            onPressed: (){
//
//              if(_enterDataField.text.isNotEmpty){
//                print('writeData() is called');
//                writeData(_enterDataField.text);
//              }
//              else{
//              }
//            },
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                Text("Save Data"),
//
//                Padding(padding: EdgeInsets.all(14.5),),
//
//                FutureBuilder(
//                  future: readData(),
//                  builder: (BuildContext context, AsyncSnapshot<String> data){
//
//                    if(data.hasData != null) {
//                      return Text(
//                        data.data.toString(),
//                        style: TextStyle(color: Colors.blueAccent),
//                      );
//                    }
//                    else{
//                      return Text("No data saved");
//                    }
//                  },
//                )
//
//              ],
//            ),
//          ),
//        ),
        ],
      ),
    );
  }
}

//Future<String> get localPath async {
//  final directory =
//      await getApplicationDocumentsDirectory(); //home/directory:text
//  return directory.path;
//}
//
//Future<File> get _localFile async {
//  final path = await localPath;
//
//  return new File("$path/data.txt");
//}
//
////Write and read from our file
//Future<File> writeData(String message) async {
//  final file = await _localFile;
//
//  return file.writeAsString("$message");
//}
//
//Future<String> readData() async {
//  try {
//    final file = await _localFile;
//
//    String data = await file.readAsString();
//
//    return data;
//  } catch (e) {
//    return "Nothing saved yet";
//  }
//}

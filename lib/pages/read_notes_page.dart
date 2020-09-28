import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

class NotesPage extends StatelessWidget {
  NotesPage({@required this.title, this.description});

  //todo: QuizID; UserID;
  //TODO: Score;

  final title;
  final description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(description),
                RaisedButton(
                    child: Icon(Icons.home, color: Colors.white,),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () => Navigator.pop(context)),
              ]),
        ));
  }
}


//TODO: Reading questions from JSON String

readJsonfile(String path ) async {
  print('file is being read');
  var ref = FirebaseStorage.instance.ref().child(path);
  var url = await ref.getDownloadURL();
//    print(url);
  var response = await http.get(url);
  var jsonResponse = jsonDecode(response.body);
//    print(jsonResponse[0]);
//    return jsonResponse;
}
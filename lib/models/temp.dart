import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.green),
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Simple Card view'),
      ),
      body: new ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i) {
          return Container(
            height: 130,
            child: Card(
//                color: Colors.blue,
              elevation: 10,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
//                            image: DecorationImage(
//                                image: AssetImage('images/hacker.jpeg'),
//                                fit: BoxFit.cover),
                            borderRadius:
                            BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ]),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext conext) {
                          return AlertDialog(
                            title: Text('Not in stock'),
                            content:
                            const Text('This item is no longer available'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(30.0),
                        child: Chip(
                          label: Text('@anonymous'),
                          shadowColor: Colors.blue,
                          backgroundColor: Colors.green,
                          elevation: 10,
                          autofocus: true,
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

//TODO; ALL InheritedElement

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterappusersignin/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'custom_card_builder.dart';
import 'edit_user_profile.dart';
import 'package:flutterappusersignin/services/authentication.dart';
import 'package:http/http.dart' as http;



class SolutionsPage extends StatefulWidget {
  @override
  _SolutionsPageState createState() => _SolutionsPageState();
}

class _SolutionsPageState extends State<SolutionsPage> {

  String myuser = 'doX7iSlxyuU1fWCWM07SPsHBG8R2';
  String examCode = 'em11';
  var field1;
//  String fieldName1 = '${examCode}_ans';
  String fieldName1 = 'em11_ans';


  @override
  void initState() {
    setState(() {
      lenPaper = 7;
      answer_key = List(7);
    });
  }

//  void getAnyData(String tabName, String docName) {
//    void getAnyData() {
//
//      String fieldName = 'uid';
//    String field;
//
//    String tabName = 'users';
//    String docName = 'doX7iSlxyuU1fWCWM07SPsHBG8R2';
//    Firestore.instance
//        .collection(tabName)
//        .document(docName)
//    // ignore: non_constant_identifier_names
//        .get()
//        .then((DocumentSnapshot) {
//      field = DocumentSnapshot.data[fieldName].toString();
//      print('From getAnyData $field');
//      setState(() {
//        user1id = field.toString();
//        print('get anydata is executed');
//      });
//    });
//  }

  getUserData(String docNameUserID){
    Firestore.instance
        .collection('users')
        .document(docNameUserID)
    // ignore: non_constant_identifier_names
        .get()
        .then((DocumentSnapshot) {
      field1 = DocumentSnapshot.data[fieldName1];
      print('field1: $field1');
//      print('field');
      setState(() {

//        user1id = field.toString();
        print('get anydata is executed');
      });
    });

  }


  var lenPaper=7;
  var answer_key = List(7);

  getAnsKey(){
    for(int i=0;i< lenPaper; i++){
//      var tempA = questions[i]['ans'];
//      print(tempA);
//      answer_key[i]=questions[i]['ans'];
      var tempa = getQuestionField(i, 'video');
      print(tempa);
    }
    print('get ans key is done');
  }

  getQuestionField(int a, String fieldName) {
    if (questions == null) {
      print(lenPaper);
      return null;
    } else
      return questions[a][fieldName];
  }
//  int getCorrectAnswerfor(int a) {
//    if (questions == null) {
//      print(lenPaper);
//      return null;
//    } else
//      return questions[a]['ans'];
//  }

  var questions;

  getQuestionData(String tabName, String examcode) async {
//    String path = '$tabName/$examcode.json';
    String path = 'Part-1/em11.json';
    var ref = FirebaseStorage.instance.ref().child(path);
    var url = await ref.getDownloadURL();
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    setState(() {
      questions = jsonResponse;
      print('Question data read sucessfully');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('some'),),
//      body: Column(
//        children: <Widget>[
//          Container(
//            height: 200.0,
//            width: double.infinity,
//            color: Colors.orange[100],
//            child: Column(
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    FlatButton(child: Text('GetUserAns'),
//                      color: Colors.orange[100],
//                      onPressed: (){
////            getAnyData();
//                        getUserData(myuser);
//
//                        String str1 = 'em11';
//                        String examname = '${str1}_ans';
//                        print(examname);
//                      },),
//
//                    FlatButton(
//                      child: Text('GetQuestionData'),
//                      color: Colors.orange[200],
//                      onPressed: (){
//                        getQuestionData('string1', 'string2');
//                      },
//                    ),
//                    FlatButton(
//                      child: Text('GetKey'),
//                      color: Colors.orange[300],
//                      onPressed: (){
//                        getAnsKey();
////                        print(answer_key);
//                      },
//                    ),
//                  ],
//                ),
//                Text(''
//                'UserID: $myuser \n'
//                'ExamID: $examCode \n \n'
//                'UserAns: $field1'
//
//                    ''),
//              ],
//            ),
//          ),
////          SingleChildScrollView(
////              child: buildMySoln(),
//
////    ),
//
//
//        ],
//      ),

        body: ListView.builder(
//    itemCount: lenPaper,
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              var qno = index + 1;
//                List<Icon> qicons = List(lenPaper);
              Color cardcolor(int a) {
//        if (scoreKeeper[a] == 0) {
//          return Colors.red[200];
//        } else if (scoreKeeper[a] == null) {
//          return Colors.grey[300];
//        } else
                return Colors.white;
              }

              Icon satusIcon(int a) {
//        if (scoreKeeper[a] == 0 || scoreKeeper[a] == null) {
//          if (userConfidence[a] == 'r') {
//            return Icon(
//              Icons.info,
//              color: Colors.purple,
//            );
//          } else
//            return Icon(
//              Icons.info,
//              color: Colors.grey[500],
//            );
//        } else if (userConfidence[a] == 's')
//          return Icon(
//            Icons.check,
//            color: Colors.green,
//          );
//        else if (userConfidence[a] == 'r')
                return Icon(Icons.check, color: Colors.purple);
              }

              return Card(
                elevation: 4.0,
                child: Container(
                  color: cardcolor(index),
                  child: Column(
                    children: <Widget>[
                      Text('$qno'),
                      satusIcon(index),
                    ],
                  ),
                ),
              );
            })    );
  }
}

StreamBuilder buildMySoln() {
  bool checkGuestUser(bool isGuest, bool docip) {
    if (isGuest) return docip;
    return true;
  }

  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('users').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return Text('Loading...');
        default:
          return new Column(
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              return new CustomCardSoln(
                  UserID: document['uid']
//                title: document['title'],
//                description: document['subtitle'],
//                isExam: document['exam'],
//                moduleCode: document['code'],
//                visible: checkGuestUser(isGuest, document['guest']),
//                tabname: tabName,
//                lenPaper: document['length'],
//userId: userid ,
//                document['guest'],//todo if guest user defalut; or change
              );
            }).toList(),
          );
      }
    },
  );
}

class CustomCardSoln extends StatelessWidget {
  CustomCardSoln(
      {@required
      this.UserID,
//        this.title,
//        this.description,
//        this.isExam,
//        this.visible,
//        this.moduleCode,
//        this.tabname,
//        this.lenPaper
      });

//  final title;
//  final description;
//  final isExam;
//  final visible;
//  final moduleCode;
  final UserID;
//  final tabname;
//  final lenPaper;


//String details = 'userid: $UserID';

//  todo:isCompled has to be obtained form database
  bool isCompleted = false; //todo: this has to be ovve written;

  Color StatusOfCompletion(bool isCompleted) {
    if (isCompleted) return Colors.blue;
    return Colors.grey;
  }

  Icon CheckExamIcon(bool varisExam, bool isDone) {
    if (!varisExam && !isDone) {
      return Icon(Icons.book, color: Colors.grey);
    } else if (!varisExam && isDone) {
      return Icon(Icons.book, color: Colors.blue);
    }

    if (varisExam && !isDone) {
      return Icon(Icons.assignment, color: Colors.grey);
    } else if (varisExam && isDone) {
      return Icon(Icons.assignment, color: Colors.blue);
    }
  }

  Color TextvisibleorNot(bool visible) {
    if (!visible) {
      return Colors.grey[500];
    } else {
      return Colors.black;
    }
  }

  Color IconvisibleorNot(bool visible) {
    if (!visible) {
      return Colors.blue[100];
    } else {
      return Colors.blue;
    }
  }

  CheckExamText(bool isvis, bool varisExam) {
    if (!varisExam)
      return Text(
        'Read',
        style: TextStyle(color: IconvisibleorNot(isvis)),
      );
    return Text(
      'Quiz',
      style: TextStyle(color: IconvisibleorNot(isvis)),
    );
  }

  void downloadNotes() {
    print('Downloading Notes');
  }

  void downloadQuizKey() {
    print('Downloading solution key');
  }

  void signInAlert() {
    print('Sing In to access all');
  }

  void showCompleteExamAlert() {
    print('Complete the exam to view the solution key');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: FlatButton(
              child: Icon(Icons.book, color: Colors.grey),
              color: Colors.blue,
              onPressed: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => SolutionsPage()),
//                );
              },
            ),
            title: Text(
              'sample1',
              style: TextStyle(color: Colors.blue),
            ),
            subtitle: Text(
              UserID,
              style: TextStyle(color: Colors.blue),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text('text goes here'),
//                onPressed: () {
//                  if (visible) {
//                    if (isExam) {
//                      print('navigate to quiz page');
////                      Navigator.push(
////                          context,
////                          MaterialPageRoute(
////                              builder: (context) => QuizPage(
//////                                      title: title,
//////                                      description: description,
////                                    examCode: moduleCode,
////                                    userID: UserID,
////                                    tabname: tabname,
////                                    lenPaper: lenPaper,
////                                  )));
//
////                      Alert(
////                        context: context,
////                        type: AlertType.warning,
////                        title: "Start the quiz!",
////                        desc: "Read the instructions carefully before you begin", //todo; ref to instructions page;
////                        buttons: [
////
////                          DialogButton(
////                            child: Text(
////                              "Start",
////                              style: TextStyle(color: Colors.white, fontSize: 20),
////                            ),
////                            onPressed: () {
////                              Navigator.push(
////                                  context,
////                                  MaterialPageRoute(
////                                      builder: (context) =>
////                                          QuizPage(
//////                                      title: title,
//////                                      description: description,
////                                            examCode: moduleCode,
////                                            userID: UserID,
////                                            tabname: tabname,
////                                            lenPaper: lenPaper,
////                                          )));
////                            },
////                            color: Colors.blue,
////                          ),
////                          DialogButton(
////                            child: Text(
////                              "Later",
////                              style: TextStyle(color: Colors.white, fontSize: 20),
////                            ),
////                            onPressed: () => Navigator.pop(context),
////                            color: Colors.grey,
////                          )
////                        ],
////                      ).show();
//
//
//
//
//                    } else {
////                      Navigator.push(
////                          context,
////                          MaterialPageRoute(
////                              builder: (context) => NotesPage(
////                                  title: title, description: description)));
//                    }
//                  } else {
//                    signInAlert();
//                  }
//                },
              ),
              FlatButton(
                child: Icon(
                    Icons.file_download,
                    color: Colors.orange
//                  IconvisibleorNot(visible),
                ),
                onPressed: () {
//                  if (visible && !isExam) {
//                    downloadNotes();
//                  } else if (visible && isExam && !isCompleted) {
//                    return showCompleteExamAlert();
//                  } else if (visible && isExam && isCompleted) {
//                    return downloadQuizKey();
//                  } else {
//                    signInAlert();
//                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

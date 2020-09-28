// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutterappusersignin/models/load_pdf_tutorial.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterappusersignin/pages/read_notes_page.dart';
import 'package:flutterappusersignin/pages/solutions_page.dart';
import 'package:flutterappusersignin/pages/take_quiz_page.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_widgets/pdf/load_pdf.dart';
//import 'package:flutter_widgets/pdf/pdf_screen.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:flutter_widgets/plugins/firetop/storage/fire_storage_service.dart';

import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_plugin.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_widgets/pdf/load_pdf.dart';
//import 'package:flutter_widgets/pdf/pdf_screen.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:flutter_widgets/plugins/firetop/storage/fire_storage_service.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


StreamBuilder buildMyList(String tabName, bool isGuest, String userid, List<String> completedModules) {
  bool checkGuestUser(bool isGuest, bool docip) {
    if (isGuest) return docip;
    return true;
  }

  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection(tabName).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return CircularProgressIndicator();
//            Text('Loading...');
        default:
          return new Column(
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              return new CustomCard(
                UserID: userid,
                title: document['title'],
                description: document['subtitle'],
                isExam: document['exam'],
                moduleCode: document['code'],
                visible: checkGuestUser(isGuest, document['guest']),
                tabname: tabName,
                lenPaper: document['length'],
completedModules: completedModules,
pdfweblink: document['key'],
//userId: userid ,
//                document['guest'],//todo if guest user defalut; or change
              );
            }).toList(),
          );
      }
    },
  );
}

class CustomCard extends StatelessWidget {
  CustomCard(
      {@required this.UserID,
      this.title,
      this.description,
      this.isExam,
      this.visible,
      this.moduleCode,
      this.tabname,
      this.lenPaper, this.completedModules, this.pdfweblink
      });

  final title;
  final description;
  final isExam;
  final visible;
  final moduleCode;
  final UserID;
  final tabname;
  final lenPaper;
  final completedModules;
  final pdfweblink;



//  todo:isCompled has to be obtained form database
  bool isCompleted;
//  double examtime;

  bool checkIfCompleted(String examcode){
    if(completedModules.contains(examcode)) return true; return false;
  }

  String examTime(var lenPaper){
    if (lenPaper == null) return '-';
    else{
      double examtime = 1.2*lenPaper.toDouble();
      String tempTime = examtime.round().toString();
      return tempTime;
    }

  }

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

  Color IconvisibleorNot_new(bool visible, isExam, iscompleted) {
    if (!visible) {
      return Colors.blue[100];
    } else if (visible && !isExam){
      return Colors.blue;
    }
    else if (visible && isExam && !iscompleted) {
      return Colors.blue[100];    } else if (visible && isExam && iscompleted) {
      return Colors.blue;
    } else {
      return Colors.blue[100];
    }}

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

//  void downloadQuizKey() {
//    print('Downloading solution key');
//  }

  void signInAlert() {
    print('Sing In to access all');


  }

  void showCompleteExamAlert() {
    print('Complete the exam to view the solution key');

  }

//  String notes_url = 'https://firebasestorage.googleapis.com/v0/b/my-project-1-206bd.appspot.com/o/Part-1%2Fnotes101.html?alt=media&token=f88b5d8d-35e9-4d69-a2d9-08172fd09d96';
// String notes_url = "https://firebasestorage.googleapis.com/v0/b/my-project-1-206bd.appspot.com/o/Part-1%2Femn11%2Femn11.html?alt=media&token=697cb70f-38c6-47b4-9aa4-7dce68b92043";
//  String notes_path = "Part-2/ben11/ben11.html";
//String notes_path = "$tabname/$moduleCode/$moduleCode.html";



  getUserData(String docNameUserID) async {
    print('starting getUserData()');
    String fieldName1 = 'name';
    Firestore.instance
        .collection('users')
        .document(docNameUserID)
    // ignore: non_constant_identifier_names
        .get()
        .then((DocumentSnapshot) {
//      completedModules = DocumentSnapshot.data[fieldName1];
//      return completedModules;
    });

//    print(userAnswer);
//    return userAnswer;

  }

  userRequest(){

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: FlatButton(
                child: CheckExamIcon(isExam, checkIfCompleted(moduleCode)),
//              color: Colors.blue,
              onPressed: () {
                  if(checkIfCompleted(moduleCode))
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SolutionsPage(
                      examCode: moduleCode,
                      userID: UserID,
                      tabname: tabname,
                      lenPaper: lenPaper,
                    );
                  }),
                ); else print('complete module first');
              }
            ),
            title: Text(
              title,
              style: TextStyle(color: TextvisibleorNot(visible)),
            ),
            subtitle: Text(
              '$description '
              '\n${moduleCode.toString().toUpperCase()} | '
                  '${examTime(lenPaper)} Mins'
                  '   ',
              style: TextStyle(color: TextvisibleorNot(visible)),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: CheckExamText(visible, isExam),
                onPressed: () {
                  if (visible) {
                    if (isExam && !checkIfCompleted(moduleCode)) {
                      print('navigate to quiz page');
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => QuizPage(
////                                      title: title,
////                                      description: description,
//                                    examCode: moduleCode,
//                                    userID: UserID,
//                                    tabname: tabname,
//                                    lenPaper: lenPaper,
//                                  )));

                        Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "Start the quiz!",
                          desc: "Read the instructions carefully before you begin", //todo; ref to instructions page;
                          buttons: [

                            DialogButton(
                              child: Text(
                                "Start",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            QuizPage(
//                                      title: title,
//                                      description: description,
                                              examCode: moduleCode,
                                              userID: UserID,
                                              tabname: tabname,
                                              lenPaper: lenPaper,
                                            )));
                              },
                              color: Colors.blue,
                            ),
                            DialogButton(
                              child: Text(
                                "Later",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              color: Colors.grey,
                            )
                          ],
                        ).show();
                    }
                    else if (isExam && checkIfCompleted(moduleCode)) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  QuizPage(
//                                      title: title,
//                                      description: description,
                                    examCode: moduleCode,
                                    userID: UserID,
                                    tabname: tabname,
                                    lenPaper: lenPaper,
                                  )));

                    }
                    else {
//                      print('read notes: path: $notes_path');
                      print("$tabname/$moduleCode/$moduleCode.html");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
//                                  NotesPage(title: title, description: description)
                                  ReadNotes(
                                    notesPath: "$tabname/$moduleCode/$moduleCode.html",
                                  )
                          ));}
                  }
                  else {
                    signInAlert();
                    Alert(
                      context: context,
                      type: AlertType.warning,
                      title: "Contents Locked",
                      desc: "Please consider subscribing to unlock all the modules",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Request",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  requestLogin(),

                            ),),
                          color: Color.fromRGBO(0, 179, 134, 1.0),
                        ),
                        DialogButton(
                          child: Text(
                            "Later",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(116, 116, 191, 1.0),
                            Color.fromRGBO(52, 138, 199, 1.0)
                          ]),
                        )
                      ],
                    ).show();
                  }
                },
              ),

              FlatButton(
                child: Icon(
                  Icons.file_download,
                  color: IconvisibleorNot_new(visible, isExam, checkIfCompleted(moduleCode)),
                ),
                onPressed: () {
                  if (visible && !isExam) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            downloadPdf(pdfdirectlink: pdfweblink),

                      ),);                  } else if (visible && isExam && !checkIfCompleted(moduleCode)) {
                    {
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "Solution",
                        desc: "Complete the quiz to view solutions",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Ok",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ],
                      ).show();
                    };
                  } else if (visible && isExam && checkIfCompleted(moduleCode)) {

                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  downloadPdf(pdfdirectlink: pdfweblink, title: title),

                          ),);

                      }
                  } else {
                    signInAlert();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReadNotes extends StatefulWidget {
    ReadNotes(
      {@required this.notesPath,
      });
  final notesPath;

  @override
  _ReadNotesState createState() => _ReadNotesState();
}

class _ReadNotesState extends State<ReadNotes> {

  String notesUrl;
  getNotesUrl(String path) async  {
    var ref = FirebaseStorage.instance.ref().child(path);
    var url = await ref.getDownloadURL();
    print(url);
    setState(() {
      notesUrl = url;
    });
  }

  @override
  void initState() {
    super.initState();
    getNotesUrl(widget.notesPath);
    print(notesUrl);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom]);
    if(notesUrl==null) return Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      body: WebviewScaffold(
      url: notesUrl,
      mediaPlaybackRequiresUserGesture: false,
      clearCache: false,
      withZoom: true,
      withLocalStorage: true,
      hidden: false,
      initialChild: Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ) ,
    );
  }
}

class downloadPdf extends StatefulWidget {
  downloadPdf(
      {@required this.pdfdirectlink, this.title,
      });
  final pdfdirectlink;
  final title;

  @override
  _downloadPdfState createState() => _downloadPdfState();
}

class _downloadPdfState extends State<downloadPdf> {
  @override
  Widget build(BuildContext context) {
    if (widget.pdfdirectlink == null) return Scaffold(
      body: Center(child: Text("File Not Found \nPlease Try Again Later")),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: WebviewScaffold(
        url: widget.pdfdirectlink,
        mediaPlaybackRequiresUserGesture: false,
        withZoom: true,
        withLocalStorage: true,
        hidden: false,
        initialChild: Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ) ,
    );
  }
}

class requestLogin extends StatefulWidget {
  @override
  _requestLoginState createState() => _requestLoginState();
}

class _requestLoginState extends State<requestLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In Request Form"),),
      body: Container(
        color: Colors.blue,
        height: 300.0,
      )
    );
  }
}












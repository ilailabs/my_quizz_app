import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutterappusersignin/pages/home_page_reg.dart';
import 'package:flutterappusersignin/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'custom_card_builder.dart';
import 'edit_user_profile.dart';
import 'package:flutterappusersignin/services/authentication.dart';
import 'package:http/http.dart' as http;
import 'package:flutterappusersignin/services/authentication.dart';
//import 'package:extended_image/extended_image.dart';
//import 'package:pinch_zoom_image_updated/pinch_zoom_image_updated.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player/video_player.dart';


class SolutionsPage extends StatefulWidget {
  SolutionsPage(
      {@required this.userID, this.examCode, this.tabname, this.lenPaper});
  final String userID;
  final String examCode;
  final String tabname;
  final int lenPaper;

  @override
  _SolutionsPageState createState() {
    return _SolutionsPageState();
  }
}

class _SolutionsPageState extends State<SolutionsPage> {


  var userAnswer;
  var field1;
  int lenPaper;
  String tabName;
  String examCode;
  String userID;
  var answer_key;
  var questions;
  String myuser;
  double userScore=0.0;
  double userPer;
  var userScore1;
  int nright;
  int nwrong;
  int unatt;
  List<double> perlist;
  String pathImg;
  String pathVid;
  int qq;
  List<String> urlVid;
  List<String> urlImg;


  @override
  void initState() {
    setState(() {


      myuser = widget.userID;
      lenPaper = widget.lenPaper;
      String tabname = widget.tabname;
      examCode = widget.examCode;
      answer_key = List(lenPaper);
      getQuestionData(widget.tabname, widget.examCode);
      getUserData(widget.userID);
//      getSolution(lenPaper);


//      if(userAnswer!=null){
//        userScore = evaluateExam(userAnswer);
//        userScore1 = double.parse((userScore).toStringAsFixed(4));
//      }

      super.initState(); //todo EXTREMLY IMPORTANT
    });
  }

//  getSolution(int l) async {
//    for(int i=0; i< l; i++) {
//      String pathVid=getQuestionField(i, 'vid');
//      String pathImg=getQuestionField(i, 'img');
//      var ref1 = FirebaseStorage.instance.ref().child(pathVid);
//      var ref2 = FirebaseStorage.instance.ref().child(pathImg);
//      var url1 = await ref1.getDownloadURL();
//      var url2 = await ref2.getDownloadURL();
//
//      setState(() {
//        urlVid[i] = url1.toString();
//        urlImg[i] = url2.toString();
//
//      });
//      print("inside getVidUrl=> vidUrl: ${urlVid[i]}");
//      print("inside getVidUrl=> imgUrl: ${urlImg[i]}");
//
//    }
//  }



  Widget waitingClass(){
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircularProgressIndicator(
              backgroundColor: Colors.cyan,
              strokeWidth: 5,),
              Text('Loading Solution ...'),
            ],
          ),
        ],
      ),
    ),
  );}

  getUserData(String docNameUserID) async {
    print('starting my getUserData()');
    String fieldUserAns1 = '${widget.examCode.toString()}_ans';
    String fieldUserScore1= '${widget.examCode.toString()}_scores';
    var ans1;
    var scores1;
    Firestore.instance
        .collection('users')
        .document(docNameUserID)
        // ignore: non_constant_identifier_names
        .get()
        .then((DocumentSnapshot) {
      ans1 = DocumentSnapshot.data[fieldUserAns1];
      scores1 = DocumentSnapshot.data[fieldUserScore1];
      print('Field1 is $ans1');
      print('Field2 is $scores1');
      setState(() {
        userAnswer = List<int>.from(ans1);
        perlist = List<double>.from(scores1);
        print('storing user data...');
        print(userAnswer);
        print(perlist);
      });
    });

//    print(userAnswer);
//    return userAnswer;

  }


//  getAnsKey() {
//    for (int i = 0; i < lenPaper; i++) {
//      var tempa = getQuestionField(i, 'video');
//      print(tempa);
//    }
//    print('get ans key is done');
//  }

  getQuestionField(int a, String fieldName) {
    if (questions == null) {
      print(lenPaper);
      return null;
    } else
      return questions[a][fieldName];
  }

  getQuestionData(String tabName, String examcode) async {
    String path = '$tabName/$examcode/$examcode.json';
    print('Reading Quesiton data in $path');
    var ref = FirebaseStorage.instance.ref().child(path);
    var url = await ref.getDownloadURL();
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    setState(() {
      questions = jsonResponse;
      print('Question data read sucessfully');
    });
  }

//  getSolutionImage(int i) async {
////    String path = 'Part-1/eml11/101.png';
////    String path = getQuestionField(i, 'img').toString();
////    String path = path1;
////    var ref = FirebaseStorage.instance.ref().child(path);
////    var url1 = await ref.getDownloadURL();
////    print(path);
//    setState(() {
////      pathImg = url1;
//    pathImg = "https://firebasestorage.googleapis.com/v0/b/my-project-1-206bd.appspot.com/o/Part-1%2Feml11%2F101.png?alt=media&token=6fb4498e-61f1-42af-ac36-4a86c99f3c24";
//    });
//
////  return url.toString();
//  }

//  getSolutionVideo(int i) async {
////    String path = 'Part-1/eml11/101.mp4';
////    String path = getQuestionField(i, 'vid').toString();
////    String path = path2;
////    var ref = FirebaseStorage.instance.ref().child(path);
////    var url2 = await ref.getDownloadURL();
////    print(path);
//    setState(() {
////      pathVid = url2;
//      pathVid = "https://firebasestorage.googleapis.com/v0/b/my-project-1-206bd.appspot.com/o/Part-1%2Feml11%2F101.m4v?alt=media&token=13caf442-d1c9-4c85-b828-81de9241866a";
//    });
//  }

//  double evaluateExam(List scoreKeeper) {
//    print('From evaluateExam: $scoreKeeper');
//    double score = 0.0;
//    int cor=0;
//    int wrg=0;
//    int uat=0;
//    for (int i = 0; i < lenPaper; i++) {
//
//      if (scoreKeeper[i] == getQuestionField(i, 'ans'))
//      {
//        print(score);
//        print(scoreKeeper[i]);
//        print(getQuestionField(i, 'ans'));
//        score = score + 1.0; cor++;
//        print(score);
//      } else if (scoreKeeper[i]!= getQuestionField(i, 'ans') && scoreKeeper[i]!=0 && scoreKeeper[i]!=null)
//        {
//          score = score - 1 / 3;
//          wrg++;
//        }
//      else uat++;
//      setState(() {
//        nright = cor;
//        nwrong = wrg;
//        unatt = uat;
//      });
//    }
//    return score;
//  }

//  double getPercentage(double score){
//    var per1 = score/lenPaper*100;
//    return per1;
//  }

//  double getAveragePer(){
//    num sum = 0;
//    perlist.forEach((num e){sum += e;});
//    print(sum);
//    int l = perlist.length;
//    double avg = sum/l;
//    return avg;
//  }

//  Widget myimagewidget(){
//    return Image.network(pathImg, fit: BoxFit.scaleDown);
//  }

  
  
  
  @override
  Widget build(BuildContext context) {
    if (userAnswer == null || questions == null) {
      return waitingClass();
    }
    else
      {
      return Scaffold(
        appBar: AppBar(
            title: Row(
          children: <Widget>[
            Expanded(
                child: Container(child:
                Text(widget.examCode.toUpperCase())
//                    Text(examCode),
                )),
            Expanded(
                child: Container(
                    child: FlatButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Icon(
              Icons.home,
              color: Colors.white,
            ),
                    )))
          ],
        )),
        drawer: Container(
          height: 300.0,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              FlatButton(
                child: Icon(
                  Icons.refresh,
                  color: Colors.blue,
                ),
//                color: Colors.orange[100],
                onPressed: () {
                  print('refresh button is pressed');
                  setState(() {
//                    getUserData(widget.userID);
//                    print(userAnswer);
//                    userScore = evaluateExam(userAnswer);
                  });
                },
              ),
//              Text('user data'
//                  'UserID: $myuser \n'
//                  'ExamID: $examCode \n \n'
//              'lenPaper: $lenPaper'
//              'userAnswer: $userAnswer\n'
//                  ),
              Divider(),
              Text('Summary of ${examCode.toUpperCase()}'),
//            Image.network(pathImg, fit: BoxFit.scaleDown),

              Divider(),
              Text('Score: ${userScore.toStringAsFixed(2)} / $lenPaper \n'
//                  'Percentage: ${getPercentage(userScore).toStringAsFixed(2)} %\n'
                  'No.of Correct Ans: $nright\n'
                  'No.of Wrong Ans: $nwrong\n'
                  'Unattempted Questions: $unatt\n'
              ),
              Divider(),
              Text('No.of Attempts: ${perlist.length} \n'
//              'Average Score: ${getAveragePer().toStringAsFixed(2)}\n'
              ),
            ],
          ),
        ),
        body: ListView.builder(
            itemCount: lenPaper,
            itemBuilder: (BuildContext context, int index) {
              var qno = index + 1;
//              var userAnswer = [1, 2, 3, 4, 2, 0, null];
//              var userAnswer = getUserData(widget.userID);
//              var tempAns = userAnswer[index];

              Icon satusIcon(int a) {
                if (userAnswer[a] == 0 || userAnswer[a] == null) {
                  return Icon(
                    Icons.info,
                    color: Colors.orange[200],
                  );
                } else if (userAnswer[a] == getQuestionField(a, 'ans')) {
                  return Icon(
                    Icons.check,
                    color: Colors.green,
                  );
                } else if (userAnswer[a] != getQuestionField(a, 'ans')) {
                  return Icon(
                    Icons.close,
                    color: Colors.red,
                  );
                } else {
                  return Icon(
                    Icons.watch_later,
                    color: Colors.grey[300],
                  );
                }
              }

              return Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
//            height: 48.0,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Text('$qno '),
                        satusIcon(index),
                        Container(
                          color: Colors.blue[00],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Your Ans:     ${userAnswer[index]}'
                                    '\nCorrect Ans:${getQuestionField(index, 'ans')}'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: (){
                                    print(index);
                                    pathImg = getQuestionField(index, 'img');
                                    print(pathImg);
                                    Navigator.push(context,MaterialPageRoute(builder: (context) =>ShowImage(imgpath: pathImg,)));
//                                  print("index: $index \n PathImg: ${urlImg[index]}");
                                  },
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.blue,
                                  ),
                                ),
                                FlatButton(
                                  onPressed: (){
                                    print(index);
                                    pathVid = getQuestionField(index, "vid");
                                    print(pathVid);
//                                    print("Index: $index \n PathVideo: ${urlVid[index]}");
                                      Navigator.push(context,MaterialPageRoute(builder: (context) =>ShowVideo(vidurl: pathVid,)));
                                  },
                                  child: Icon(
                                    Icons.videocam,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
    }



  }




}

class ShowImage extends StatefulWidget {
  ShowImage(
      {@required this.imgpath});
  final String imgpath;

  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  String imgUrl;

  @override
  void initState() {
    print(widget.imgpath);
    setState(() {
      getImgUrl(widget.imgpath);
    });
    print(imgUrl);
  }

  getImgUrl(String path) async {
    var ref = FirebaseStorage.instance.ref().child(path);
    var url = await ref.getDownloadURL();
    setState(() {
    imgUrl = url.toString();
    });
  }

  Widget build(BuildContext context) {
    if (imgUrl==null) {return Scaffold(body: Center(child: CircularProgressIndicator()));}
    else {
    return SafeArea(
      child: Scaffold(
//      color: Colors.white,
        body:
//        Text('reading... from $imgpath'),
      PhotoView(
        imageProvider: NetworkImage(imgUrl),
      ),
      ),
    );}
  }
}

class ShowVideo extends StatefulWidget {
  ShowVideo(
      {@required this.vidurl});
  final String vidurl;

  @override
  _ShowVideoState createState() => _ShowVideoState();
}

class _ShowVideoState extends State<ShowVideo> {
  VideoPlayerController _controller;

  //todo: refer: https://medium.com/@zeyadelosherey/the-complete-webview-in-flutter-d562b40c3260

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller = VideoPlayerController.network(widget.vidurl)
        ..initialize().then((_) {
          setState(() {
          });
        }
        );
    });
  }


  @override
  Widget build(BuildContext context) {
    if (widget.vidurl==null){
      return Scaffold(body: Center(child: CircularProgressIndicator()));}
    return WillPopScope(
        onWillPop: () {
      if (_controller.value.isPlaying) {
        _controller.pause();
        Navigator.of(context).pop(false);
      }
      return new Future.value(true);
    },
    child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: _controller.value.initialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    ),


    );

  }
}



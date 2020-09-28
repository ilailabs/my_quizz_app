//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutterappusersignin/pages/home_page_reg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/scheduler.dart';
import 'package:floating_action_row/floating_action_row.dart';
import 'package:quiver/async.dart';
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';
import 'solutions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterappusersignin/pages/login_signup_page.dart';
import 'package:flutterappusersignin/services/authentication.dart';
import 'package:flutterappusersignin/pages/home_page_reg.dart';
import 'package:flutterappusersignin/pages/home_page_guest.dart';

//todo from Quizzler app
//QuizBrain quizBrain = QuizBrain();

class QuizPage extends StatefulWidget {
  QuizPage({@required this.userID, this.examCode, this.tabname, this.lenPaper});

  final String userID;
  final String examCode;
  final String tabname;
  final int lenPaper;


  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Quit!'),
            content: new Text(
              'Are you sure want to quit this page?'
//                'Please be Patient and contuine to test\n$_current Minutes Remaining to Complete to complete. Your test will be submited once the duration is completed, force quiting this page will auto submit your response. Are you sure want to quit?'
            ),
            actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Quit Now'),
          ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Continue'),
              ),
            ],
          ),
        )) ??
        false;
  }

  String userid;
  String examCode;
  String path;
  var questions;
  String tabName;
  int lenPaper;
  List<int> scoreKeeper;
  List<String> userConfidence;
  List<int> actualAnswer;
  List<String> myArray =['em11'];
  List<String> completedModules=[];
  List<double> perList=[];



  @override
  void initState() {
    setState(() {
//      print('Container1 ht: ${MediaQuery.of(context).size.height.toString()}');
      var screenMode = [SystemUiOverlay.bottom];
//      Future.delayed(Duration(milliseconds: 50));

//      startTheExamAlert(); //todo; once loading is done show alret...

      score = 0;
      userid = widget.userID;
      lenPaper = widget.lenPaper;
      if (userid!=null){getUserData(userid);}

//      lenPaper = 2;
      scoreKeeper = List(lenPaper);
      actualAnswer = List(lenPaper);
      examCode = widget.examCode;
      tabName = widget.tabname;
      userConfidence = List(lenPaper);
      getQuestionData(tabName, examCode);
      startTimer();

    });
  }

  getUserData(String docNameUserID) async {
    print('starting getUserData()');
    Firestore.instance
        .collection('users')
        .document(docNameUserID)
    // ignore: non_constant_identifier_names
        .get()
        .then((DocumentSnapshot) {
      var completedModules1 = DocumentSnapshot.data["completed"];
      var perList1 = DocumentSnapshot.data["${examCode.toString()}_scores"];
//

      print('Field is $completedModules1');
      print('field2 is $perList1');
      setState(() {
        if (completedModules1==null){ completedModules =[''];} else
          completedModules =List<String>.from(completedModules1);
      });
      setState(() {
        if (perList1==null){ perList1 =[0.0];} else
          {perList=List<double>.from(perList1);}

      });

    });

  }

  String getQuestionText(int a) {
    if (questions == null) {
      print('Loading question paepr...');
      print(lenPaper);
//      CircularProgressIndicator();
      return 'Loading...';
    } else
      return questions[a]['question'].toString();
  }

  int getCorrectAnswerfor(int a) {
    if (questions == null) {
      print(lenPaper);
      return null;
    } else
      return questions[a]['ans'];
  }

  String getChoice1Text(int a) {
    if (questions == null) {
      return '';
    } else
      return questions[a]['c1'].toString();
  }

  String getChoice2Text(int a) {
    if (questions == null) {
      return '';
    } else
      return questions[a]['c2'].toString();
  }

  String getChoice3Text(int a) {
    if (questions == null) {
      return '';
    } else
      return questions[a]['c3'].toString();
  }

  String getChoice4Text(int a) {
    if (questions == null) {
      return '';
    } else
      return questions[a]['c4'].toString();
  }

  int questionNumber = 0;
  int actualQno = 1;
  int correctAnswer;
  int colorChoice1, colorChoice2, colorChoice3, colorChoice4;
  int userAnswer;
  double score = 0.0;
  double per;

  getQuestionData(String tabName, String examcode) async {
    String path = '$tabName/$examcode/$examcode.json';
    var ref = FirebaseStorage.instance.ref().child(path);
    var url = await ref.getDownloadURL();
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    setState(() {
      questions = jsonResponse;
      print('Question data read sucessfully');
    });
  }



  getActualAnswer() {
    double score = 0.0;
    for (int i = 0; i < lenPaper; i++) {
      actualAnswer[i] = getCorrectAnswerfor(i);
    }
    setState(() {
      actualAnswer;
    });
  }

  double evaluateExam(List actualAnswer, List scoreKeeper) {
    double score = 0.0;
    for (int i = 0; i < lenPaper; i++) {
      if (actualAnswer[i] == scoreKeeper[i]) {
        score = score + 1.0;
      } else if (actualAnswer[i] != scoreKeeper[i] &&
          scoreKeeper[i] != 0 &&
          scoreKeeper[i] != null) score = score - 1 / 3;
    }
    return score;
  }

  double getPercentage(double score, int lenPaper) {
    double tvar;
    tvar = score / lenPaper * 100;
    return tvar;
  }

  void getAnyData(String tabName, String docName) {
    String fieldName = 'path';
    String field;
    Firestore.instance
        .collection(tabName)
        .document(docName)
        // ignore: non_constant_identifier_names
        .get()
        .then((DocumentSnapshot) {
      field = DocumentSnapshot.data[fieldName].toString();
      print('From getAnyData $field');
      setState(() {
        path = field.toString();
      });
    });
  }

  void uploadExamScore() {
    getActualAnswer();
    score = evaluateExam(actualAnswer, scoreKeeper);
    per = getPercentage(score, lenPaper);

var map = Map();
completedModules.forEach((x) => map[x] = !map.containsKey(x) ? (1) : (map[x] + 1));

    if(!map.containsKey(examCode))
    {
      setState(() {
        completedModules.add(examCode);
        perList.add(per);
      });

      Firestore.instance.collection("users").document(userid).updateData({

        examCode.toString() + "_ans": scoreKeeper,
      examCode.toString() + "_scores": perList,
        "completed": completedModules,

      }).then((result) => {print('uploaded... exam score!')});

      setState(() {
        analyseScoreKeeper(); //Just for summary
      });
    }
    else {
      setState(() {
        perList.add(per);
      });
      Firestore.instance.collection("users").document(userid).updateData({
        examCode.toString() + "_scores": perList, //TODO ADD SCORE TO LIST

      }).then((result) => {print('uploaded... exam score!')});
    }

  }

  int nUnattended;
  int nRightAns;
  int nWrongAns;

  analyseScoreKeeper() {
    getActualAnswer();
    int a, b, c;
    a = 0;
    b = 0;
    c = 0;
    for (int i = 0; i < lenPaper; i++) {
      if (scoreKeeper[i] == 0 || scoreKeeper[i] == null) {
        c++;
      } else if (scoreKeeper[i] == actualAnswer[i]) {
        b++;
      } else
        a++;

      setState(() {
        nRightAns = b;
        nWrongAns = a;
        nUnattended = c;
      });
    }
  }

  void sucessfullySubmitedAlert() {
    Alert(
      context: context,
      type: AlertType.success,
      title: 'Completed Sucessfully!',
      desc:
          'Your score is $perInt % \nCorrect Answers: $nRightAns \n Wrong Answers: $nWrongAns \n Unattempted: $nUnattended \n',
      buttons: [
        DialogButton(
          child: Text(
            "Continue",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          }, //todo naviage to solution page
          width: 120,
        ),
//        DialogButton(
//          child: Text(
//            "Solutions",
//            style: TextStyle(color: Colors.white, fontSize: 20),
//          ),
//          onPressed: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => SolutionsPage()),
//            );
//          }, //todo naviage to solution page
//          width: 120,
//        )
      ],
    ).show();
  }

  int notAnswered() {
    int counter = 0;
    for (var i = 0; i < lenPaper; i++) {
      if (scoreKeeper[i] == 0 || scoreKeeper[i] == null) {
        counter++;
      }
    }

    return counter;
  }

  int noofAns() {
    int temp = lenPaper - notAnswered();
    return temp;
  }

  void nextQuestion() {
    setState(() {
      if (questionNumber >= lenPaper - 1) {
        Alert(
          context: context,
          type: AlertType.info,
          title: 'Review!',
          desc:
              'Answered: ${noofAns()} \nUnanswered: ${notAnswered()} \nPlease review the test $_current minutes still remaining',
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
if(changesObserved){scoreKeeper[questionNumber] = userAnswer;}
         //todo only ture if changes observed;
//        actualAnswer[questionNumber]=getCorrectAnswerfor(questionNumber);
//        userConfidence[questionNumber] =  //todo; EDIT THIS LINE
        questionNumber = 0;
        actualQno = 1;
        isAnswerd(questionNumber);
      } else {
        setState(() {
          questionNumber++;
//          actualAnswer[questionNumber]=getCorrectAnswerfor(questionNumber);
          actualQno++;
          isAnswerd(questionNumber);
        });
      }
    });
  }

  void clearResponse() {
    setState(() {
      colorChoice1 = 0;
      colorChoice2 = 0;
      colorChoice3 = 0;
      colorChoice4 = 0;
    });
  }

  void markAnswer(int userAnswer) {
//    correctAnswer = quizBrain.questionBank[questionNumber].questionAnswers; //todo: Get correct answer from here;
    setState(
      () {
        if (questionNumber > lenPaper - 1) {
          Alert(
            context: context,
            title: 'Completed!',
            desc:
                'Please REVIEW before submitting', //todo; it must have two button; review and submit;
          ).show();

          scoreKeeper[questionNumber] = userAnswer;
//          userConfidence[questionNumber] =  //todo; update this one
          userAnswer = 0;
          questionNumber = 0;
          actualQno = 1;
        } else {
          scoreKeeper[questionNumber] = userAnswer;
//          userConfidence[questionNumber] = todo  update
          userAnswer = 0;
        }
      },
    );
    print('Q.No = $actualQno');
    print('user ans = $userAnswer');
    print('Saved Response = $scoreKeeper');
  }

  double progBar(int actualQuestionNumber) {
    double progBar1;
    progBar1 = actualQuestionNumber / lenPaper;
    return progBar1;
  }

  void buttonPressed(int userAnswer) {
    if (userAnswer == 1) {
      clearResponse();
      colorChoice1 = 100;
    } else if (userAnswer == 2) {
      clearResponse();
      colorChoice2 = 100;
    } else if (userAnswer == 3) {
      clearResponse();
      colorChoice3 = 100;
    } else if (userAnswer == 4) {
      clearResponse();
      colorChoice4 = 100;
    }
  }

  void isAnswerd(int a) {
    int b = scoreKeeper[a];
    if (b == null) {
      print('nothing is answered');
      clearResponse();
    } else if (b == 0) {
      print('nothing is answered');
      clearResponse();
    } else if (b == 1) {
      setState(() {
        scoreKeeper[a] = b;
        colorChoice1 = 100;
        colorChoice2 = 0;
        colorChoice3 = 0;
        colorChoice4 = 0;
      });
    } else if (b == 2) {
      setState(() {
        scoreKeeper[a] = b;
        colorChoice1 = 0;
        colorChoice2 = 100;
        colorChoice3 = 0;
        colorChoice4 = 0;
      });
    } else if (b == 3) {
      setState(() {
        scoreKeeper[a] = b;
        colorChoice1 = 0;
        colorChoice2 = 0;
        colorChoice3 = 100;
        colorChoice4 = 0;
      });
    } else if (b == 4) {
      setState(() {
        scoreKeeper[a] = b;
        colorChoice1 = 0;
        colorChoice2 = 0;
        colorChoice3 = 0;
        colorChoice4 = 100;
      });
    }
  }

  bool changesObserved;
  double examScore = 23.3;
  List<int> userResponse = [];
  int examTime(int lenPaper) {
    double timeexam = lenPaper * 1.2;
    return timeexam.round();
  }

  int _current = 0;
  Color timmerColor;
  int perInt;
  void startTimer() {
//    int start = examTime(lenPaper); //todo: MARK ONCE APP IS COMPLETED
  int start = 1;
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(minutes: start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = start - duration.elapsed.inMinutes;
      });

      if (_current <= 3) {
        setState(() {
          timmerColor = Colors.red;
        });
      }

      if (_current == 0) {
        uploadExamScore();
        score = evaluateExam(actualAnswer, scoreKeeper);
        per = getPercentage(score, lenPaper);
        perInt = per.round();
        analyseScoreKeeper();
        print('Exam submitted successfully');
        sucessfullySubmitedAlert();
      }
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom]); //FULL SCREEN MODE
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: Drawer(
          child: GridView.builder(
              itemCount: lenPaper,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
              itemBuilder: (BuildContext context, int index) {
                var qno = index + 1;
//                List<Icon> qicons = List(lenPaper);
                Color cardcolor(int a) {
                  if (scoreKeeper[a] == 0) {
                    return Colors.red[200];
                  } else if (scoreKeeper[a] == null) {
                    return Colors.grey[300];
                  } else
                    return Colors.white;
                }

                Icon satusIcon(int a) {
                  if (scoreKeeper[a] == 0 || scoreKeeper[a] == null) {
                    if (userConfidence[a] == 'r') {
                      return Icon(
                        Icons.info,
                        color: Colors.purple,
                      );
                    } else
                      return Icon(
                        Icons.info,
                        color: Colors.grey[500],
                      );
                  } else if (userConfidence[a] == 's')
                    return Icon(
                      Icons.check,
                      color: Colors.green,
                    );
                  else if (userConfidence[a] == 'r')
                    return Icon(Icons.check, color: Colors.purple);
                }

                return GestureDetector(
                  child: Card(
                    elevation: 5.0,
                    child: Container(
                      height: 5.0,
                      width: 10.0,
                      color: cardcolor(index),
                      child: Column(
                        children: <Widget>[
                          Text('$qno'),
                          satusIcon(index),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    questionNumber = index;
                    Navigator.of(context).pop();
                  },
                );
              }),

//          showDialog(
//            barrierDismissible: false,
//            context: context,
//            child: new CupertinoAlertDialog(
//              title: new Column(
//                children: <Widget>[
//                  new Text("GridView"),
//                  new Icon(
//                    Icons.favorite,
//                    color: Colors.green,
//                  ),
//                ],
//              ),
//              content: new Text("Selected Item $index"),
//              actions: <Widget>[
//                new FlatButton(
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    },
//                    child: new Text("OK"))
//              ],
//            ),
//          );
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.blue[0],
                          child: Text(
                            'Q. No: $actualQno / $lenPaper ',
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            color: Colors.blue[0],
                            child: Text(
                              "$_current min",
                              style: TextStyle(color: timmerColor),
                              textAlign: TextAlign.right,
                            )),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
//                            startTimer();
//                          startTheExamAlert();
                        },
                        child: Text("start the exam "),
                      ),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getQuestionText(questionNumber),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  FlatButton(
                      child: Text('getActualAnswer & uploadExamScore'),
                      color: Colors.orange[200],
                      onPressed: () {
//                        completedModules.add(examCode);
//
//                        var elements = ["a", "b", "c", "d", "e", "a", "b", "c", "f", "g", "h", "h", "h", "e"];
//                        var map = Map();
//
//                        elements.forEach((x) => map[x] = !map.containsKey(x) ? (1) : (map[x] + 1));
//
//                        print(map);
//                        print(map.containsKey('x'));
//                        print(map['a']);
                        uploadExamScore();

                      }),
                  FlatButton(
                    onPressed: uploadExamScore,
                    child: Container(
                      width: double.infinity,
                      color: Colors.orange[300],
                      child: Text(
//                    'QuizCode: ${widget.examCode} \n User Id: ${widget.userid} \n Exam Score: $examScore \nQuestion: $questions'),

                          'userId: $userid \nexamCode: $examCode \n UserAnswer: $userAnswer \n ScoreKeeper: $scoreKeeper \n userConfidence: $userConfidence \n actualAnswer: $actualAnswer  \n SCORE: $score \n '
                          'Your response has been recorded. Your score is ${getPercentage(score, lenPaper)} % \nCorrect Answers: $nRightAns \n Wrong Answers: $nWrongAns \n Unattempted: $nUnattended \n'
                          'completedModules = $completedModules examScores = $perList'
//                          'Percent: $per \n T.cont_read: $myChildSizeHt Q.Ht_actual: $qContainer QHt_modified: $qContainer_temp A.cont: $aContainer `'
                          ''),

//                                Orientation: ${MediaQuery.of(context).orientation} Height of container: ${MediaQuery.of(context).size.height.toString()}
                    ),
                  ),
                  FlatButton(
                    color: Colors.teal[100],
                    child: Text('update ht variables'),
                    onPressed: () {
                      setState(() {
                        analyseScoreKeeper();
                        print('analyse score keeper');
//                                updateContainer();

//                                aContainer = myChildSizeAns.height;
//                                qContainer = myChildSizeQue.height;
//                                myChildSizeHt = qContainer + aContainer;
//
//                                if (myChildSizeHt < MediaQuery.of(context).size.height) {
//                                  qContainer = MediaQuery.of(context).size.height - aContainer;
//                                }

//                    print(qContainer.toString());
//                                aContainer = myChildSizeAns.height;
//                                qContainer = myChildSizeQue.height;
//                                myChildSizeHt = qContainer + aContainer;
//
//                                if (myChildSizeHt < MediaQuery.of(context).size.height) {
//                                  qContainer = MediaQuery.of(context).size.height - aContainer;
//                                }
                      });
                    },
                  ),
                  Divider(),
                  FlatButton(
                    color: Colors.blue[colorChoice1],
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(getChoice1Text(questionNumber))),
                    onPressed: () {
                      userAnswer = 1;
                      buttonPressed(userAnswer);
                      setState(() {
                        changesObserved = true;
                        print('user choice is $userAnswer');
                      });
//                clickedAnswer(1);
                    },
                  ),
                  FlatButton(
                    color: Colors.blue[colorChoice2],
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(getChoice2Text(questionNumber))),
                    onPressed: () {
                      userAnswer = 2;
                      buttonPressed(userAnswer);
                      setState(() {
                        changesObserved = true;
                        print('user choice is $userAnswer');
                      });
                    },
                  ),
                  FlatButton(
                    color: Colors.blue[colorChoice3],
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(getChoice3Text(questionNumber))),
                    onPressed: () {
                      userAnswer = 3;
                      buttonPressed(userAnswer);
                      setState(() {
                        changesObserved = true;
                        print('user choice is $userAnswer');
                      });
                    },
                  ),
                  FlatButton(
                    color: Colors.blue[colorChoice4],
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(getChoice4Text(questionNumber))),
                    onPressed: () {
                      userAnswer = 4;
                      buttonPressed(userAnswer);
                      setState(() {
                        changesObserved = true;
                        print('user choice is $userAnswer');
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FlatButton(
                        child: Text('REVIEW',
                            style: TextStyle(color: Colors.white)),
                        color: Colors.blue[800],
                        onPressed: () {
                          setState(() {
                            if (changesObserved == true) {
                              markAnswer(userAnswer);
                              print('yes changes observed & REVIEWED');
                              userConfidence[questionNumber] = 'r';
                            } else {
                              print('no changes observed and skipped changes');
                              userConfidence[questionNumber] = 'r';
                            }
                          });
                          nextQuestion();
                          changesObserved = false;
                          print(scoreKeeper);
//                                  print(userConfidence);
                        }),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FlatButton(
                      child:
                          Text('CLEAR', style: TextStyle(color: Colors.white)),
                      color: Colors.blue[800],
                      onPressed: () {
                        setState(() {
                          clearResponse();
                          userAnswer = 0;
                          scoreKeeper[questionNumber] = userAnswer;
                        });
                        print(scoreKeeper);
//                                print(userConfidence);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FlatButton(
                      child:
                          Text('SKIP', style: TextStyle(color: Colors.white)),
                      color: Colors.blue[800],
                      onPressed: () {
//                        markAnswer(0);
                        nextQuestion();
                        print(scoreKeeper);
//                                print(userConfidence);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FlatButton(
                      child:
                          Text('SAVE', style: TextStyle(color: Colors.white)),
                      color: Colors.blue[800],
                      onPressed: () {
                        setState(() {
                          if (changesObserved == true) {
                            markAnswer(userAnswer);
                            print('yes changes observed & SAVED');
                            userConfidence[questionNumber] = 's';
                          } else {
                            print('no changes observed and skipped changes');
                            userAnswer = 0;
                          }
                        });

                        nextQuestion();
                        changesObserved = false;
                        print(scoreKeeper);
//                                print(userConfidence);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),

//      ],
      ),
    );
//        ));
  }
}

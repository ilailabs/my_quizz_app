containerHeight() {
  if (myChildSize.height < MediaQuery.of(context).size.height) {
//    return MediaQuery.of(context).size.height;
//    return null;
    var bb = MediaQuery.of(context).size.height;
    return bb;
  }
//    else if (myChildSize.height > MediaQuery.of(context).size.height){
//      var aa = MediaQuery.of(context).size.height - 100.0;
//      return aa;
//    }
}


var qContainer;
var aContainer;
var myChildSizeHt;
var myChildSize = Size.zero;
var myChildSizeAns = Size.zero;
var myChildSizeQue = Size.zero;
var tContainer;
var qContainer_temp;
var mediaHeight;


//
//
//  setState( () {
//  aContainer = myChildSizeAns.height;
//  qContainer = myChildSizeQue.height;
//  myChildSizeHt = qContainer + aContainer;
//
//  @override
//  void setState(fn) {
//    if (myChildSizeHt < MediaQuery.of(context).size.height) {
//      qContainer = MediaQuery.of(context).size.height - aContainer;
//    super.setState(fn);
//  }
//
//  }

//  }
//  );



//  var qContainer = 337.0;
var time=1000.0;

@override
Widget build(BuildContext context) {
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]); //FULL SCREEN MODE
  aContainer = myChildSizeAns.height;
  qContainer = myChildSizeQue.height;
  tContainer = myChildSize.height;
  mediaHeight = MediaQuery.of(context).size.height;
  myChildSizeHt = qContainer + aContainer;

//    qContainer_temp = qContainer;
  //AVAOID OVERFLOW OF TEXT;
//        setState(() {
//
//          if(myChildSizeHt < MediaQuery.of(context).size.height){
//        qContainer_temp = MediaQuery.of(context).size.height-aContainer;}
//          else {qContainer = null;}
//        }



//    setState(() {
//      if (myChildSizeHt < MediaQuery.of(context).size.height) {
//        qContainer = MediaQuery.of(context).size.height - aContainer;}
//});

  if(true){
    time--;
    print(time);
  }

  setState(() {
    if(myChildSizeHt < MediaQuery.of(context).size.height){
      qContainer_temp = MediaQuery.of(context).size.height - aContainer;
    }
  });




  //CHECK PIXEL OVERLAY AND EDIT CONTAINER SIZE;
  return Scaffold(
    body: SingleChildScrollView(
      child: MeasureSize(
        onChange: (size) {
          setState(() {
            myChildSize = size;
          });
        },
        child: Column(
          children: <Widget>[
            Container(
//                height: qContainer_temp,
              width: double.infinity,
              color: Colors.blue[100],
              child: MeasureSize(
                onChange: (sizeque) {
                  setState(() {
                    myChildSizeQue = sizeque;
                  });
                },
                child: Container(
//                      height: 300.0,
                  color: Colors.orange[100],
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            color: Colors.blue[0],
                            child: Text(
                              'Q. No: $actualQno / $lenPaper ',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                              color: Colors.blue[0],
                              child: Text(
                                '02:12',
                                textAlign: TextAlign.right,
                              ))
                        ],
                      ),
                      Container(
                          width: double.infinity,
                          color: Colors.teal[100],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(getQuestionText(questionNumber)),
                          )),
                      FlatButton(
                          child: Text('uploadexam'),
                          color: Colors.orange[200],
                          onPressed: () {
                            getActualAnswer();
                            score = evaluateExam(actualAnswer, scoreKeeper);
                            per = getPercentage(score, lenPaper);
                          }),
                      FlatButton(
                        onPressed: uploadExamScore,
                        child: Container(
                          width: double.infinity,
                          color: Colors.orange[300],
                          child: Text(
//                    'QuizCode: ${widget.examCode} \n User Id: ${widget.userid} \n Exam Score: $examScore \nQuestion: $questions'),

                              'userId: $userid \nexamCode: $examCode \n ScoreKeeper: $scoreKeeper \n userConfidence: $userConfidence \n actualAnswer: $actualAnswer  \n SCORE: $score \n '
                                  'Percent: $per \n T.cont_read: $myChildSizeHt Q.Ht_actual: $qContainer QHt_modified: $qContainer_temp A.cont: $aContainer `'),

//                                Orientation: ${MediaQuery.of(context).orientation} Height of container: ${MediaQuery.of(context).size.height.toString()}
                        ),
                      ),
                      FlatButton(
                        color: Colors.teal[100],
                        child: Text('update ht variables'),
                        onPressed: (){
                          setState(() {
                            qContainer_temp = qContainer;

                            print('Update Container!!!');
//                                updateContainer();


//                                aContainer = myChildSizeAns.height;
//                                qContainer = myChildSizeQue.height;
//                                myChildSizeHt = qContainer + aContainer;
//
//                                if (myChildSizeHt < MediaQuery.of(context).size.height) {
//                                  qContainer = MediaQuery.of(context).size.height - aContainer;
//                                }



                            print(qContainer.toString());
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
                    ],
                  ),
                ),


              ),

//                Text(
//                    'HtWholeC:${myChildSizeHt} \n HtCont1: $qContainer \n HtCont2: $aContainer'),

            ),
            Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: Colors.teal[100],
                  child: MeasureSize(
                    onChange: (sizeq) {
                      setState(() {
                        myChildSizeAns = sizeq;
                      });
                    },
                    child: Column(
                      children: <Widget>[
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
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: FlatButton(
                                    child: Text('REVIEW',
                                        style:
                                        TextStyle(color: Colors.white)),
                                    color: Colors.blue[800],
                                    onPressed: () {
                                      setState(() {
                                        if (changesObserved == true) {
                                          markAnswer(userAnswer);
                                          print(
                                              'yes changes observed & REVIEWED');
                                          userConfidence[questionNumber] =
                                          'r';
                                        } else {
                                          print(
                                              'no changes observed and skipped changes');
                                        }
                                      });
                                      nextQuestion();
                                      changesObserved = false;
                                      print(scoreKeeper);
//                                  print(userConfidence);
                                    }
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: FlatButton(
                                  child: Text('CLEAR',
                                      style: TextStyle(color: Colors.white)),
                                  color: Colors.blue[800],
                                  onPressed: () {
                                    setState(() {
                                      clearResponse();
                                      userAnswer = 0;
                                      scoreKeeper[questionNumber] =
                                          userAnswer;
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
                                  child: Text('SKIP',
                                      style: TextStyle(color: Colors.white)),
                                  color: Colors.blue[800],
                                  onPressed: () {
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
                                  child: Text('SAVE',
                                      style: TextStyle(color: Colors.white)),
                                  color: Colors.blue[800],
                                  onPressed: () {
                                    setState(() {
                                      if (changesObserved == true) {
                                        markAnswer(userAnswer);
                                        print('yes changes observed & SAVED');
                                        userConfidence[questionNumber] = 's';
                                      } else {
                                        print(
                                            'no changes observed and skipped changes');
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
}


typedef void OnWidgetSizeChange(Size size);

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key key,
    @required this.onChange,
    @required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}

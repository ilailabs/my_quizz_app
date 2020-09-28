import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterappusersignin/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'custom_card_builder.dart';
import 'edit_user_profile.dart';
import 'package:flutterappusersignin/services/authentication.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



class HomePageSubscribedUser extends StatefulWidget {
  HomePageSubscribedUser({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

//  final dataRefObj = Firestore.instance;

  @override
  State<StatefulWidget> createState() => new _HomePageSubscribedUserState();
}

class _HomePageSubscribedUserState extends State<HomePageSubscribedUser> {

  //Instance of database is stored here;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //todo: input from user
  TextEditingController firstNameInputController;

  bool isGuestUser;
  String userID,userEmail;
  String userCore;
  String userCoreSubject="Part-3-civil";

  get logoutCallback => null;

//  String userCoreSubject(){return 'Part-3-$userCore';}

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  List<String> completedModules=[];


  @override
  void initState() {
    super.initState();
    //todo: input from user;
    firstNameInputController = new TextEditingController();

    widget.auth.getCurrentUser().then((user) {
      setState(() {
        userID = user.uid;
        if (userID!=null){getUserData(userID);}
//      completedModules=[];
//      'em11','be11'
        isGuestUser = user.isAnonymous;
        userEmail = user.email;
//        double userProgress = userProgressFunction(userModuleTime, moduleTime);
      });
    });
    super.initState(); //todo
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
      String userCore1 = DocumentSnapshot.data["userCore"];
      print('Field is $completedModules1');
      setState(() {
        if (completedModules1==null){ completedModules =[''];} else
        completedModules =List<String>.from(completedModules1);


      });
      setState(() {
        userCore = userCore1;
        userCoreSubject = "Part-3-$userCore";
      });

    });

}


  //TO SUBMIT ONCE//
  String userName;
  String userPhone = '';
//  String userCore = 'civil';

  //TO CALCULATE//
  int userModuleLength = 23; //todo; retrive from database;
  double userModuleTime = 123;
  int userRank = 4;
  double userAverage = 33.4;
  double userProgress = 23.4;

  //REFERANCE VALUES DEFALUT:
  int totalModuleLength = 32; //todo: CALCULATE FROM DATABASE;
  double totalModuleTime = 232.5; //TODO: CALCULATE FROM DATABASE;

  List<String> userCompletedModules = ['eml11','eml12','eml14','emn11','emn12'];


  String userName2Display() {
    if(userEmail != null){
    var stringListTemp = userEmail.split('@');
    return stringListTemp[0];}
    else {return 'Subscribed User';}
  }

  double userProgressFunction(double userModuleTime, double moduleTime) {
    double time;
//    time = userModuleTime/moduleTime;
    return 12.2;
  }

  String get userDetails {
    return           'isGuest: $isGuestUser \n'
        'userID: $userID \n'
        'userEmail: $userEmail\n'
        '----------------------------------------\n'

        'UserName: $userName \n' //todo: DISPLAY THIS ON TOP OF APP BAR;
        'userPhone: $userPhone\n' //TODO: LINK SAYING JOIN WHATSAPP STUDY GROUP FOR DISCUSSIONS AND DOUBTS;
        'userCore: $userCore \n'
        '-----------------------------------------\n'

        'userRank: $userRank\n'
        'userAverage: $userAverage\n'
        'userExamTime: $userModuleTime\n'
        'userProgress: $userProgress\n' //TODO: DISPLAY AS PROGRESS BAR;
//        'modulesCompleted: $userCompletedModules\n'
    'completedModules: $completedModules\n'
    ;
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Container(child: FlatButton(child: Text(userName2Display(), style: TextStyle(color: Colors.white,  fontSize: 18),), onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditUserProfile(
                                userId: userID,
                                auth: widget.auth,
                                logoutCallback: logoutCallback
                            )));      },)),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onPressed: () {
                          print('alert is pressed');
                          setState(() {


                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Sign Out",
                              desc: "Are you sure want to sign out?",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    signOut();
                                    Navigator.pop(context);
                                  },
                                  color: Color.fromRGBO(0, 179, 134, 1.0),
                                ),
                                DialogButton(
                                  child: Text(
                                    "No",
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



                          });
                           //todo: show dialog and then sigh out;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Part-1',
              ),
              Tab(
                text: 'Part-2',
              ),
              Tab(
                text: 'Part-3',
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TabBarView(
            children: [
              SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
//                      Container(
////                        height: 200.0,
//                        width: double.infinity,
//                        color: Colors.teal[100],
//                        child: Column(
//                          children: <Widget>[
//                            Text(userDetails),
//                            Form(
//                              key: formKey,
//                              child: Column(
//                                children: <Widget>[
//                                  TextFormField(decoration: InputDecoration(labelText: 'Name', hintText: "Elango"),controller: firstNameInputController,validator: (value) {if (value.length < 3) { return "Pleae input name field grater than four charecters";}},),
////                                  TextFormField(decoration: InputDecoration(labelText: 'Mobile', hintText: "Elango"),controller: MobileNumber,validator: (value) {if (value.length < 10) { return "Pleae input correct mobile number";}},),
//
//                                  RaisedButton(
//                                    child: Text('getUserData'),
//                                    onPressed: (){
////                                      var temp1 = getUserData(userID);
////                                      print(temp1);
//                                    }
//                                  ),
//                                  RaisedButton(
//                                    child: Text('Register'),
//                                    onPressed: (){
//                                      Firestore.instance
//                                          .collection("users")
//                                          .document(userID)
//                                          .updateData({
//                                        "uid": userID,
//                                        "isGuest": isGuestUser,
//                                        "userEmail": userEmail,
//                                        "name": firstNameInputController.text,
//
//                                      }
//                                      )
//                                          .then((result) =>{
//                                            print('some task is done; user name is ${firstNameInputController.text}')
//                                      });
//                                    },
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
                      buildMyList( 'Part-1', isGuestUser, userID, completedModules),
                    ],
                  )),
              SingleChildScrollView(
                  child: buildMyList('Part-2', isGuestUser, userID, completedModules)),
              SingleChildScrollView(
                  child: buildMyList(userCoreSubject, isGuestUser,userID, completedModules)),
            ],
          ),
        ),

      ),
    );
  }



}





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterappusersignin/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'custom_card_builder.dart';
import 'edit_user_profile.dart';
import 'package:flutterappusersignin/services/authentication.dart';


class EditUserProfile extends StatefulWidget {
  EditUserProfile({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

//  final dataRefObj = Firestore.instance;

  @override
  State<StatefulWidget> createState() => new _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {

  //Instance of database is stored here;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //todo: input from user
  TextEditingController firstNameInputController;
  TextEditingController userPhoneInputController;
  TextEditingController userCoreInputController;
  TextEditingController userFeedBackInputController;

  bool isGuestUser;
  String userID,userEmail;

  String userName;
  String userPhone;
  String userCore;
  List<String> userCompletedModules;

  get logoutCallback => null;

  String userCoreSubject(){return 'Part-3-$userCore';}


//  signOut() async {
//    try {
//      await widget.auth.signOut();
//      widget.logoutCallback();
////    getDat();
//    } catch (e) {
//      print(e);
//    }
//  }

  getUserData(String docNameUserID) async {
    print('starting getUserData()');
    String fName = "userName";
    String fPhone = "userPhone";
    String fCore = "userCore";
    Firestore.instance
        .collection('users')
        .document(docNameUserID)
    // ignore: non_constant_identifier_names
        .get()
        .then((DocumentSnapshot) {
      userName = DocumentSnapshot.data[fName];
      print("from getUserData: $userName");
      userPhone = DocumentSnapshot.data[fPhone];
      userCore = DocumentSnapshot.data[fCore];


//      userCompletedModules= DocumentSnapshot.data["completed"];
//      print(userCompletedModules);
    });




  }




  @override
  void initState() {
    super.initState();
    //todo: input from user;
    firstNameInputController = TextEditingController();
    userPhoneInputController = TextEditingController();
    userCoreInputController = TextEditingController();
    userFeedBackInputController = TextEditingController();


    widget.auth.getCurrentUser().then((user) {
      setState(() {
        isGuestUser = user.isAnonymous;
        userID = user.uid;
        userEmail = user.email;
//        double userProgress = userProgressFunction(userModuleTime, moduleTime);


      });
    });
    getUserData(widget.userId);
    super.initState(); //todo
  }

  //TO SUBMIT ONCE//


  //TO CALCULATE//
  int userModuleLength = 23; //todo; retrive from database;
  double userModuleTime = 123;
  int userRank = 4;
  double userAverage = 33.4;
  double userProgress = 23.4;

  //REFERANCE VALUES DEFALUT:
  int totalModuleLength = 32; //todo: CALCULATE FROM DATABASE;
  double totalModuleTime = 232.5; //TODO: CALCULATE FROM DATABASE;


  String userName2Display() {

      var stringListTemp = userEmail;
        return stringListTemp[0];
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
        'modulesCompleted: $userCompletedModules\n'
    ;
//TODO: DISPLAY THE COMPLETED TEST NO OF ATTEMPTS; BEST SCORE AVERAGE ALL DETAILS
//    //  print(map.containsKey('x'));
//    var elements = ["a", "b", "c", "d", "e", "a", "b", "c", "f", "g", "h", "h", "h", "e"];
////  var map = Map();
//
////  elements.forEach((x) => map[x] = !map.containsKey(x) ? (1) : (map[x] + 1));
//    var map = Map();
//    completedModules.forEach((x) => map[x] = !map.containsKey(x) ? (1) : (map[x] + 1));
  }


  String userType(isGuestUser){
    if(isGuestUser) return "Guest User"; return "Subscribed User";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("$userName", textAlign: TextAlign.right,),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                tooltip: 'Add new entry',
                onPressed: () {},
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
//                Container(color: Colors.teal, height: 200.0,),
//                Text(userDetails),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.verified_user
                        ),
                        Text("${userType(isGuestUser)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.account_circle
                        ),
                        Text("$userName", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.email
                        ),
                        Text("$userEmail", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                            Icons.phone
                        ),
                        Text("$userPhone", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                            Icons.library_books
                        ),
                        Text("$userCore", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ],
                    ),
                  ],
                ),
                Divider(),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(decoration: InputDecoration(labelText: 'Name', hintText: "$userName" ),controller: firstNameInputController,validator: (value) {if (value.length < 3) { return "Pleae enter correct input";}},),
                      TextFormField(decoration: InputDecoration(labelText: 'Phone', hintText: userPhone ),controller: userPhoneInputController,validator: (value) {if (value.length < 3) { return "Pleae enter correct input";}},),
                      TextFormField(decoration: InputDecoration(labelText: 'Core-Subject*', hintText: "eee/civil/mech" ),controller: userCoreInputController,validator: (value) {if (value.length < 3) { return "Pleae enter correct input";}},),
                      TextFormField(decoration: InputDecoration(labelText: 'Feedback', hintText: "Good, but need improvement in ..." ),controller: userFeedBackInputController,validator: (value) {if (value.length < 3) { return "Pleae enter correct input";}},),
                      RaisedButton(
                        child: Text('Edit'), //todo: here alter dialog, changes made sucessfully;
                        onPressed: (){
                          Firestore.instance
                              .collection("users")
                              .document(userID)
                              .setData({
                            "uid": userID,
                            "isGuest": isGuestUser,
                            "userEmail": userEmail,
                            "userPhone": '1234554321',
                            "userName": firstNameInputController.text,
                            "userPhone": userPhoneInputController.text,
                            "userCore": userCoreInputController.text,
                            "feedback": userFeedBackInputController.text,
                          }
                          )
                              .then((result) =>{
                            print('Data Saved!\n ${userPhoneInputController.text}')
                          });

                          Alert(context: context, title: "Saved", desc: "Changes saved successfully!").show();

                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



}





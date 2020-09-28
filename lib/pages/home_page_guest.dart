import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterappusersignin/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterappusersignin/pages/custom_card_builder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePageGuest extends StatefulWidget {
  HomePageGuest({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageGuestState();
}


class _HomePageGuestState extends State<HomePageGuest> {

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isGuestUser;
  String userName, userid;
  List<String> completedModules=[];

  String get userCoreSubject {
    return 'Part-3-civil'; //todo: THIS HAS TO BE AUTO IMPLEMENTED;
  }

  @override
  void initState() {
    super.initState();

    widget.auth.getCurrentUser().then((user) {
      setState(() {
//        if (userid!=null){getUserData(userid);}
        isGuestUser = user.isAnonymous;
        userid = user.uid;
        if (user.displayName == null){
        userName = user.uid;}
        else
          {userName = user.displayName; }
      });
    });
  }



//getUserData(String docNameUserID) async {
//    print('starting getUserData()');
//    Firestore.instance
//        .collection('users')
//        .document(docNameUserID)
//    // ignore: non_constant_identifier_names
//        .get()
//        .then((DocumentSnapshot) {
//      var completedModules1 = DocumentSnapshot.data["completed"];
//      print('Field is $completedModules1');
//      setState(() {
//        if (completedModules1==null){ completedModules =[''];} else
//          completedModules =List<String>.from(completedModules1);
//      });
//
//    });
//
//  }



  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(child: Container(child: Text('$userName'))),
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
              Tab(text: 'Part-1',),
              Tab(text: 'Part-2',),
              Tab(text: 'Part-3',),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TabBarView(
            children: [
              SingleChildScrollView(
                  child: buildMyList( 'Part-1', isGuestUser, userid, completedModules)),
              SingleChildScrollView(
                  child: buildMyList('Part-2', isGuestUser, userid, completedModules)),
              SingleChildScrollView(
                  child: buildMyList(userCoreSubject, isGuestUser, userid, completedModules)),
            ],
          ),
        ),
      ),
    );
  }



}
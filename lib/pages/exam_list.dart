//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
//
//class MyCardList extends StatefulWidget {
//
////  MyCardList(bool anonUser);
//
//  @override
//  _MyCardListState createState() => _MyCardListState();
//
////  bool isGuestUser(bool anonUser) {
////    if(anonUser){return true;} else {return false;}
////  }
//
//}
//
//class _MyCardListState extends State<MyCardList> {
//  bool isGuestUser = true;
//  @override
//  Widget build(BuildContext context){
//    return Scaffold(
////      appBar: AppBar(
////        title: Text('Exam List Page'),
////      ),
//      body: Center(
//        child: Container(
//            padding: const EdgeInsets.all(10.0),
//            child: StreamBuilder<QuerySnapshot>(
//              stream: Firestore.instance.collection('tasks')
//                  .snapshots(),
//              builder: (BuildContext context,
//                  AsyncSnapshot<QuerySnapshot> snapshot) {
//                if (snapshot.hasError)
//                  return new Text('Error: ${snapshot.error}');
//                switch (snapshot.connectionState) {
//                  case ConnectionState.waiting:
//                    return new Text('Loading...');
//                  default:
//                    return new ListView(
//                      children: snapshot.data.documents
//                          .map((DocumentSnapshot document) {
//                        return new CustomCard(
//                          title: document['title'],
//                          description: document['description'],
//                          visible:document['user'],
//                        );
//                      }).toList(),
//                    );
//                }
//              },
//            )),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {print('show dialog is pressed');},
////        _showDialog,
//        tooltip: 'Add',
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//}
//
//
//class CustomCard extends StatelessWidget {
//  CustomCard({@required this.title, this.description, this.visible});
//
//  final title;
//  final description;
//  final visible;
//
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//        child: Container(
//            padding: const EdgeInsets.only(top: 5.0),
//            color: Colors.grey[CheckAccess(visible)],
//            child: Column(
//              children: <Widget>[
//                Text(title, style: TextStyle(
//                  color: Colors.teal[CheckAccess(visible)]
//                ),),
//                FlatButton(
//                    child: Text("See More"),
//                    onPressed: () {
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => SecondPage(
//                                  title: title, description: description)));
//                    }),
//              ],
//            )));
//  }
//
//  int CheckAccess(bool userType){
//    if(userType==true) return 0; return 200;
//  }
//}
//
//class SecondPage extends StatelessWidget {
//  SecondPage({@required this.title, this.description});
//
//  final title;
//  final description;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text(title),
//        ),
//        body: Center(
//          child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                Text(description),
//                RaisedButton(
//                    child: Text('Back To HomeScreen'),
//                    color: Theme.of(context).primaryColor,
//                    textColor: Colors.white,
//                    onPressed: () => Navigator.pop(context)),
//              ]),
//        ));
//  }
//}
//
//

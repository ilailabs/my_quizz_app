//class SolutionsPage extends StatefulWidget {
////  SolutionsPage({this.userId, this.examCode})
//  @override
//  _SolutionsPageState createState() => _SolutionsPageState();
//}
//
//class _SolutionsPageState extends State<SolutionsPage> {
//
//  final FirebaseDatabase _database = FirebaseDatabase.instance;
//  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//  String userid = 'dox7...';
//  String examCode = 'em11';
//  var user_ans = [1,2,3,4,1,null,0];
//  var actual_ans = [1,2,3,4,5,6,7];
//  var image_ans = ['link1','link2','link3','link4', 'link5', 'link6', 'link7', 'link8', 'link9', 'link10'];
//  var video_ans= ['videoLink1','videoLink2','videoLink3','videoLink4','videoLink5','videoLink6','videoLink7','videoLink8','videoLink9','videoLink10'];
//
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    SystemChrome.setEnabledSystemUIOverlays(
//        SystemUiOverlay.values);
//
//    String displayDetails =
//        'UserId: $userid \n'
//        'ExamId: $examCode \n'
//        'UserAns: $user_ans \n'
//        'ActualAns: $actual_ans \n'
//        'ImageAns: $image_ans \n'
//        'VideoAns: $video_ans \n'
//    ;
//
//    return SafeArea(
//      child: Scaffold(
//        appBar: AppBar(
//          title: Row(
//            children: <Widget>[
//              Expanded(child: Text('$examCode')),
//              Expanded(
//                child: FlatButton(
//                  child: Icon(
//                    Icons.home, color: Colors.white,
//                  ),
//                  onPressed: () {
//                    print('return to home page');
//
////                    Navigator.push(
////                      context,
////                      MaterialPageRoute(builder: (context) {
////                        return HomePageSubscribedUser(
////                          userId: userid,
////                          auth: widget.auth,
////                          logoutCallback: logoutCallback,
////                        );
////                      }),
////                    );
//                  },
//                ),
//              ),
//
//            ],
//          ),
//        ),
//
//
//
//
//        body:
////        BodyLayout(),
//        CompletedExamList(),
//
//
//
//
//
//
//      ),
//    );
//  }
//}
//
//class CompletedExamList extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return _MyExpandedList(context);
//  }
//}
//
//
//
//Widget _MyExpandedList(BuildContext context){
//
//  return ListView(
//    children: <Widget>[
//      ExpansionTile(
//        title: Text('EML11'),
//        backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
//        children:
//        <Widget>[
////
//////          ListView(
//////            children: <Widget>[
//////              new ListTile(
//////                title: const Text('2'),
//////                onTap: () {
//////                  print('tapped');
//////                },
//////              ),
//////            ],
//////
//////          ),
////
//          _MyListTile(context),
//////          BodyLayout(),
////
////
////
////
////          new ListTile(
////            title: const Text('2'),
////            onTap: () {
////              print('tapped');
////            },
////          ),
////
////
////
////
////
////
////
//        ],
//
//      ),],);
//
////return _myListView(context);
//
//
//
//
//}
//
//Widget _MyListTile(BuildContext context) {
//  return ListTile(
//    title: const Text('1'),
//    onTap: () {
//      print('tapped');
//    },
//  );
//}

//          new ListTile(
//            title: const Text('1'),
//            onTap: () {
//              print('tapped');
//            },
//          ),
//          new ListTile(
//            title: const Text('2'),
//            onTap: () {
//              print('tapped');
//            },
//          ),




//class BodyLayout extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return _myListView(context);
//  }
//}
//
//// replace this function with the code in the examples
//Widget _myListView(BuildContext context) {
//  int a=1;
//
//  // backing data
//  final myExams = ['em11', 'be11', 'be22', 'ci11'];
//
//  var em11_ans = [1,2,3,4,1,null,0];
//  var be11_ans = [1,2,3,4,2,null,0];
//  var be22_ans = [1,2,3,4,3,null,0];
//  var ci11_ans = [1,2,3,4,4,null,0];
//
//  var em11_key = [1,2,3,4,5,6,7];
//  var be11_key = [1,2,3,4,5,6,7];
//  var be22_key = [1,2,3,4,5,6,7];
//  var ci11_key = [1,2,3,4,5,6,7];
//
//  return ListView.builder(
//    itemCount: 7, //'myExams[a].toString()_ans.length,
//    itemBuilder: (context, index) {
//      int qno = index+1;
//      return ListTile(
//        title: Row(
//          children: <Widget>[
//            Text('$qno'),
//            Icon(
//              Icons.check, color: Colors.green,
//            ),
//          ],
//        ),
//      );
//    },
//  );
//
//}
//
////todo: WORKING WELL

//ListView(
//children: <Widget>[
//ExpansionTile(
//title: Text('EML11'),
//backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
//children: <Widget>[
//new ListTile(
//title: const Text('1'),
//onTap: () {
//setState(() {
//this.foos = 'One';
//});
//},
//),
//new ListTile(
//title: const Text('2'),
//onTap: () {
//setState(() {
//this.foos = 'Two';
//});
//},
//),
//],
//),],)


//body: ListView(
//children: <Widget>[
//ExpansionTile(
//title: Text('EML11'),
//backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
//children: <Widget>[
//new ListTile(
//title: const Text('1'),
//onTap: () {
//setState(() {
//this.foos = 'One';
//});
//},
//),
//new ListTile(
//title: const Text('2'),
//onTap: () {
//setState(() {
//this.foos = 'Two';
//});
//},
//),
//new ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//]
//),
//ExpansionTile(
//title: Text('BEL11'),
//backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
//children: <Widget>[
//ListTile(
//title: const Text('1'),
//onTap: () {
//setState(() {
//this.foos = 'One';
//});
//},
//),
//ListTile(
//title: const Text('2'),
//onTap: () {
//setState(() {
//this.foos = '3';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//ListTile(
//title: const Text('3'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//
//]
//),
//ExpansionTile(
//title: Text('BE22'),
//backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
//children: <Widget>[
//new ListTile(
//title: const Text('One'),
//onTap: () {
//setState(() {
//this.foos = 'One';
//});
//},
//),
//new ListTile(
//title: const Text('Two'),
//onTap: () {
//setState(() {
//this.foos = 'Two';
//});
//},
//),
//new ListTile(
//title: const Text('Three'),
//onTap: () {
//setState(() {
//this.foos = 'Three';
//});
//},
//),
//]
//),
//],
//),

//TODO: WORKING WELL


//import 'package:flutter/material.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(title: Text('Test App')),
//        body:
//      ),
//    );
//  }
//}




//class Entry {
//  Entry(this.title, [this.children = const <Entry>[]]);
//  final String title;
//  final List<Entry> children;
//}
//
//// The entire multilevel list displayed by this app.
//final List<Entry> data = <Entry>[
//  Entry('Chapter A',
//    <Entry>[
//      Entry('Section A0',
//        <Entry>[
//          Entry('Item A0.1'),
//          Entry('Item A0.2'),
//          Entry('Item A0.3'),
//        ],
//      ),
//      Entry('Section A1'),
//      Entry('Section A2'),
//    ],
//  ),
//  Entry('Chapter B',
//    <Entry>[
//      Entry('Section B0'),
//      Entry('Section B1'),
//    ],
//  ),
//  Entry('Chapter C',
//    <Entry>[
//      Entry('Section C0'),
//      Entry('Section C1'),
//      Entry('Section C2',
//        <Entry>[
//          Entry('Item C2.0'),
//          Entry('Item C2.1'),
//          Entry('Item C2.2'),
//          Entry('Item C2.3'),
//        ],
//      ),
//    ],
//  ),
//];
//
//// Displays one Entry. If the entry has children then it's displayed
//// with an ExpansionTile.
//class EntryItem extends StatelessWidget {
//  const EntryItem(this.entry);
//
//  final Entry entry;
//
//  Widget _buildTiles(Entry root) {
//    if (root.children.isEmpty)
//      return ListTile(title: Text(root.title));
//    return ExpansionTile(
//      key: PageStorageKey<Entry>(root),
//      title: Text(root.title),
//      children: root.children.map<Widget>(_buildTiles).toList(),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return _buildTiles(entry);
//  }
//}
//
////void main() {
////  runApp(ExpansionTileSample());
////}

//class MyListView extends StatefulWidget {
//  MyListView({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _MyHomePageScreenState createState() => new _MyHomePageScreenState();
//}
//
//class _MyHomePageScreenState extends State<MyListView> {
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(widget.title),
//      ),
//      body: new ListView.builder(
//        itemCount: policies.length,
//        itemBuilder: (context, i) {
//          return new ExpansionTile(
//            title: new Text(
//              policies[i].title,
//              style: new TextStyle(
//                  fontSize: 20.0,
//                  fontWeight: FontWeight.bold,
//                  fontStyle: FontStyle.italic,
//                  color: Colors.blue),
//            ),
//            children: <Widget>[
//              new Column(
//                children: _buildExpandableContent(policies[i]),
//              ),
//            ],
//          );
//        },
//      ),
//    );
//  }
//
//  _buildExpandableContent(Websites policies) {
//    List<Widget> columnContent = [];
//
//    for (String content in policies.contents)
//      columnContent.add(
//        new ListTile(
//            title: new Text(
//              content,
//              style: new TextStyle(fontSize: 18.0, color: Colors.lightBlue),
//            ),
//            onTap: () {
//              _openWebUrl(Websites.endpoints[content], content);
//            }),
//      );
//
//    return columnContent;
//  }
//
//  _openWebUrl(String url, String title) {
//    Navigator.push(
//      context,
//      MaterialPageRoute(
//        builder: (context) => GeneralWebScreen(url: url, item: title),
//      ),
//    );
//  }
//}
//
//class Websites {
//  final String title;
//  List<String> contents = [];
//
//  static final Map<String, String> endpoints = const {
//    "git": "https://github.com/",
//    "google": "https://www.google.com/",
//    "flutter": "https://flutter.dev/docs/get-started/install",
//    "swift": "https://developer.apple.com/swift/"
//  };
//
//  Websites(this.title, this.contents);
//}
//
//final titles = [
//  'websites sample 1',
//  'websites sample 2',
//];
//
//List<Websites> policies = [
//  new Websites('websites sample 1', [
//    'git',
//    'flutter',
//  ]),
//  new Websites('Websites sample 2', ['google', 'swift']),
//];
//
//
//class GeneralWebScreen extends StatelessWidget {
//  final String url;
//  final String item;
//
//  GeneralWebScreen({Key key, @required this.url, @required this.item})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text(item),
//        ),
//        body: WebView(
//          initialUrl: url,
//          javascriptMode: JavascriptMode.unrestricted,
//        ));
//  }
//}
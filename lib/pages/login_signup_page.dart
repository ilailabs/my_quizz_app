import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterappusersignin/services/authentication.dart';

import 'custom_card_builder.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback, this.loginCallbackGuest});

  final BaseAuth auth;
  final VoidCallback loginCallback;
  final VoidCallback loginCallbackGuest;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateGuest() async {
    print('Validating Guest');
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    String userId;
    bool userAnon;
    FirebaseUser myTemp;
    try {
      await FirebaseAuth.instance.signInAnonymously();
      myTemp = await widget.auth.getCurrentUser();
      userAnon = myTemp.isAnonymous;
      userId = myTemp.uid;
      print('GUEST USER IS $myTemp');
      print('user id is $userId');
      print('user tyep anon $userAnon');
      if (userId.length > 0 && userId != null && _isLoginForm && userAnon) {
        widget.loginCallbackGuest();
      }
    } catch (e) {
      print('catche is executed; the message is $e');
      setState(() {
        _isLoading = false;
        _errorMessage = e.message;
      });
    }

//    if (validateAndSave()){
//      String userId;
//      bool userAnon;
//      var myTemp;
//      print('validated and saved');
//      try {
//        print('trying... to login...');
//        userId = await widget.auth.signIn(_email, _password);
////        var myTemp = await widget.
////        get guest user id and user type
//        print('User ID is: $userId');
//        myTemp = await widget.auth.getCurrentUser();
//        print('user is: $myTemp ');
//        userAnon = myTemp.isAnonymous;
//        if (userId.length > 0 && userId != null && _isLoginForm && userAnon) {
////          widget.loginCallbackGuest();
//        print('call guest user call back');
//        }
//
//      } catch(e) {
//        print('catche is executed; the message is $e');
//        setState(() {
//          _isLoading = false;
//          _errorMessage=e.message;
//        });
//      }
//    }
  }

//   Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      FirebaseUser myUser;
      bool userAnon;

      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          myUser = await widget.auth.getCurrentUser();
          userAnon = myUser.isAnonymous;
          print('Signed in: $userId');
        } else {
          //todo: dummy this and send the information to database for marketing;
//          userId = await widget.auth.signUp(_email, _password);
//        print('store the user information $_email and $_password to database');
//          myUser = await widget.auth.getCurrentUser();
//        print('requesting...');
//          userAnon = myUser.isAnonymous;
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          print('New User Signed up: $myUser');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm && !userAnon) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  void newSignInRequest() {
    print('must display alert box');
//    return AlertDialog(
//      title: new Text("Thanks for your interest"),
//      content: new Text("Sign in instructions has been sent to your email"),
//      actions: <Widget>[
//        new FlatButton(
//          child: new Text("Dismiss"),
//          onPressed: () {
//            Navigator.of(context).pop();
//          },
//        ),
//      ],
//    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Login Page'),
        ),
        body: Stack(
          children: <Widget>[
            _showForm(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

//  void _showVerifyEmailSentDialog() {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text("Verify your account"),
//          content:
//              new Text("Link to verify account has been sent to your email"),
//          actions: <Widget>[
//            new FlatButton(
//              child: new Text("Dismiss"),
//              onPressed: () {
//                toggleFormMode();
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
//              showLogo(),
              showEmailInput(),
              showPasswordInput(),
              showPrimaryButton(),
              showSecondaryButton(),
              showErrorMessage(),
              Divider(),
              showGuestButton(),
            ],
          ),
        ));
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('images/my_icon.png'),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    return new FlatButton(
      child: new Text(
          _isLoginForm ? 'Request an account' : 'Have an account? Sign in',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) =>requestLogin()));

      },
    );
//        toggleFormMode);
  }

  Widget showGuestButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.grey,
            child: new Text(
                _isLoginForm
                    ? 'Continue without signing in'
                    : 'Thanks for your interest',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateGuest,
          ),
        ));
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text(_isLoginForm ? 'Login' : 'Request account',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
//            validateAndSubmit,
          ),
        ));
  }
}

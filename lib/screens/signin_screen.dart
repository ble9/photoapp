import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photomemo/controller/firebasecontroller.dart';
import 'package:photomemo/model/photomemo.dart';
import 'package:photomemo/screens/home_screen.dart';
import 'package:photomemo/screens/views/mydialog.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signInScreen';

  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignInScreen> {
  _Controller con;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset('assets/images/greennote.png'),
                  Positioned(
                    top: 50.0,
                    left: 16.0,
                    child: Text(
                      'PhotoMemo',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 70.0,
                        fontFamily: 'IndieFlower',
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: con.validatorEmail,
                onSaved: con.onSavedEmail,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'password',
                ),
                autocorrect: false,
                obscureText: true,
                validator: con.validatorPassword,
                onSaved: con.onSavedPassword,
              ),
              RaisedButton(
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: con.signIn,
              ),
            ],
          ),
        )));
  }
}

class _Controller {
  _SignInState _state;

  _Controller(this._state);

  String email;
  String password;

  void signIn() async {
    if (!_state.formKey.currentState.validate()) {
      return;
    }
//    print('email:$email password :$password');
    _state.formKey.currentState.save();

    MyDialog.circularProgressStart(_state.context);

    FirebaseUser user;
    try {
       user = await FirebaseController.signIn(email, password);
      print('USER: $user');
    } catch (e) {

         MyDialog.circularProgressEnd(_state.context);

      MyDialog.info(
        context: _state.context,
        title: 'Sign In Error',
        content: e.message ?? e.toString(),
      );
      return;
    }
     //sigin succeded
     //1.read all photomemo's from firebase
    try {
      List<PhotoMemo> photoMemos = await FirebaseController.getPhotoMemos(user.email);

      Navigator.pushReplacementNamed(_state.context, HomeScreen.routeName,
      arguments: {'user': user, 'photoMemoList':photoMemos, } );

    } catch (e)  {
      MyDialog.circularProgressEnd(_state.context);
      MyDialog.info(
        context: _state.context,
        title: 'Firestore/Firebase error',
        content: ' Cannot get photo memo document. Try again later!\n ${e.message} '
      );
    }

  }

  String validatorEmail(String value) {
    if (value == null || !value.contains('@') || !value.contains('.')) {
      return 'not valid email';
    } else {
      return null;
    }
  }

  void onSavedEmail(String value) {
    email = value;
  }

  String validatorPassword(String value) {
    if (value == null || value.length < 6) {
      return ' password min 6 char';
    } else {
      return null;
    }
  }

  void onSavedPassword(String value) {
    password = value;
  }
}

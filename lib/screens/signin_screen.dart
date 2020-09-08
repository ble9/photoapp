import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photomemo/controller/firebasecontroller.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signInScreen';

  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignInScreen> {
  _Controller con;
  var formKey = GlobalKey <FormState>();

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
                  Image.asset('assets/images/postit.jpg'),
                  Positioned(
                    top: 50.0,
                    left: 16.0,
                    child: Text(
                      'PhotoMemo',
                  style: TextStyle(
                    color:Colors.blue[700],
                  fontSize: 25.0,
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
                  )
                ],
              ),
            )
        )
    );
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
    _state.formKey.currentState.save();

    try {
      var user = await FirebaseController.signIn(email, password);
      print('USER: $user');
    } catch (e) {
      MyDialog.info(
        content: _state.context,
        title: 'Sign In Error',
        content: e.message ?? e.toString(),
      );

      return;
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
      return ' min 6 char';
    } else {
      return null;
    }
  }

  void onSavedPassword(String value) {
    password = value;
  }
}

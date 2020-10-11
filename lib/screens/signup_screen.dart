import 'package:flutter/material.dart';
import 'package:photomemo/controller/firebasecontroller.dart';
import 'package:photomemo/screens/views/mydialog.dart';

class SignUpScreen extends StatefulWidget{
  static const routeName = '/signInScreen/signUpScreen';

  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUpScreen> {
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
      title:Text('Create an Account'),
    ),
    body: SingleChildScrollView(
      child:Form(
        key:formKey,
        child: Column(
          children: <Widget>[
            Text('Create an account',
            style: TextStyle(fontSize: 25.0),
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
            hintText: 'Password',
          ),
          autocorrect: false,
          obscureText: true,
          validator: con.validatorPassword,
          onSaved: con.onSavedPassword,
        ),
        RaisedButton(
          child: Text('Create', style: TextStyle(fontSize: 20.0, color: Colors.white),),
          color: Colors.blue,
          onPressed: con.signUp,
        ),
          ],
        ),
      ),
    ),
    );
  }

}

class _Controller {
  _SignUpState _state;
  _Controller(this._state);
  String email;
  String password;

  void signUp() async {
    if (!_state.formKey.currentState.validate()) return;

    _state.formKey.currentState.save();

    try {
      await FirebaseController.signUp(email, password);
      MyDialog.info(
        context: _state.context,
        title: 'Success',
        content: 'acount made , Sign in',
      );
    }catch(e){
      MyDialog.info(
          context: _state.context,
          title: 'Error',
          content: e.message ?? e.toString(),
      );
    }
  }

  String validatorEmail(String value) {
    if (value.contains('@') && value.contains('.')) return null;
      else return 'not valid email';
  }

  void onSavedEmail(String value) {
    this.email = value;
  }

  String validatorPassword(String value) {
    if (value.length < 6)  return ' password min 6 char';
    else return null;
    }
  void onSavedPassword(String value) {
    this.password = value;
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signInScreen';

  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignInScreen> {
  _Controller con;
var formKey = GlobalKey<FormState>;
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
              TextFormField(
                decoration: InputDecoration(
                hintText: 'Email',
              ),
              keyboardType:TextInputType.emailAddress,
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
                color:Colors.blue,
                onPressed: con.signIn,
              )
            ],
          ),

        )
    )
      )
    );
  }
}

class _Controller {
  _SignInState _state;
  _Controller(this._state);

  void si
}

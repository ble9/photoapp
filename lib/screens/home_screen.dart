//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:photomemo/controller/firebasecontroller.dart';
//
//import 'package:photomemo/model/photomemo.dart';
//import 'package:photomemo/screens/add_screen.dart';
//import 'package:photomemo/screens/signin_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photomemo/controller/firebasecontroller.dart';
import 'package:photomemo/model/photomemo.dart';
import 'package:photomemo/screens/add_screen.dart';
import 'package:photomemo/screens/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/signInScreen/homeScreen';

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  _Controller con;

  FirebaseUser user;
  List<PhotoMemo> photoMemos;

  @override
  void initState(){
    super.initState();
    con = _Controller(this);
  }
  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    Map arg = ModalRoute.of(context).settings.arguments;
    user ??= arg['user'];
    photoMemos ??= arg['photoMemoList'];

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: Drawer(
          child: ListView (
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text( user.email),
                accountName: Text(user.displayName ?? 'N/A'),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign out'),
                onTap: (){},
              ),
            ],
          )
        ),
        floatingActionButton: FloatingActionButton(
          child:Icon(Icons.add),
          onPressed: con.addButton,
        ),
        body: photoMemos.length == 0 ?
            Text('No photo memo') :
            ListView.builder(
                itemCount: photoMemos.length,
                itemBuilder: (BuildContext context, int index) =>
                    ListTile( leading : Image.network(photoMemos[index].photoURL),
                    title: Text (photoMemos[index].title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text( ' created by ${photoMemos[index].createdBy}'),
                        Text( ' Updated at ${photoMemos[index].updatedAt}'),
                        Text(photoMemos[index].memo),
                      ]
                    )
                    )
            ),
      ),
    );
  }
}
class _Controller {
  _HomeState _state;

  _Controller(this._state);

  void addButton() async {
    await Navigator.pushNamed(_state.context, AddScreen.routeName,
        arguments: { 'user': _state.user, 'photoMemoList': _state.photoMemos});
    _state.render(() {});
  }

  void signOut() async {
    try {
      await FirebaseController.signOut();
    } catch (e) {
      print('Sign out exception: ${e.message}');
    }
    Navigator.pushReplacementNamed(_state.context, SignInScreen.routeName);
  }
}
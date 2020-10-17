import 'package:flutter/material.dart';
import 'package:photomemo/screens/add_screen.dart';
import 'package:photomemo/screens/detailed_screen.dart';
import 'package:photomemo/screens/draw_screen.dart';
import 'package:photomemo/screens/edit_screen.dart';
import 'package:photomemo/screens/home_screen.dart';
import 'package:photomemo/screens/settings_screen.dart';
import 'package:photomemo/screens/sharedwith_screen.dart';
import 'package:photomemo/screens/signin_screen.dart';
import 'package:photomemo/screens/signup_screen.dart';


void main() async{

  runApp(PhotoMemoApp());
}

class PhotoMemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SignInScreen.routeName,
      routes: {
        SignInScreen.routeName: (context) => SignInScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddScreen.routeName: (context) => AddScreen(),
        DetailedScreen.routeName: (context) => DetailedScreen(),
        EditScreen.routeName: (context) => EditScreen(),
        SharedWithScreen.routeName: (context) => SharedWithScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        Draw.routeName:(context) => Draw(),
      },
    );
  }
}

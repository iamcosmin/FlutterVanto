import 'package:Vanto/classes/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'classes/authentication/authentication.dart';
import 'classes/authentication/splash.dart';
import 'classes/home.dart';

void main()  {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
  ));
}

// Application Configuration
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Vanto',
      theme: CupertinoThemeData(
          brightness: Brightness.dark,
          textTheme: CupertinoTextThemeData(
              textStyle: TextStyle(color: Colors.white))),
        home: new RootPage(auth: new Auth()));
  }
}

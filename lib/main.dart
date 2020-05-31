import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'classes/authentication/splash.dart';

void main() {
  runApp(MainApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  ));
}
class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        title: 'Vanto',
        debugShowCheckedModeBanner: false,
        home: Main());
  }
}

// Application Configuration
class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final darkTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.darkBackgroundGray,
    scaffoldBackgroundColor: CupertinoColors.black,
    primaryContrastingColor: CupertinoColors.white,
    brightness: Brightness.dark,
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.activeGreen,
      textStyle: TextStyle(color: CupertinoColors.white, fontFamily: 'SF Pro Display'),
    ),
  );

  final lightTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.white,
    scaffoldBackgroundColor: CupertinoColors.lightBackgroundGray,
    primaryContrastingColor: CupertinoColors.black,
    brightness: Brightness.light,
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.activeGreen,
      textStyle: TextStyle(color: CupertinoColors.black, fontFamily: 'SF Pro Display'),
    ),
  );





  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return CupertinoApp(
            title: 'Vanto',
            debugShowCheckedModeBanner: false,
            theme: isDark == true ? darkTheme : lightTheme,
            home: new RootPage());
  }
}

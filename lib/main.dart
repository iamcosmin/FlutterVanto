import 'package:Vanto/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'classes/authentication/splash.dart';

void main() {
  runApp(MainApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
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
        title: 'Vanto', debugShowCheckedModeBanner: false, home: Main());
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
      textStyle:
          TextStyle(color: CupertinoColors.white, fontFamily: 'Inter'),
    ),
  );

  final lightTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.lightBackgroundGray,
    scaffoldBackgroundColor: CupertinoColors.white,
    primaryContrastingColor: CupertinoColors.black,
    brightness: Brightness.light,
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.activeGreen,
      textStyle:
          TextStyle(color: CupertinoColors.black, fontFamily: 'Inter'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return CupertinoApp(
        localizationsDelegates: [
          const TranslationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: TranslationDelegate.supportedLocals,
        title: 'Vanto',
        debugShowCheckedModeBanner: false,
        theme: isDark == true ? darkTheme : lightTheme,
        home: new RootPage());
  }
}

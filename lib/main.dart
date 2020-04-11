import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'screens/home.dart';
import 'screens/settings.dart';
import 'screens/tv.dart';
import 'screens/store.dart';
import 'screens/music.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return CupertinoApp(
      title: 'Vanto',
      theme: CupertinoThemeData(brightness: Brightness.dark, textTheme: CupertinoTextThemeData(textStyle: TextStyle(color: Colors.white))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text('Acasă'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.collections),
            title: Text('Magazin'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.music_note),
            title: Text('Muzica'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.video_camera),
            title: Text('TV'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            title: Text('Setari'),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return Home();
                break;
              case 1:
                return Store();
                break;
              case 2:
                return Music();
                break;
              case 3:
                return TV();
                break;
              case 4:
                return Settings();
                break;
              default:
                return Container();
            }
          },
        );
      },
    );
  }
}
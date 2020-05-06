import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'tools/classes.dart';

void main() => runApp(MyApp());

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
      home: TabNavigator(),
    );
  }
}

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigator createState() => _TabNavigator();
}

class _TabNavigator extends State<TabNavigator> {
  int _selectedIndex = 0;
  static List _widgetOptions = [
    Home(),
    Store(),
    Music(),
    TV(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.black,
            child: GNav(
                gap: 5,
                activeColor: Colors.white,
                color: Colors.grey,
                backgroundColor: Colors.black,
                tabBackgroundGradient: LinearGradient(
                    colors: [Colors.deepPurpleAccent, Colors.pinkAccent]),
                iconSize: 27.0,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                duration: Duration(milliseconds: 300),
                tabs: [
                  GButton(
                    icon: Ionicons.ios_home,
                    text: 'Acasă',
                  ),
                  GButton(
                    icon: Ionicons.ios_appstore,
                    text: 'Magazin',
                  ),
                  GButton(
                    icon: Ionicons.ios_musical_notes,
                    text: 'Muzica',
                  ),
                  GButton(
                    icon: Ionicons.ios_albums,
                    text: 'TV',
                  ),
                  GButton(
                    icon: Ionicons.ios_cog,
                    text: 'Setări',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}

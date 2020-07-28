import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../locale.dart';
import '../home.dart';
import '../settings.dart';
import '../store.dart';
import '../tv.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigator createState() => _TabNavigator();
  TabNavigator({Key key, this.userId, this.logoutCallback}) : super(key: key);

  final VoidCallback logoutCallback;
  final String userId;
}

class _TabNavigator extends State<TabNavigator> {
  String model;
  String product;
  String appName;
  int buildNumber;
  String packageName;
  String version;

  Future verifyMaintenance() async {
    Translation translation = await Translation.of(context);
    Firestore.instance
        .collection('settings')
        .document('status')
        .get()
        .then((value) {
      if (value.exists) {
        if (value.data['maintenance'] != false) {
          showCupertinoDialog(
              context: context,
              builder: (context) => WillPopScope(
                    onWillPop: () async => false,
                    child: CupertinoAlertDialog(
                      title: Text(translation.errorMaintenanceTitle,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              letterSpacing: -0.5,
                              fontSize: 17.0)),
                      content: Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            translation.errorMaintenanceSubtitle,
                            style:
                                TextStyle(fontFamily: 'Inter', fontSize: 15.0),
                          )),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text(translation.generalRetry,
                              style: TextStyle(
                                  fontFamily: 'Inter', fontSize: 17.0)),
                          onPressed: () {
                            verifyMaintenance();
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ));
        } else {
          verifyBan();
        }
      }
    });
  }

  Future verifyBan() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Translation translation = await Translation.of(context);
    Firestore.instance
        .collection('users')
        .document(user.email)
        .get()
        .then((value) {
      if (value.exists) {
        if (value.data['banned'] != false && value.data['banned'] != null) {
          showCupertinoDialog(
              context: context,
              builder: (context) => WillPopScope(
                    onWillPop: () async => false,
                    child: CupertinoAlertDialog(
                      title: Text(translation.errorBannedTitle,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              letterSpacing: -0.5,
                              fontSize: 17.0)),
                      content: Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            translation.errorBannedSubtitle,
                            style:
                                TextStyle(fontFamily: 'Inter', fontSize: 15.0),
                          )),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text(translation.errorBannedAppeal,
                              style: TextStyle(
                                  fontFamily: 'Inter', fontSize: 17.0)),
                          onPressed: () {
                            launch(
                                'https://github.com/iamcosmin/Vanto-Flutter/issues');
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text(translation.generalRetry,
                              style: TextStyle(
                                  fontFamily: 'Inter', fontSize: 17.0)),
                          onPressed: () {
                            verifyBan();
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ));
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    verifyMaintenance();
  }

  int _selectedIndex = 0;
  static List _widgetOptions = [
    Home(),
    Store(),
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
            color: CupertinoTheme.of(context).primaryColor,
            child: GNav(
                gap: 5,
                activeColor: Colors.white,
                color: Colors.grey,
                backgroundColor: CupertinoTheme.of(context).primaryColor,
                tabBackgroundGradient: LinearGradient(
                    colors: [Colors.deepPurpleAccent, Colors.pinkAccent]),
                iconSize: 27.0,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                duration: Duration(milliseconds: 300),
                tabs: [
                  GButton(
                    icon: Ionicons.ios_home,
                    text: Translation.of(context).navigationHome,
                  ),
                  GButton(
                    icon: Ionicons.ios_appstore,
                    text: Translation.of(context).navigationStore,
                  ),
                  GButton(
                    icon: Ionicons.ios_tv,
                    text: 'TV',
                  ),
                  GButton(
                    icon: Ionicons.ios_cog,
                    text: Translation.of(context).navigationSettings,
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

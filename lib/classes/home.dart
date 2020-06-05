import 'package:Vanto/locale.dart';
import 'package:Vanto/tools/short.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  @override
  HomeScreen createState() => HomeScreen();
}

class HomeScreen extends State<Home> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: DefaultTextStyle(
          style: TextStyle(fontFamily: 'SF Pro Display'),
          child: FutureBuilder(
              future: FirebaseAuth.instance.currentUser(),
              builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                if (snapshot.hasData)
                  return CustomScrollView(slivers: <Widget>[
                    CupertinoSliverNavigationBar(
                      largeTitle: Text('Bună, ${snapshot.data.displayName}!'),
                    ),
                    SliverPadding(
                        padding: EdgeInsets.all(10.0),
                        sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Column(children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        gradient: LinearGradient(colors: [
                                          Colors.deepPurpleAccent,
                                          Colors.pinkAccent
                                        ])),
                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                            alignment: Alignment.center,
                                            heightFactor: 1.9,
                                            child: Text('În curând!',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold))),
                                        Container(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                                'Această secțiune va fi implementată în următoarea actualizare!',
                                                style: TextStyle(
                                                    fontSize: 16, color: Colors.white)))
                                      ],
                                    ),
                                  ),
                                  Divider(color: CupertinoTheme.of(context).primaryColor,),
                                ]);
                              },
                              childCount: 1,
                            )))
                  ]);
                else
                  return Container();
              }
          ),
        ));
  }
}
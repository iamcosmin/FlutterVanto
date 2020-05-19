import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  @override
  HomeScreen createState() => HomeScreen();
}

class HomeScreen extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(slivers: <Widget>[
      CupertinoSliverNavigationBar(
        largeTitle: Text('Acasă'),
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
                          child: Text('Cauți ceva?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold))),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Notificările sunt acum în setări, la fel și actualizările.',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)))
                    ],
                  ),
                ),
                Divider(color: Colors.black)
              ]);
            },
            childCount: 1,
          )))
    ]));
  }
}

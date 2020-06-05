import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../locale.dart';

class NotificationsPage extends StatefulWidget {

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  @override
  void initState() {
    super.initState();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: Translation.of(context).navigationSettings,
          middle: Text(Translation.of(context).settingsNotifications),
        ),
        child: Container(
            color: CupertinoTheme.of(context).scaffoldBackgroundColor,
            child: ListView(children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream:
                    Firestore.instance.collection('notifications').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(CupertinoColors.activeGreen),
                          )
                        ),
                      );
                    default:
                      return Container(
                        padding: EdgeInsets.only(top: 30),
                        child: new Column(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return Column(children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: CupertinoTheme.of(context).primaryColor
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          heightFactor: 1.2,
                                          child: Text(document['title'],
                                              style: TextStyle(
                                                  color: CupertinoTheme.of(context).primaryContrastingColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold))),
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(document['description'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: CupertinoColors.inactiveGray)))
                                  ],
                                ),
                              ),
                              Divider(color: CupertinoTheme.of(context).primaryColor)
                            ]);
                          }).toList(),
                        ),
                      );
                  }
                },
              ),
            ])));
  }
}

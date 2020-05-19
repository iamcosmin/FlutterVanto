import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../reusable/settings/colors.dart';

class NotificationsPage extends StatelessWidget {
  static CupertinoPageRoute<void> route() => new CupertinoPageRoute(
        title: 'Notificări',
        builder: (BuildContext context) => NotificationsPage(),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Configurări',
          middle: Text('Notificări'),
        ),
        child: Container(
            color: backgroundGray,
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
                          child: CupertinoActivityIndicator(
                            radius: 15,
                          ),
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
                                    color: CupertinoColors.darkBackgroundGray
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
                                                  color: Colors.white,
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
                              Divider(color: Colors.black)
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

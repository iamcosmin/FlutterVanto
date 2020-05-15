import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../reusable/settings/colors.dart';

class NotificationsPage extends StatelessWidget {
  static CupertinoPageRoute<void> route() => new CupertinoPageRoute(
        title: 'Cellular',
        builder: (BuildContext context) => NotificationsPage(),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Setări',
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
                      return new Column(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
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
                                      child: Text(document['title'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(document['description'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white)))
                                ],
                              ),
                            ),
                            Divider(color: Colors.black)
                          ]);
                        }).toList(),
                      );
                  }
                },
              ),
            ])));
  }
}

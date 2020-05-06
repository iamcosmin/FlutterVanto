import 'package:cloud_firestore/cloud_firestore.dart';
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
        child: CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Acasă'),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () {
            return Future<void>.delayed(const Duration(seconds: 1));
          },
        ),
        SliverPadding(
          padding: MediaQuery.of(context)
              .removePadding(
                removeTop: true,
                removeLeft: true,
                removeRight: true,
              )
              .padding,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Material(
                    child: Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.black,
                  child: Column(
                    children: <Widget>[
                      Divider(color: Colors.black),
                      StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('settings')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError)
                            return new Text('Error: ${snapshot.error}');
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
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
                                    if (document['ifinternallatest'] == '2020050100')
                                      StreamBuilder<QuerySnapshot>(
                                        stream: Firestore.instance
                                            .collection('notifications')
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot> snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.waiting:
                                              return Container(
                                                height:
                                                MediaQuery.of(context).size.height / 1.5,
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
                                                                child: Text(
                                                                    document['description'],
                                                                    style: TextStyle(
                                                                        fontSize: 16, color: Colors.white)))
                                                          ],
                                                        ),
                                                      ),
                                                    Divider(color: Colors.black)
                                                  ]);
                                                }).toList(),
                                              );
                                          }
                                        },
                                      )
                                    else
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
                                                child: Text('Versiune învechită',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.bold))),
                                            Container(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                    'Versiunea de Vanto pe care o utilizezi este veche. Te rugăm actualizează la cea mai recentă versiune din Magazin Play.',
                                                    style: TextStyle(
                                                        fontSize: 16, color: Colors.white)))
                                          ],
                                        ),
                                      ),
                                    Divider(color: Colors.black)
                                  ]);
                                }).toList(),
                              );
                          }
                        },
                      )
                    ],
                  ),
                ));
              },
              childCount: 1,
            ),
          ),
        ),
      ],
    ));
  }
}

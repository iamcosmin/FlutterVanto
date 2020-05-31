import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'reusable/store/storetile.dart';

class TV extends StatefulWidget {
  @override
  TVScreen createState() => TVScreen();
}

class TVScreen extends State<TV> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text('TV'),
          leading: new Container(),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () {
            return Future<void>.delayed(const Duration(seconds: 2));
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
                return Container(
                    padding: EdgeInsets.all(10.0),
                    child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(10.0),
                        color:
                            CupertinoTheme.of(context).primaryColor,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('movies')
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
                                    child: CircularProgressIndicator(
                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
                                    )
                                  ),
                                );
                              default:
                                return new Column(
                                  children: snapshot.data.documents
                                      .map((DocumentSnapshot document) {
                                    return StoreTile(
                                      title: document['title'],
                                      image: document['image'],
                                      link: document['link'],
                                      subtitle: document['subtitle'],
                                    );
                                  }).toList(),
                                );
                            }
                          },
                        )));
              },
              childCount: 1,
            ),
          ),
        ),
      ],
    ));
  }
}

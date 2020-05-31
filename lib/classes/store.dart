import '../classes/reusable/store/storetile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class Store extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: DefaultTextStyle(
      style: TextStyle(fontFamily: 'SF Pro Display'),
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Magazin'),
            leading: new Container(),
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
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(10.0),
                      color: CupertinoTheme.of(context).primaryColor,
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection('apps')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Container(
                                  height: MediaQuery.of(context).size.height/1.5,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
                                      )
                                    ),
                                );
                              }
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
                            },
                          )),
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

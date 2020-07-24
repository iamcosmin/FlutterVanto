import 'package:Vanto/tools/short.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../classes/reusable/store/storetile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../locale.dart';


class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  Map<int, Widget> children(context) {
    final Map<int, Widget> children = <int, Widget>{
      0: Text(Translation.of(context).storeApps),
      1: Text(Translation.of(context).storeGames),
      2: Text(Translation.of(context).storeMovies),
      3: Text(Translation.of(context).storeExclusive),
    };
    return children;
  }

  bool isLoading = false;
  int currentSegment = 0;

  void onValueChanged(int newValue) {
    setState(() {
      currentSegment = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      body: CupertinoPageScaffold(
          child: DefaultTextStyle(
        style: TextStyle(fontFamily: 'Inter'),
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text(Translation.of(context).navigationStore),
            ),
            SliverBuilder(
              build: Container(
                color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 10.0,
                      child: CupertinoSlidingSegmentedControl(
                        children: children(context),
                        onValueChanged: onValueChanged,
                        groupValue: currentSegment,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        child: currentSegment == 0
                            ? StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection('apps')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  }
                                  return Column(
                                    children: snapshot.data.documents
                                        .map((DocumentSnapshot document) {
                                      return ModdedStoreTile(
                                        title: document['title'],
                                        image: document['image'],
                                        link: document['link'],
                                        subtitle: 'App',
                                      );
                                    }).toList(),
                                  );
                                },
                              )
                            : currentSegment == 1
                                ? StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection('games')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      }
                                      return Column(
                                        children: snapshot.data.documents
                                            .map((DocumentSnapshot document) {
                                          return ModdedStoreTile(
                                            title: document['title'],
                                            image: document['image'],
                                            link: document['link'],
                                            subtitle: Translation.of(context).storeCategoryGame,
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ): currentSegment == 2
                                ? StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection('movies')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      }
                                      return Column(
                                        children: snapshot.data.documents
                                            .map((DocumentSnapshot document) {
                                          return StoreTile(
                                            title: document['title'],
                                            image: document['image'],
                                            link: document['link'],
                                            subtitle: Translation.of(context).storeCategoryMovie,
                                          );
                                        }).toList(),
                                      );
                                    },
                                  )
                                : currentSegment == 3
                                ? StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection('exclusive')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      }
                                      return Column(
                                        children: snapshot.data.documents
                                            .map((DocumentSnapshot document) {
                                          return ModdedStoreTile(
                                            title: document['title'],
                                            image: document['image'],
                                            link: document['link'],
                                            subtitle: Translation.of(context).storeCategoryExclusive,
                                          );
                                        }).toList(),
                                      );
                                    },
                                  )
                                : null)
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
import 'package:Vanto/tools/short.dart';
import 'package:shimmer/shimmer.dart';

import '../classes/reusable/store/storetile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../locale.dart';

// ignore: must_be_immutable
class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  Map<int, Widget> children(context) {
    final Map<int, Widget> children = <int, Widget>{
      0: Text('Apps'),
      1: Text(Translation.of(context).storeCategoryMovie),
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
    return CupertinoPageScaffold(
        child: DefaultTextStyle(
      style: TextStyle(fontFamily: 'SF Pro Display'),
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
                                    return StoreTile(
                                      title: document['title'],
                                      image: document['image'],
                                      link: document['link'],
                                      subtitle: document['subtitle'],
                                    );
                                  }).toList(),
                                );
                              },
                            )
                          : currentSegment == 1
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
                                          subtitle: document['subtitle'],
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
    ));
  }
}

class ListItem extends StatelessWidget {
  final int index;
  const ListItem({Key key, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            margin: EdgeInsets.only(right: 15.0),
            color: Colors.blue,
          ),
          index != -1
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'This is title $index',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('This is more details'),
                    Text('One more detail'),
                  ],
                )
              : Expanded(
                  child: Container(
                    color: Colors.grey,
                  ),
                )
        ],
      ),
    );
  }
}

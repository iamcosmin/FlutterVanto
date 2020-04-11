import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'chats.dart';
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
                          decoration: BoxDecoration(color: Colors.black),
                          child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 110.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: LinearGradient(
                                  colors: [Colors.deepPurpleAccent, Colors.pinkAccent ]
                                )
                              
                              ),
                              child: Column(children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  heightFactor: 1.9,
                                  child: Text('Bine ați revenit la Vanto!', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Ușor ușor, aplicația începe să se construiască. Vă rugăm să ne lăsați sugestii!', style: TextStyle(fontSize: 16, color: Colors.white))
                                )
                              ],),
                            )
                          ],
                        ),)
                        
                      );
              },
              childCount: 1,
            ),
          ),
        ),
      ],
    ));
  }
}

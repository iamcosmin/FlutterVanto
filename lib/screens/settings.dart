import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Settings extends StatefulWidget {
  @override
  SettingsScreen createState() => SettingsScreen();
}

class SettingsScreen extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    bool dark = false;
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Setări'),
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
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.black87,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Align(
                                heightFactor: 2,
                                alignment: Alignment.centerLeft,
                                child: Text('Mod întunecat',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    )),
                              ),
                              trailing:  CupertinoSwitch(
                                value: true,
                                onChanged: null,
                            ),
                          ),
                          Divider(color: Colors.grey),
                          ListTile(
                            title: Align(
                                heightFactor: 2,
                                alignment: Alignment.centerLeft,
                                child: Text('Primește versiuni beta',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    )),
                              ),
                              trailing:  CupertinoSwitch(
                                value: true,
                                onChanged: null,
                            ),
                          ),
                          ListTile(
                            title: Align(
                                heightFactor: 2,
                                alignment: Alignment.centerLeft,
                                child: Text('Act. carac. experimentale',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    )),
                              ),
                              trailing:  CupertinoSwitch(
                                value: false,
                                onChanged: null,
                            ),
                          ),
                          Divider(color: Colors.grey),
                          Align(alignment: Alignment.bottomCenter,
                          child: Text('\n Vanto, versiunea 5.0.5.', style: TextStyle(color: Colors.grey)),
                          ),
                          Align(alignment: Alignment.bottomCenter,
                          child: Text('Ești înscris în programul beta.', style: TextStyle(color: Colors.grey)),
                          )
                        ],
                      )),
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

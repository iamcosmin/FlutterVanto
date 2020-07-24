import 'package:cloud_firestore/cloud_firestore.dart';

import '../locale.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        child: DefaultTextStyle(
      style: TextStyle(fontFamily: 'Inter'),
      child: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> authSnapshot) {
            if (authSnapshot.hasData) {
                  return SafeArea(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                              top: 25.0,
                              left: 25.0,
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                     Translation.of(context).navigationHome,
                                    style: TextStyle(
                                        color: CupertinoColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 25.0),
                                    child: Container(
                                        height: 45,
                                        width: 45,
                                        alignment: Alignment.centerLeft,
                                        child: ClipOval(
                                          child:
                                              Image.network(authSnapshot.data.photoUrl),
                                        )),
                                  ),
                                ])),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0, left: 25.0),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                      height: 95,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFFE8CBC0),
                                            Color(0xFF636FA4)
                                          ]),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text(
                                          '${Translation.of(context).homeWelcome},\n${authSnapshot.data.displayName}!',
                                          style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      height: 95,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF4568DC),
                                              Color(0xFFB06AB3)
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: const EdgeInsets.only(
                                                left: 20.0,),
                                            child: Text(
                                              Translation.of(context).generalBalance,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Color(0xFFFFFFFF),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomRight,
                                            padding: const EdgeInsets.only(
                                                right: 20.0,
                                                top: 5.0),
                                            child: Text(
                                              '£0.00',
                                              style: TextStyle(
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFFFFFFF),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  height: 200,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xFFFF7E5F),
                                        Color(0xFFFEB47B)
                                      ]),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      'Up to date',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
            } else {
              return Container();
            }
          }),
    ));
  }
}

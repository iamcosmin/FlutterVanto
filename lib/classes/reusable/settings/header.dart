import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

/// The first big header item in settings that aggregates the user's profile
/// type data.
class SettingsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 81.0,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 13.0,
            ),
            child: CircleAvatar(
              radius: 30.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(
                    'https://pbs.twimg.com/profile_images/1177910105578360833/3outRqk9_400x400.jpg'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 16.0)),
                  FutureBuilder(
                      future: FirebaseAuth.instance.currentUser(),
                      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.email,
                            style: TextStyle(
                              fontSize: 19.0,
                              letterSpacing: -0.52,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.white,
                            ),
                          );
                        } else {
                          return Text('Loading..');
                        }
                      }),
                  Padding(padding: EdgeInsets.only(top: 6.0)),
                  Text(
                    'Cont, Sincronizare, Voni',
                    style: TextStyle(
                      fontSize: 13.0,
                      letterSpacing: -0.1,
                      color: CupertinoColors.inactiveGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              CupertinoIcons.forward,
              color: mediumGrayColor,
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}

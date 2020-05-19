import 'package:Vanto/classes/settings/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

/// The first big header item in settings that aggregates the user's profile
/// type data.
class SettingsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (BuildContext context) => AccountManager())),
      child: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
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
                            child: Column(
                              children: <Widget>[
                                snapshot.data.photoUrl != null ? Image.network(
                                  snapshot.data.photoUrl) : Center(child: Text('')),
                              ],
                            ),
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
                            Text(
                              snapshot.data.displayName != null
                                  ? snapshot.data.displayName
                                  : 'Nume Nesetat',
                              style: TextStyle(
                                fontSize: 21.0,
                                fontWeight: FontWeight.w500,
                                color: CupertinoColors.white,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 6.0)),
                            Text(
                              'Setările contului Hermes',
                              style: TextStyle(
                                fontSize: 16.0,
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
            } else {
              return Text('Se încarcă...');
            }
          }),
    );
  }
}

import '../../../locale.dart';
import '../../settings/account/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The first big header item in settings that aggregates the user's profile
/// type data.
class SettingsHeader extends StatefulWidget {
  @override
  _SettingsHeaderState createState() => _SettingsHeaderState();
}

class _SettingsHeaderState extends State<SettingsHeader> {

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
                                  : '',
                              style: TextStyle(
                                fontSize: 21.0,
                                fontWeight: FontWeight.w500,
                                color: CupertinoTheme.of(context).primaryContrastingColor,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 6.0)),
                            Text(
                              Translation.of(context).hermesHint,
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
                        color: CupertinoColors.inactiveGray,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return new Container(
                height: 81.0,
                color: CupertinoTheme.of(context).primaryColor,
              );
            }
          }),
    );
  }
}

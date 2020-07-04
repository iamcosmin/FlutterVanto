import 'package:Vanto/classes/authentication/login.dart';
import 'package:Vanto/classes/reusable/settings/authveri.dart';
import 'package:Vanto/classes/settings/account/email.dart';
import 'package:Vanto/classes/settings/account/security.dart';

import '../../../classes/reusable/settings/group.dart';
import '../../../classes/reusable/settings/item.dart';
import '../../../classes/settings/account/pic_needs_replacement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../locale.dart';
import 'name_needs_replacement.dart';

class AccountManager extends StatefulWidget {
  AccountManager({Key key, this.name}) : super(key: key);
  final name;
  static CupertinoPageRoute<void> route() => new CupertinoPageRoute(
        builder: (BuildContext context) => AccountManager(),
      );
  @override
  _AccountManagerState createState() => _AccountManagerState();
}

class _AccountManagerState extends State<AccountManager> {
  Future<dynamic> _signOut(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, ModalRoute.withName('/'));
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (BuildContext context) => LoginSignupPage()),);
  }

  @override
  void initState() {
    super.initState();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: Translation.of(context).navigationSettings,
        middle: Text('Hermes'),
      ),
      child: Container(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FutureBuilder(
                    future: FirebaseAuth.instance.currentUser(),
                    builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                              child: CircleAvatar(
                                backgroundColor:
                                    CupertinoColors.darkBackgroundGray,
                                radius: 60.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60.0),
                                  child: Column(
                                    children: <Widget>[
                                      snapshot.data.photoUrl != null
                                          ? Image.network(
                                              snapshot.data.photoUrl)
                                          : Center(child: Text('')),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                                snapshot.data.displayName != null
                                    ? snapshot.data.displayName
                                    : '',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: CupertinoTheme.of(context)
                                      .primaryContrastingColor,
                                )),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                  snapshot.data.email != null
                                      ? snapshot.data.email
                                      : '',
                                  style: TextStyle(
                                    color: CupertinoColors.inactiveGray,
                                  )),
                            )
                          ],
                        );
                      } else {
                        return CupertinoActivityIndicator();
                      }
                    }),
              ],
            ),
            SettingsGroup(
              <Widget>[
                SettingsItem(
                    type: SettingsItemType.modal,
                    label: Translation.of(context).hermesProfileDetails,
                    hasDetails: true,
                    onPress: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ProfileDetails()))),
                SettingsItem(
                  type: SettingsItemType.modal,
                  label: Translation.of(context).hermesSecurity,
                  hasDetails: true,
                  onPress: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => SecurityDetails())),
                ),
              ],
            ),
            SettingsGroup(<Widget>[
              SettingsItem(
                label: Translation.of(context).hermesLogout,
                type: SettingsItemType.modal,
                hasDetails: true,
                onPress: () => _signOut(context),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

class ProfileDetails extends StatefulWidget {
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  String name;

  @override
  void initState() {
    super.initState();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Hermes',
        middle: Text(Translation.of(context).hermesProfileDetails),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: 60.0,
        ),
        child: FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    SettingsGroup(
                      <Widget>[
                        SettingsItem(
                          label: '${snapshot.data.displayName}',
                          type: SettingsItemType.modal,
                          hasDetails: true,
                          onPress: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ChangeNamePage(),
                              )),
                        ),
                      ],
                      header: Text(Translation.of(context).generalName.toUpperCase()),
                    ),
                    SettingsGroup(
                      <Widget>[
                        SettingsItem(
                            label: Translation.of(context).hermesChangePhotoTitle,
                            type: SettingsItemType.modal,
                            hasDetails: true,
                            onPress: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => ImageCapture(),
                                )))
                      ],
                      header: Text(Translation.of(context).generalProfilePhoto),
                    ),
                    SettingsGroup(
                      <Widget>[
                        SettingsItem(
                            label: snapshot.data.email,
                            type: SettingsItemType.modal,
                            hasDetails: true,
                            onPress: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => AuthVeri(
                                    route: ChangeEmailPage(),
                                  ),
                                )))
                      ],
                      header: Text(Translation.of(context).generalEmail),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
                ));
              }
            }),
      ),
    );
  }
}

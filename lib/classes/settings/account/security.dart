import 'package:Vanto/classes/reusable/settings/authveri.dart';
import 'package:Vanto/classes/reusable/settings/group.dart';
import 'package:Vanto/classes/reusable/settings/item.dart';
import 'package:Vanto/classes/settings/account/delete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../locale.dart';

// ignore: must_be_immutable
class SecurityDetails extends StatefulWidget {
  @override
  _SecurityDetailsState createState() => _SecurityDetailsState();
}

class _SecurityDetailsState extends State<SecurityDetails> {
  String name;
  bool loading;

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
        middle: Text(Translation.of(context).hermesSecurity),
        previousPageTitle: 'Hermes',
      ),
      child: Container(
        padding: EdgeInsets.only(top: 75.0),
        child: Column(
          children: <Widget>[
            SettingsGroup(
              <Widget>[
                SettingsItem(
                  type: SettingsItemType.modal,
                  label: Translation.of(context).generalPassword,
                  onPress: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => AuthVeri(
                            route: ChangePasswordPage(),
                          ))),
                  hasDetails: true,
                ),
              ],
            ),
            SettingsGroup(
              <Widget>[
                SettingsItem(
                  type: SettingsItemType.modal,
                  label: Translation.of(context).hermesDestroyTitle,
                  onPress: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => AuthVeri(
                            route: DeleteAccount(),
                          ))),
                  hasDetails: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String _password;
  bool loading;
  String _errorMessage;

  @override
  void initState() {
    super.initState();
    setState(() {

    });
  }
  void func() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _errorMessage = '';
      loading = true;
    });
    try {
      if (_password != null) {
        var result = user.updatePassword(_password);
        Navigator.pop(context);
      }
    } catch (e) {

      setState(() {
        _errorMessage = e.message;
        loading = false;
        showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(Translation.of(context).generalError,
                  style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      letterSpacing: -0.5,
                      fontSize: 17.0)),
              content: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    _errorMessage ?? '',
                    style: TextStyle(
                        fontFamily: 'SF Pro Display', fontSize: 15.0),
                  )),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Reîncearcă',
                      style: TextStyle(
                          fontFamily: 'SF Pro Display', fontSize: 17.0)),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Autentificare'),
        ),
        child: SafeArea(
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 80.0),
                  child: Text('Creați o parolă nouă',
                      style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 40.0,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    child:
                    Text('Parola dumneavoastră trebuie să aibă minimum 6 caractere.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17.0,
                          color: CupertinoColors.inactiveGray,
                        ))),
                Container(
                    padding: EdgeInsets.only(top: 90.0, left: 20.0, right: 20.0),
                    child: CupertinoTextField(
                      maxLines: 1,
                      cursorColor: CupertinoColors.activeGreen,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: CupertinoTheme.of(context).primaryContrastingColor,
                        fontSize: 20.0,
                      ),
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                      ),
                      placeholder: 'Parolă',
                      onChanged: (value) => _password = value,
                    )),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height - 480),
                  child: loading != true
                      ? CupertinoButton(
                    color: Colors.green,
                    onPressed: func,
                    child: Stack(
                      children: <Widget>[
                        Text('Continuă',
                            style: TextStyle(
                                fontSize: 17.0,
                                color: CupertinoTheme.of(context)
                                    .scaffoldBackgroundColor,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  )
                      : CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(CupertinoColors.activeGreen),
                  ),
                )
              ],
            )));
  }
}

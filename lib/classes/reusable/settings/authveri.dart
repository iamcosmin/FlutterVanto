import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../locale.dart';
import '../trailing.dart';

class AuthVeri extends StatefulWidget {
  AuthVeri({
    @required this.route,
  });
  // loading in function must be passed
  final Widget route;

  @override
  _AuthVeriState createState() => _AuthVeriState();
}

class _AuthVeriState extends State<AuthVeri> {
  String _password;
  bool loading = false;

  void func() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Translation translation = await Translation.of(context);
    try {
      if (_password != null) {
        setState(() {
          loading = true;
        });
        AuthResult result = await user.reauthenticateWithCredential(
          EmailAuthProvider.getCredential(
            email: user.email,
            password: _password,
          ),
        );
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (context) => widget.route));
      }
    } catch (e) {
      setState(() {
        loading = false;
        showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
                  title: Text(translation.generalError,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          letterSpacing: -0.5,
                          fontSize: 17.0)),
                  content: Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        e.message ??
                            '',
                        style: TextStyle(
                            fontFamily: 'Inter', fontSize: 15.0),
                      )),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text(translation.generalRetry,
                          style: TextStyle(
                              fontFamily: 'Inter', fontSize: 17.0)),
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
          previousPageTitle: Translation.of(context).navigationBack,
          backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
          trailing: TrailingHelper(
            generate: func,
            last: false,
            loader: loading,
          ),
        ),
        child: SafeArea(
            child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 80.0),
              child: Text(Translation.of(context).hermesReAuthTitle,
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ),
            Container(
                width: MediaQuery.of(context).size.width - 40.0,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child:
                    Text(Translation.of(context).hermesReAuthSubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17.0,
                          color: CupertinoColors.inactiveGray,
                        ))),
            Container(
                padding: EdgeInsets.only(top: 90.0, left: 20.0, right: 20.0),
                child: CupertinoTextField(
                  autocorrect: true,
                  keyboardAppearance: Brightness.dark,
                  maxLines: 1,
                  cursorColor: CupertinoColors.activeGreen,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  style: TextStyle(
                    color: CupertinoTheme.of(context).primaryContrastingColor,
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                  prefix: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                  ),
                  placeholder: Translation.of(context).generalPassword,
                  onChanged: (value) => _password = value,
                )),
          ],
        )));
  }
}

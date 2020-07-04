import 'package:Vanto/classes/authentication/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../locale.dart';
import '../../reusable/trailing.dart';

class DeleteAccount extends StatefulWidget {
  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool loading;
  String _errorMessage;
  String _confirmation;

  void func() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Translation translation = Translation.of(context);
    setState(() {
      _errorMessage = '';
      loading = true;
    });
    try {
      if (_confirmation == 'CONFIRM') {
        var firestore = Firestore.instance
            .collection('users')
            .document(user.email)
            .delete()
            .catchError((e) => print(e));
        var result = user.delete();
        Navigator.popUntil(context, ModalRoute.withName('/'));
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
              builder: (BuildContext context) => LoginSignupPage()),
          ModalRoute.withName('/'),
        );
      } else {
        setState(() {
          loading = false;
        });
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
                        translation.errorBadTyping,
                        style: TextStyle(fontFamily: 'Inter', fontSize: 15.0),
                      )),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text(Translation.of(context).generalRetry,
                          style:
                              TextStyle(fontFamily: 'Inter', fontSize: 17.0)),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ));
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.message;
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
                        _errorMessage ?? '',
                        style: TextStyle(fontFamily: 'Inter', fontSize: 15.0),
                      )),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text(translation.generalRetry,
                          style:
                              TextStyle(fontFamily: 'Inter', fontSize: 17.0)),
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
        backgroundColor: CupertinoColors.black,
        trailing: TrailingHelper(
          last: true,
          generate: func,
          loader: loading,
        ),
      ),
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 80.0),
              child: Text(Translation.of(context).hermesDestroyTitle,
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ),
            Container(
                width: MediaQuery.of(context).size.width - 40.0,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Text(
                    Translation.of(context).hermesDestroySubtitle,
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
                  placeholder: 'Type \'CONFIRM\'',
                  onChanged: (value) => _confirmation = value,
                )),
          ],
        ),
      ),
    );
  }
}

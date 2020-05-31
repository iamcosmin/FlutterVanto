import 'package:Vanto/classes/authentication/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    setState(() {
      _errorMessage = '';
      loading = true;
    });
    try {
      if (_confirmation == 'CONFIRM') {
        var firestore = Firestore.instance.collection('users').document(user.email).delete();
        var result = user.delete();
        Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (BuildContext context) => LoginSignupPage()),
          ModalRoute.withName('/'),);
      } else {
        setState(() {
          loading = false;
        });
        showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text('Eroare!',
                  style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      letterSpacing: -0.5,
                      fontSize: 17.0)),
              content: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Ai scris greșit \'CONFIRM\'!',
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
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.message;
        loading = false;
        showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text('Eroare!',
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
          middle: Text('Șterge Cont'),
        ),
        child: SafeArea(
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 80.0),
                  child: Text('Ștergere cont',
                      style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 40.0,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    child:
                    Text('Această procedură șterge contul din baza de date și este ireversibilă! Pentru a continua, scrieți \'CONFIRM\' în căsuța de mai jos.',
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
                      ),
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                      ),
                      placeholder: '...',
                      onChanged: (value) => _confirmation = value,
                    )),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height - 480),
                  child: loading != true
                      ? CupertinoButton(
                    color: CupertinoColors.destructiveRed,
                    onPressed: func,
                    child: Stack(
                      children: <Widget>[
                        Text('ȘTERGE CONTUL',
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

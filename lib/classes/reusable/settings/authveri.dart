import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthVeri extends StatefulWidget {
  AuthVeri(
      {@required this.route,});
  // loading in function must be passed
  final Widget route;

  @override
  _AuthVeriState createState() => _AuthVeriState();
}

class _AuthVeriState extends State<AuthVeri> {
  String _password;
  bool loading = false;
  String _errorMessage;

  void func() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _errorMessage = '';
      loading = true;
    });
    try {
      if (_password != null) {
        AuthResult result = await user.reauthenticateWithCredential(
            EmailAuthProvider.getCredential(
              email: user.email,
              password: _password,
            )
        );
        Navigator.pushReplacement(context, CupertinoPageRoute(
            builder: (context) => widget.route
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
                    _errorMessage ?? 'Introdu-ți emailul!',
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
          previousPageTitle: 'Înapoi',
          backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        ),
        child: SafeArea(
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 80.0),
                  child: Text('Reintroduceți parola',
                      style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 40.0,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    child:
                    Text('Pentru a continua, vă rugăm reintroduceți-vă parola.',
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
                    color: CupertinoColors.activeGreen,
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

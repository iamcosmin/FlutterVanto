import 'login.dart';
import 'package:flutter/cupertino.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({this.loginCallback});

  final VoidCallback loginCallback;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: 20.0, left: 20, right: 20,),
          alignment: Alignment.bottomCenter,
            color: CupertinoColors.black,
            child: CupertinoButton(
              child: Text(
                  'Să începem!',
                  style: TextStyle(color: CupertinoColors.white, fontSize: 18.0, fontWeight: FontWeight.w300),
              ),
              minSize: 10.0,
              color: CupertinoColors.systemBlue,
              onPressed: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => LoginSignupPage(
                            loginCallback: loginCallback,
                          ))),
            )),
      ),
    );
  }
}

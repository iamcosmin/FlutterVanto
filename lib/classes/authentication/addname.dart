import 'package:Vanto/classes/reusable/trailing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../locale.dart';
import 'addpicture.dart';

class CreateNamePage extends StatefulWidget {
  @override
  _CreateNamePageState createState() => _CreateNamePageState();
}

class _CreateNamePageState extends State<CreateNamePage> {
  bool loading = false;
  String name;

  void func() async {
      if (name != null) {
        setState(() {
          loading = true;
        });
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        UserUpdateInfo updateInfo = UserUpdateInfo();
        updateInfo.displayName = name;
        await user.updateProfile(updateInfo);
        await user.reload();
        user = await FirebaseAuth.instance.currentUser();
        name = user.displayName;
        Navigator.push(context, CupertinoPageRoute(
            builder: (context) => CreatePicturePage()
        ));
      }
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: TrailingHelper(generate: func, loader: loading, last: false),
        backgroundColor: Color(0xFF000000),
      ),
        child: SafeArea(
            child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 80.0),
              child: Text(Translation.of(context).setupNameTitle,
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ),
            Container(
                width: MediaQuery.of(context).size.width - 40.0,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child:
                    Text(Translation.of(context).setupNameSubtitle,
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
                  keyboardType: TextInputType.text,
                  cursorColor: CupertinoColors.activeGreen,
                  autofocus: false,
                  style: TextStyle(
                    color: CupertinoTheme.of(context).primaryContrastingColor,
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                  prefix: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                  ),
                  placeholder: Translation.of(context).generalName,
                  onChanged: (value) => name = value,
                )),
          ],
        )));
  }
}

import 'package:Vanto/classes/reusable/settings/group.dart';
import 'package:Vanto/tools/touch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../locale.dart';

// ignore: must_be_immutable
class ChangeNamePage extends StatefulWidget {
  @override
  _ChangeNamePageState createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  String name;

  bool loading;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Text('Schimbă numele'),
            previousPageTitle: 'Detalii',
            trailing: Stack(
              children: <Widget>[
                loading != true ? TouchableOpacity(
                    onTap: () async {
                      Translation translation = Translation.of(context);
                      if (name != null) {
                        setState(() {
                          loading = true;
                        });
                        FirebaseUser user = await FirebaseAuth.instance
                            .currentUser();
                        UserUpdateInfo updateInfo = UserUpdateInfo();
                        updateInfo.displayName = name;
                        await user.updateProfile(updateInfo);
                        await user.reload();
                        user = await FirebaseAuth.instance.currentUser();
                        name = user.displayName;
                        Navigator.pop(context, name);
                      }
                      else {
                        showCupertinoDialog(
                            context: context, builder: (context) =>
                            CupertinoAlertDialog(
                              title: Text('Atenție!',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      letterSpacing: -0.5,
                                      fontSize: 17.0)),
                              content: Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'Introduceți-vă numele!',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 15.0),
                                  )),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: Text(translation.generalRetry,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 17.0)),
                                  onPressed: () => Navigator.pop(context),
                                  isDefaultAction: true,
                                )
                              ],
                            ));
                      }
                    },
                    child: Text('Gata',
                        style: TextStyle(
                            color: CupertinoColors.activeGreen,
                            fontSize: 17,
                            letterSpacing: -0.5))) : Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: CupertinoActivityIndicator(),
                ),
              ],
            )),
        child: Container(
            padding: EdgeInsets.only(top: 75.0),
            child: SettingsGroup(
              <Widget>[
                Container(
                  color: CupertinoTheme.of(context).primaryColor,
                  height: 40.0,
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: CupertinoTheme.of(context).primaryColor,
                    ),
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    prefix: Padding(padding: EdgeInsets.only(left: 10.0),),
                    style: TextStyle(
                      color: CupertinoTheme.of(context).primaryContrastingColor,
                      fontSize: 20.0,
                      fontFamily: 'Roboto',
                    ),
                    placeholder: 'Nume',
                    cursorColor: CupertinoColors.activeGreen,
                    onChanged: (value) => name = value,
                  ),
                )
              ],
              footer: Text(
                  'Acesta o să fie noul tău nume Hermes.'),
            )));
  }
}
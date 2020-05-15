import 'package:Vanto/classes/authentication/login.dart';
import 'package:Vanto/classes/authentication/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../reusable/settings/colors.dart';
import '../reusable/settings/group.dart';
import '../reusable/settings/item.dart';

const versionname = '5.0.8';
const versioncode = '2020050800';
const builddate = '8 mai 2020';

Future<dynamic> _signOut(context) async {
  await FirebaseAuth.instance.signOut();
}

class GeneralPage extends StatelessWidget {
  static CupertinoPageRoute<void> route() => new CupertinoPageRoute(
        title: 'General',
        builder: (BuildContext context) => GeneralPage(),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Configurări',
      ),
      child: Container(
        color: backgroundGray,
        child: ListView(
          children: <Widget>[
            SettingsGroup(
              <Widget>[
                SettingsItem(
                  label: 'Informații',
                  type: SettingsItemType.modal,
                  hasDetails: true,
                  onPress: () => Navigator.push(context, AboutPage.route()),
                ),
                SettingsItem(
                  label: 'Actualizare software',
                  type: SettingsItemType.modal,
                  hasDetails: true,
                  onPress: () => Navigator.push(context, UpdatePage.route()),
                ),
                SettingsItem(
                  label: 'Deconectare',
                  type: SettingsItemType.modal,
                  hasDetails: true,
                  onPress: () => _signOut(context),
                ),
              ],
            ),
            SettingsGroup(
              <Widget>[
                SettingsItem(
                  label: 'Magazin',
                  type: SettingsItemType.modal,
                  hasDetails: true,
                ),
                SettingsItem(
                  label: 'Muzică',
                  type: SettingsItemType.modal,
                  hasDetails: true,
                ),
                SettingsItem(
                  label: 'TV',
                  type: SettingsItemType.modal,
                  hasDetails: true,
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 11.5)),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  static CupertinoPageRoute<void> route() => new CupertinoPageRoute(
        title: 'Informații',
        builder: (BuildContext context) => AboutPage(),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'General',
        middle: Text('Despre'),
      ),
      child: Container(
        color: backgroundGray,
        child: ListView(
          children: <Widget>[
            SettingsGroup(
              <Widget>[
                SettingsItem(
                  label: 'Nume',
                  value: 'Vanto pentru Android',
                  type: SettingsItemType.modal,
                ),
                SettingsItem(
                  label: 'Versiune',
                  value: versionname,
                  type: SettingsItemType.modal,
                ),
                SettingsItem(
                  label: 'Cod',
                  value: versioncode,
                  type: SettingsItemType.modal,
                ),
                SettingsItem(
                  label: 'Data construirii',
                  value: builddate,
                  type: SettingsItemType.modal,
                ),
                SettingsItem(
                  label: 'Dispozitiv',
                  value: 'Samsung Galaxy J5 2016',
                  type: SettingsItemType.modal,
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 11.5)),
          ],
        ),
      ),
    );
  }
}

class UpdatePage extends StatelessWidget {
  static CupertinoPageRoute<void> route() => new CupertinoPageRoute(
        title: 'Actualizare software',
        builder: (BuildContext context) => UpdatePage(),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'General',
        middle: Text('Actualizare software'),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 35.0),
        color: backgroundGray,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10.0, left: 10.0),
              color: CupertinoColors.darkBackgroundGray,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: 65.0,
                    width: 65.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                          'https://cdn.iconscout.com/icon/free/png-512/settings-409-461608.png'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Vanto text',
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 3.0)),
                        Text(
                          'text',
                          style: TextStyle(
                            color: CupertinoDynamicColor.resolve(
                                CupertinoColors.secondaryLabel, context),
                            fontSize: 14.0,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 3.0)),
                        Text(
                          'Actualizare',
                          style: TextStyle(
                            color: CupertinoDynamicColor.resolve(
                                CupertinoColors.secondaryLabel, context),
                            fontSize: 14.0,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width - 30.0,
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 15.0),
                color: CupertinoColors.darkBackgroundGray,
                child: Text(
                    'Vanto ${versioncode} aduce imbunatatiri. \n \nActualizati Vanto.',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                )
            ),
            SettingsGroup(
              <Widget> [
                SettingsItem(
                  label: 'Descarcă și instalează',
                  type: SettingsItemType.modal,
                  onPress: () => launch('https://play.google.com/store/apps/details?id=com.vanto.app')
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

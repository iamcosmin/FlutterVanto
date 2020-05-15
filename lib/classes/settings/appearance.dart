import 'package:flutter/cupertino.dart';

import '../reusable/settings/colors.dart';
import '../reusable/settings/group.dart';

class AppearancePage extends StatelessWidget {
  static CupertinoPageRoute<void> route() => new CupertinoPageRoute(
    title: 'Aparență',
    builder: (BuildContext context) => AppearancePage(),
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Configurări',
        middle: Text('Aparență'),
      ),
      child: Container(
        color: backgroundGray,
        child: ListView(
          children: <Widget>[
            SettingsGroup(
              <Widget>[
              ],
            ),
          ],
        ),
      ),
    );
  }
}
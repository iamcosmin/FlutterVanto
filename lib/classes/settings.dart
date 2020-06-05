import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../locale.dart';
import 'settings/general.dart';
import 'settings/notifications.dart';
import 'reusable/settings/group.dart';
import 'reusable/settings/header.dart';
import 'reusable/settings/item.dart';

class Settings extends StatefulWidget {
  @override
  SettingsScreen createState() => SettingsScreen();
}

class SettingsScreen extends State<Settings> {

  @override
  void initState() {
    super.initState();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: 'SF Pro Display'),
        child: Container(
            color: CupertinoTheme.of(context).scaffoldBackgroundColor,
            child: CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: Text(Translation.of(context).navigationSettings),
                leading: new Container(),
              ),
              SliverSafeArea(
                top: false,
                // This is just a big list of all the items in the settings.
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      SettingsGroup(<Widget>[
                        SettingsHeader(),
                      ]),
                      SettingsGroup(<Widget>[
                        SettingsItem(
                          label: Translation.of(context).settingsAppearance,
                          iconAssetLabel: 'https://developer.apple.com/design/human-interface-guidelines/ios/images/icons/app_icons/Photos.png',
                          type: SettingsItemType.modal,
                          hasDetails: false,
                          value: MediaQuery.of(context).platformBrightness == Brightness.light ? Translation.of(context).settingsAppearanceLight : Translation.of(context).settingsAppearanceDark,
                        ),
                        SettingsItem(
                          label: Translation.of(context).settingsGeneral,
                          iconAssetLabel: 'https://developer.apple.com/design/human-interface-guidelines/ios/images/icons/app_icons/Settings.png',
                          type: SettingsItemType.modal,
                          hasDetails: true,
                          onPress: () => Navigator.push(context, CupertinoPageRoute(
                              builder: (context) => GeneralPage()
                          )),
                        ),
                      ]),
                      SettingsGroup(<Widget>[
                        SettingsItem(
                          label: Translation.of(context).settingsNotifications,
                          iconAssetLabel: 'https://developer.apple.com/design/human-interface-guidelines/ios/images/icons/app_icons/Mail.png',
                          type: SettingsItemType.modal,
                          hasDetails: true,
                          onPress: () => Navigator.push(context, CupertinoPageRoute(
                              builder: (context) => NotificationsPage()
                          )),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

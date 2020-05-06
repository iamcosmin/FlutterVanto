import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'colors.dart';
import 'cellular.dart';
import 'group.dart';
import 'header.dart';
import 'item.dart';

class Settings extends StatefulWidget {
  @override
  SettingsScreen createState() => SettingsScreen();
}

class SettingsScreen extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        color: backgroundGray,
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Settings'),
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
                        label: 'Airplane Mode',
                        iconAssetLabel: 'airplane',
                        type: SettingsItemType.toggle,
                      ),
                      SettingsItem(
                        label: 'Wi-Fi',
                        iconAssetLabel: 'wifi',
                        type: SettingsItemType.modal,
                        value: 'Airport Free',
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Bluetooth',
                        iconAssetLabel: 'bluetooth',
                        type: SettingsItemType.modal,
                        value: 'On',
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Cellular',
                        iconAssetLabel: 'cellular',
                        type: SettingsItemType.modal,
                        onPress: () => Navigator.push(context, CellularPage.route()),
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Personal Hotspot',
                        iconAssetLabel: 'hotspot',
                        type: SettingsItemType.modal,
                        value: 'Off',
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'VPN',
                        iconAssetLabel: 'vpn',
                        type: SettingsItemType.modal,
                        value: 'Not Connected',
                        hasDetails: true,
                      ),
                    ]),
                    SettingsGroup(<Widget>[
                      SettingsItem(
                        label: 'Notifications',
                        iconAssetLabel: 'notifications',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Control Center',
                        iconAssetLabel: 'control_center',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Do Not Disturb',
                        iconAssetLabel: 'disturb',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                    ]),
                    SettingsGroup(<Widget>[
                      SettingsItem(
                        label: 'General',
                        iconAssetLabel: 'general',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Display & Brightness',
                        iconAssetLabel: 'display',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Wallpaper',
                        iconAssetLabel: 'wallpaper',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Sounds & Haptics',
                        iconAssetLabel: 'sounds',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Siri & Search',
                        iconAssetLabel: 'siri',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Face ID & Passcode',
                        iconAssetLabel: 'face_id',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Emergency SOS',
                        iconAssetLabel: 'sos',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Battery',
                        iconAssetLabel: 'battery',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Privacy',
                        iconAssetLabel: 'privacy',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                    ]),
                    SettingsGroup(<Widget>[
                      SettingsItem(
                        label: 'iTunes & App Store',
                        iconAssetLabel: 'itunes',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Wallet & Apple Pay',
                        iconAssetLabel: 'wallet',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                    ]),
                    SettingsGroup(<Widget>[
                      SettingsItem(
                        label: 'Accounts & Passwords',
                        iconAssetLabel: 'accounts',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Contacts',
                        iconAssetLabel: 'contacts',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                      SettingsItem(
                        label: 'Calendar',
                        iconAssetLabel: 'calendar',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

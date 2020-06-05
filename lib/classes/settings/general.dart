import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';

import '../../locale.dart';
import '../reusable/settings/group.dart';
import '../reusable/settings/item.dart';

const versionname = '6.0.0';
const versioncode = '2020052900';
const builddate = '29 mai 2020';

DeviceInfoPlugin deviceInfo =
    DeviceInfoPlugin(); // instantiate device info plugin
AndroidDeviceInfo androidDeviceInfo;

class GeneralPage extends StatefulWidget {
  @override
  _GeneralPageState createState() => _GeneralPageState();
}


class _GeneralPageState extends State<GeneralPage> {

  @override
  void initState() {
    super.initState();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: Translation.of(context).navigationSettings,
        middle: Text(Translation.of(context).settingsGeneral),
      ),
      child: Container(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: <Widget>[
            SettingsGroup(
              <Widget>[
                SettingsItem(
                  label: Translation.of(context).settingsGeneralInfo,
                  type: SettingsItemType.modal,
                  hasDetails: true,
                  onPress: () => Navigator.push(context, AboutPage.route()),
                ),
                SettingsItem(
                  label: Translation.of(context).settingsGeneralUpdates,
                  type: SettingsItemType.modal,
                  hasDetails: true,
                  onPress: () => Navigator.push(context, UpdatePage.route()),
                ),
              ],
            ),
            SettingsGroup(
              <Widget>[
                SettingsItem(
                  label: 'Magazin',
                  type: SettingsItemType.modal,
                  hasDetails: false,
                ),
                SettingsItem(
                  label: 'TV',
                  type: SettingsItemType.modal,
                  hasDetails: false,
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

class AboutPage extends StatefulWidget {
  static CupertinoPageRoute<void> route() => new CupertinoPageRoute(
        title: 'Informații',
        builder: (BuildContext context) => AboutPage(),
      );

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String model;
  String product;
  void getDeviceinfo() async {
    androidDeviceInfo = await deviceInfo
        .androidInfo; // instantiate Android Device Infoformation

    setState(() {
      model = androidDeviceInfo.model;
      product = androidDeviceInfo.brand;
    });
  }

  @override
  void initState() {
    super.initState();
    getDeviceinfo();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'General',
        middle: Text('Despre'),
      ),
      child: Container(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor ,
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
                  value: '$model ($product)',
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
      child: SafeArea(
        child: Container(
            padding: EdgeInsets.only(top: 35.0),
            color: CupertinoTheme.of(context).scaffoldBackgroundColor ,
            child: Center(
                child: Column(
              children: <Widget>[
                Text('Vanto $versionname.',
                    style: TextStyle(
                        color: CupertinoColors.inactiveGray, fontSize: 17)),
                Text('Căutați actualizări în Google Play.',
                    style: TextStyle(
                        color: CupertinoColors.inactiveGray, fontSize: 17))
              ],
            ))),
      ),
    );
  }
}

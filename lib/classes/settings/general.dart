import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';

import '../../locale.dart';
import '../reusable/settings/group.dart';
import '../reusable/settings/item.dart';


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
  String appName;
  String buildNumber;
  String packageName;
  String version;

  void getDeviceInfo() async {
    androidDeviceInfo = await deviceInfo
        .androidInfo; // instantiate Android Device Infoformation

    setState(() {
      model = androidDeviceInfo.model;
      product = androidDeviceInfo.brand;
    });
  }

  void getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      buildNumber = packageInfo.buildNumber;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
    });
  }

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
    getPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: Translation.of(context).settingsGeneral,
        middle: Text(Translation.of(context).settingsGeneralInfo),
      ),
      child: Container(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor ,
        child: ListView(
          children: <Widget>[
            SettingsGroup(
              <Widget>[
                SettingsItem(
                  label: Translation.of(context).infoName,
                  value: appName,
                  type: SettingsItemType.modal,
                ),
                SettingsItem(
                  label: Translation.of(context).infoVersion,
                  value: version,
                  type: SettingsItemType.modal,
                ),
                SettingsItem(
                    label: Translation.of(context).infoCode,
                    value: buildNumber,
                    type: SettingsItemType.modal,
                  ),
                SettingsItem(
                  label: Translation.of(context).infoPackage,
                  value: packageName,
                  type: SettingsItemType.modal,
                ),
                SettingsItem(
                  label: Translation.of(context).infoDevice,
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
        previousPageTitle: Translation.of(context).settingsGeneral,
        middle: Text(Translation.of(context).settingsGeneralUpdates),
      ),
      child: SafeArea(
        child: Container(
            padding: EdgeInsets.only(top: 35.0),
            color: CupertinoTheme.of(context).scaffoldBackgroundColor ,
            child: Center(
                child: Column(
              children: <Widget>[
                Text('Vanto',
                    style: TextStyle(
                        color: CupertinoColors.inactiveGray, fontSize: 17)),
                Text(Translation.of(context).updateNotice,
                    style: TextStyle(
                        color: CupertinoColors.inactiveGray, fontSize: 17))
              ],
            ))),
      ),
    );
  }
}

import 'dart:io';

import 'package:Vanto/classes/reusable/settings/colors.dart';
import 'package:Vanto/classes/reusable/settings/group.dart';
import 'package:Vanto/classes/reusable/settings/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AccountManager extends StatefulWidget {
  AccountManager({Key key, this.name}) : super(key: key);
  final name;
  static CupertinoPageRoute<void> route() => new CupertinoPageRoute(
        title: 'Aparență',
        builder: (BuildContext context) => AccountManager(),
      );
  @override
  _AccountManagerState createState() => _AccountManagerState();
}

class _AccountManagerState extends State<AccountManager> {
  Future<dynamic> _signOut(context) async {
    await FirebaseAuth.instance.signOut();
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text('Atenție!'),
              content: Text('Pentru a continua, vă rugăm reporniți aplicația!'),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context),
                  child: GestureDetector(
                    child: Text('Ok'),
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Configurări',
        middle: Text('Hermes'),
      ),
      child: Container(
        color: backgroundGray,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FutureBuilder(
                    future: FirebaseAuth.instance.currentUser(),
                    builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                              child: CircleAvatar(
                                backgroundColor: CupertinoColors.darkBackgroundGray,
                                radius: 60.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60.0),
                                  child: Column(
                                    children: <Widget>[
                                      snapshot.data.photoUrl != null ? Image.network(
                                          snapshot.data.photoUrl) : Center(child: Text('')),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                                snapshot.data.displayName != null
                                    ? snapshot.data.displayName
                                    : 'Nume Nesetat',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: CupertinoColors.white,
                                )),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                  snapshot.data.email != null
                                      ? snapshot.data.email
                                      : 'Ceva merge rău. Contactați administratorul.',
                                  style: TextStyle(
                                    color: CupertinoColors.inactiveGray,
                                  )),
                            )
                          ],
                        );
                      } else {
                        return CupertinoActivityIndicator();
                      }
                    }),
              ],
            ),
            SettingsGroup(
              <Widget>[
                SettingsItem(
                    type: SettingsItemType.modal,
                    label: 'Detalii Profil',
                    hasDetails: true,
                    onPress: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ProfileDetails()))),
                SettingsItem(
                    type: SettingsItemType.modal,
                    label: 'Parolă și Securitate'),
              ],
            ),
            SettingsGroup(<Widget>[
              SettingsItem(
                label: 'Deconectare',
                type: SettingsItemType.modal,
                hasDetails: true,
                onPress: () => _signOut(context),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  String name;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Hermes',
        middle: Text('Detalii Profil'),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: 60.0,
        ),
        child: FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    SettingsGroup(
                      <Widget>[
                        SettingsItem(
                          label: '${snapshot.data.displayName}',
                          type: SettingsItemType.modal,
                          hasDetails: true,
                          onPress: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ChangeNamePage(),
                              )),
                        ),
                      ],
                      header: Text('NUME'),
                    ),
                    SettingsGroup(
                      <Widget>[
                        SettingsItem(
                            label: 'Selectează altă fotografie de profil',
                            type: SettingsItemType.modal,
                            hasDetails: true,
                            onPress: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => ImageCapture(),
                                )))
                      ],
                      header: Text('FOTOGRAFIE DE PROFIL'),
                    )
                  ],
                );
              } else {
                return Center(child: CupertinoActivityIndicator());
              }
            }),
      ),
    );
  }
}

class ChangeNamePage extends StatelessWidget {
  String name;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Text('Schimbă numele'),
            previousPageTitle: 'Detalii',
            trailing: GestureDetector(
                onTap: () async {
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  UserUpdateInfo updateInfo = UserUpdateInfo();
                  updateInfo.displayName = name;
                  await user.updateProfile(updateInfo);
                  await user.reload();
                  user = await FirebaseAuth.instance.currentUser();
                  name = user.displayName;
                  Navigator.pop(context, name);
                },
                child: Text('Gata',
                    style: TextStyle(
                        color: CupertinoColors.systemBlue,
                        fontSize: 17,
                        letterSpacing: -0.5)))),
        child: Container(
            padding: EdgeInsets.only(top: 75.0),
            child: SettingsGroup(
              <Widget>[
                Container(
                  color: CupertinoColors.darkBackgroundGray,
                  height: 40.0,
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      color: CupertinoColors.darkBackgroundGray,
                    ),
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20.0,
                    ),
                    placeholder: '\tNume',
                    onChanged: (value) => name = value,
                  ),
                )
              ],
              footer: Text(
                  'Acesta o să fie noul tău nume Hermes.'),
            )));
  }
}

class ImageCapture extends StatefulWidget {
  static CupertinoPageRoute<void> route() => new CupertinoPageRoute(
        builder: (BuildContext context) => ImageCapture(),
      );
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  File _imageFile;
  bool selected = false;

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    _imageFile = selected;
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
          statusBarColor: CupertinoColors.black,
          toolbarColor: CupertinoColors.black,
          toolbarTitle: 'Editează Imaginea',
          toolbarWidgetColor: CupertinoColors.white,
          hideBottomControls: true,
        ));
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }



  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Detalii',
          middle: Text('Fotografie de Profil'),
          trailing: FutureBuilder(
              future: FirebaseAuth.instance.currentUser(),
              builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: GestureDetector(
                      onTap: () async {
                        final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://vanto-47ee5.appspot.com');
                        StorageUploadTask _uploadTask;
                        String filePath = 'profile/${snapshot.data.email}.png';
                        _uploadTask = _storage.ref().child(filePath).putFile(_imageFile);
                        FirebaseUser user = await FirebaseAuth.instance.currentUser();
                        UserUpdateInfo updateInfo = UserUpdateInfo();
                        String url = await _storage.ref().child(filePath).getDownloadURL();
                        updateInfo.photoUrl = url;
                        await user.updateProfile(updateInfo);
                        await user.reload();
                        Navigator.pop(context);
                      },
                      child: Text('Gata',
                          style: TextStyle(
                            color: CupertinoColors.systemBlue,
                            fontSize: 17,
                          )),
                    ),
                  );
                } else {
                  return CupertinoActivityIndicator();
                }
              }),
        ),
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.only(top: 75.0),
          child: Column(
            children: [
              if (_imageFile != null)
                CircleAvatar(
                    radius: 100.0,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.file(_imageFile)))
              else
                CircleAvatar(
                    radius: 100.0,
                    backgroundColor: CupertinoColors.darkBackgroundGray,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Center(
                          child: Text(
                            'Previzualizare',
                            style: TextStyle(
                              color: CupertinoColors.white,
                            ),
                          ),
                        ))),
              Center(
                  child: CupertinoButton(
                child:
                    Text('Alege o fotografie', style: TextStyle(fontSize: 17)),
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
              ))
            ],
          ),
        )));
  }
}

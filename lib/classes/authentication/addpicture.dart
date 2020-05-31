import 'dart:io';
import 'redirect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CreatePicturePage extends StatefulWidget {
  @override
  _CreatePicturePageState createState() => _CreatePicturePageState();
}

class _CreatePicturePageState extends State<CreatePicturePage> {
  bool loading = false;
  String name;

  /// Active image file
  File _imageFile;
  bool selected = false;
  bool loaded = false;

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
          hideBottomControls: false,
        ));
    setState(() {
      _imageFile = cropped ?? _imageFile;
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
            child: FutureBuilder(
                future: FirebaseAuth.instance.currentUser(),
                builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(
                              top: 80.0, left: 20.0, right: 20.0),
                          child: Text('Arată-ne cât ești de frumos!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width - 40.0,
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(
                                top: 20.0, left: 20.0, right: 20.0),
                            child: Text(
                                'Încarcă o imagine de profil pentru a-ți personaliza contul!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: CupertinoColors.inactiveGray,
                                ))),
                        Container(
                          padding: EdgeInsets.only(
                              top: 50.0, left: 20.0, right: 20.0),
                          child: CircleAvatar(
                              radius: 80.0,
                              backgroundColor:
                                  CupertinoTheme.of(context).primaryColor,
                              foregroundColor: CupertinoColors.white,
                              child: Stack(
                                children: <Widget>[
                                  loaded != true
                                      ? Text('Previzualizare',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                          color: CupertinoTheme.of(context).primaryContrastingColor))
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.file(_imageFile),
                                        ),
                                ],
                              )),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height - 580),
                          child: loading != true
                              ? Stack(
                                  children: <Widget>[
                                    loaded != false
                                        ? CupertinoButton(
                                            color: Colors.green,
                                            onPressed: () async {
                                              setState(() {
                                                loading = true;
                                              });
                                              final FirebaseStorage _storage =
                                                  FirebaseStorage(
                                                      storageBucket:
                                                          'gs://vanto-47ee5.appspot.com');
                                              StorageUploadTask _upload;
                                              String filePath =
                                                  'profile/${snapshot.data.email}.png';
                                              _upload = _storage
                                                  .ref()
                                                  .child(filePath)
                                                  .putFile(_imageFile);
                                              FirebaseUser user =
                                                  await FirebaseAuth.instance
                                                      .currentUser();
                                              UserUpdateInfo updateInfo =
                                                  UserUpdateInfo();
                                              String url = await _storage
                                                  .ref()
                                                  .child(filePath)
                                                  .getDownloadURL();
                                              updateInfo.photoUrl = url;
                                              await user
                                                  .updateProfile(updateInfo);
                                              await user.reload();
                                              Navigator.pushReplacement(context, CupertinoPageRoute(
                                                builder: (context) => TabNavigator()
                                              ));
                                            },
                                            child: Stack(
                                              children: <Widget>[
                                                Text('Aplică',
                                                    style: TextStyle(
                                                        fontSize: 17.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                    color: CupertinoTheme.of(context).scaffoldBackgroundColor)),
                                              ],
                                            ),
                                          )
                                        : CupertinoButton(
                                            color: Colors.green,
                                            onPressed: () =>
                                                _pickImage(ImageSource.gallery),
                                            child: Stack(
                                              children: <Widget>[
                                                Text('Alege imagine',
                                                    style: TextStyle(
                                                        fontSize: 17.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: CupertinoTheme.of(context).scaffoldBackgroundColor)),
                                              ],
                                            ),
                                          ),
                                  ],
                                )
                              : CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(CupertinoColors.activeGreen),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: Text('Nicio conexiune la internet.'));
                  }
                })));
  }
}

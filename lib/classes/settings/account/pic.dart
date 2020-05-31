import 'dart:io';

import 'package:Vanto/tools/touch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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
  bool loading = false;

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
                  return Stack(
                    children: <Widget>[
                      loading != true ? TouchableOpacity(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          final FirebaseStorage _storage = FirebaseStorage(
                              storageBucket: 'gs://vanto-47ee5.appspot.com');
                          StorageUploadTask _upload;
                          String filePath =
                              'profile/${snapshot.data.email}.png';
                          _upload = _storage
                              .ref()
                              .child(filePath)
                              .putFile(_imageFile);
                          FirebaseUser user =
                              await FirebaseAuth.instance.currentUser();
                          UserUpdateInfo updateInfo = UserUpdateInfo();
                          String url = await _storage
                              .ref()
                              .child(filePath)
                              .getDownloadURL();
                          updateInfo.photoUrl = url;
                          await user.updateProfile(updateInfo);
                          await user.reload();
                          Navigator.pop(context);
                        },
                        child: Text('Gata',
                            style: TextStyle(
                              color: CupertinoColors.activeGreen,
                              fontSize: 17,
                            )),
                      ) : Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: CupertinoActivityIndicator(),
                      )
                    ],
                  );
                } else {
                  return Text(
                      'Gata',
                      style: TextStyle(
                        color: CupertinoColors.activeGreen,
                        fontSize: 17,
                      ));
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
                    Text('Alege o fotografie', style: TextStyle(fontSize: 17, color: CupertinoColors.activeGreen,)),
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
              ))
            ],
          ),
        )));
  }
}

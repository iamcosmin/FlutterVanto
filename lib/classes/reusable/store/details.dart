import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Details extends StatelessWidget {
  final String title;
  final String image;
  final String subtitle;
  final String link;
  Details(this.title, this.image, this.subtitle, this.link);
  // receive data from the FirstScreen as a parameter
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(this.title),
        previousPageTitle: 'Înapoi',
      ),
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: 'SF Pro Display'),
        child: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: 128.0,
                      width: 128.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.0),
                        child: Image.network(
                            this.image
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 18.0)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            this.title,
                            style: TextStyle(fontSize: 24.0, color: CupertinoTheme.of(context).primaryContrastingColor , fontWeight: FontWeight.bold),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 6.0)),
                          Text(
                            this.subtitle,
                            style: TextStyle(
                              color: CupertinoDynamicColor.resolve(CupertinoColors.secondaryLabel, context),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CupertinoButton(
                                color: CupertinoColors.systemGreen,
                                minSize: 30.0,
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                borderRadius: BorderRadius.circular(32.0),
                                child: Text(
                                  'OBȚINE',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.28,
                                    color: CupertinoTheme.of(context).primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  launch(this.link);
                                },
                              ),
                              CupertinoButton(
                                color: CupertinoColors.systemGreen,
                                minSize: 30.0,
                                padding: EdgeInsets.zero,
                                borderRadius: BorderRadius.circular(32.0),
                                child: Icon(CupertinoIcons.ellipsis, color: CupertinoTheme.of(context).primaryColor),
                                onPressed: () {
                                  showCupertinoModalPopup(
                                    context: context, builder: (BuildContext context) => CupertinoActionSheet(
                                    title: Text(this.title + ' - Opțiuni'),
                                    message: Text('Alegeți o opțiune din cele de mai jos'),
                                    actions: <Widget>[
                                      CupertinoActionSheetAction(
                                        child: Text('Raportează o problemă'),
                                        onPressed: () {launch('https://t.me/iamcosmin');},
                                      )
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      child: const Text('Anulează'),
                                      isDestructiveAction: true,
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');
                                      },
                                    ),
                                  ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 28.0, bottom: 8.0),
                child: Text(
                  'USERS ALSO LIKED',
                  style: TextStyle(
                    color: Color(0xFF646464),
                    letterSpacing: -0.60,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
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








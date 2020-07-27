import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../locale.dart';
import '../trailing.dart';
import 'details.dart';

class StoreTile extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final String link;

  const StoreTile({Key key, this.image, this.title, this.subtitle, this.link})
      : super(key: key);

  @override
  _StoreTile createState() => _StoreTile();
}

class _StoreTile extends State<StoreTile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
          fontFamily: 'Inter',
          color: CupertinoTheme.of(context).primaryContrastingColor),
      child: Container(
        height: 70.0,
        padding: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        child: GestureDetector(
          child: ListTile(
            title: Text(widget.title,
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: CupertinoTheme.of(context).primaryContrastingColor,
                    fontSize: 19.0)),
            subtitle: Text(widget.subtitle,
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: CupertinoColors.inactiveGray,
                    fontSize: 16.0)),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(widget.image),
            ),
            onTap: () => CupertinoScaffold.showCupertinoModalBottomSheet(
              enableDrag: false,
              context: context,
              builder: (context, scrollController) =>
                  WebViewCreator(widget.title, widget.link),
            ),
            onLongPress: () {
              Translation translation = Translation.of(context);
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) => CupertinoActionSheet(
                  title: Text(widget.title + translation.storeSheetTitle),
                  message: Text(translation.storeSheetSubtitle),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: Text(translation.generalReport),
                      onPressed: () {
                        launch('https://t.me/iamcosmin');
                      },
                    )
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    child: Text(translation.generalCancel),
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ModdedStoreTile extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final String link;

  const ModdedStoreTile(
      {Key key, this.image, this.title, this.subtitle, this.link})
      : super(key: key);

  @override
  _ModdedStoreTile createState() => _ModdedStoreTile();
}

class _ModdedStoreTile extends State<ModdedStoreTile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
          fontFamily: 'Inter',
          color: CupertinoTheme.of(context).primaryContrastingColor),
      child: Container(
        height: 70.0,
        padding: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        child: GestureDetector(
          child: ListTile(
            title: Text(widget.title,
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: CupertinoTheme.of(context).primaryContrastingColor,
                    fontSize: 19.0)),
            subtitle: Text(widget.subtitle,
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: CupertinoColors.inactiveGray,
                    fontSize: 16.0)),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(widget.image),
            ),
            onTap: () => CupertinoScaffold.showCupertinoModalBottomSheet(
                context: context,
                builder: (context, scrollController) => Details(
                    widget.title, widget.image, widget.subtitle, widget.link)),
            onLongPress: () {
              Translation translation = Translation.of(context);
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) => CupertinoActionSheet(
                  title: Text(widget.title + translation.storeSheetTitle),
                  message: Text(translation.storeSheetSubtitle),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: Text(translation.generalReport),
                      onPressed: () {
                        launch('https://t.me/iamcosmin');
                      },
                    )
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    child: Text(translation.generalCancel),
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class WebViewCreator extends StatelessWidget {
  final String title;
  final String link;
  WebViewCreator(this.title, this.link);
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      body: CupertinoPageScaffold(
        child: SafeArea(
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: link,
            gestureNavigationEnabled: true,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          ),
        ),
        navigationBar: CupertinoNavigationBar(
            middle: Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter',
              ),
            ),
            leading: Container(),
            trailing: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Transform.rotate(
                angle: 0.8,
                child: Icon(
                  Ionicons.ios_add_circle,
                  size: 30,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            )),
      ),
    );
  }
}

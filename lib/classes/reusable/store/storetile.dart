import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'details.dart';

class StoreTile extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final String link;

  const StoreTile({Key key, this.image, this.title, this.subtitle, this.link}): super(key: key);

  @override
  _StoreTile createState() => _StoreTile();
}

class _StoreTile extends State<StoreTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(widget.image),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          widget.title,
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 25,
                          )
                      ),
                      Text(
                          widget.subtitle,
                          style: TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 20,
                          )
                      ),
                    ],
                  ),
                ],
              ),
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => Details(
                  widget.image, widget.title, widget.subtitle, widget.link
                )
              )
            ),
            onLongPress: () {
              showCupertinoModalPopup(
                context: context, builder: (BuildContext context) => CupertinoActionSheet(
                title: Text(widget.title + ' - Opțiuni'),
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
    );
  }
}
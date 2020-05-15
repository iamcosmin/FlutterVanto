import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
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
    return Container(
      height: 70.0,
      padding: EdgeInsets.only(left: 10.0, right: 10.0,),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    widget.image,
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  padding: EdgeInsets.only(top: 12.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 5.0,),
                        child: Text(widget.title,
                              style: TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 20,
                              )),
                      ),
                      Text(widget.subtitle,
                          style: TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 15,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => Details(
                    widget.title, widget.image, widget.subtitle, widget.link))),
        onLongPress: () {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
              title: Text(widget.title + ' - Opțiuni'),
              message: Text('Alegeți o opțiune din cele de mai jos'),
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: Text('Raportează o problemă'),
                  onPressed: () {
                    launch('https://t.me/iamcosmin');
                  },
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
    );
  }
}

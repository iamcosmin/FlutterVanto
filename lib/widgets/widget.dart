import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Elem extends StatefulWidget {
  final String imagine;
  final String titlu;
  final String subtitlu;
  final String tip;
  final String link;

  const Elem(
      {Key key, this.imagine, this.titlu, this.subtitlu, this.tip, this.link})
      : super(key: key);

  @override
  _StatefulStateCupertino createState() => _StatefulStateCupertino();
}

class _StatefulStateCupertino extends State<Elem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        child: Image.network(
          widget.imagine,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text(widget.titlu, style: TextStyle(color: Colors.white)),
      subtitle: Text(widget.subtitlu, style: TextStyle(color: Colors.grey)),
      trailing: Icon(
        CupertinoIcons.add_circled_solid,
        color: CupertinoColors.systemBlue,
        size: 30,
      ),
      onTap: () {
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
                  title: Text(
                    widget.titlu,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  message: Text('Selectează dintre opțiunile de mai jos!'),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: Text(widget.tip),
                      onPressed: () => {
                        Navigator.of(context, rootNavigator: true).pop(),
                        launch(widget.link)
                      },
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    isDefaultAction: true,
                    isDestructiveAction: true,
                    child: Text('Anulează'),
                    onPressed: () =>
                        {Navigator.of(context, rootNavigator: true).pop()},
                  ),
                ));
      },
    );
  }
}

class Div extends StatefulWidget {
  const Div({
    Key key,
  }) : super(key: key);

  @override
  _StatefulStateCupertinoTwo createState() => _StatefulStateCupertinoTwo();
}

class _StatefulStateCupertinoTwo extends State<Div> {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey,
      height: 3,
      indent: 10,
      endIndent: 10,
    );
  }
}

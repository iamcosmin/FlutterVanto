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
  _Elem createState() => _Elem();
}

class _Elem extends State<Elem> {
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
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Detaile()));
      },
    );
  }
}

class Detaile extends StatelessWidget {
  // receive data from the FirstScreen as a parameter
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Hi!'),
      ),
      child: Text('Hello'),
    );
  }
}

class Div extends StatefulWidget {
  const Div({
    Key key,
  }) : super(key: key);

  @override
  _Div createState() => _Div();
}

class _Div extends State<Div> {
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

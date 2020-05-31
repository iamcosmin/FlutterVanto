import 'package:flutter/cupertino.dart';

class CheckErrorDialog extends StatefulWidget {
  CheckErrorDialog({@required this.errorMessage});
  final String errorMessage;

  @override
  _CheckErrorDialogState createState() => _CheckErrorDialogState();
}

class _CheckErrorDialogState extends State<CheckErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Eroare!',
          style: TextStyle(
              fontFamily: 'SF Pro Display',
              letterSpacing: -0.5,
              fontSize: 17.0)),
      content: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            widget.errorMessage ?? '',
            style: TextStyle(fontFamily: 'SF Pro Display', fontSize: 15.0),
          )),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Reîncearcă',
              style: TextStyle(fontFamily: 'SF Pro Display', fontSize: 17.0)),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

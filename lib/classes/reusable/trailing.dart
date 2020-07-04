import 'package:Vanto/tools/touch.dart';
import 'package:flutter/cupertino.dart';

import '../../locale.dart';


class TrailingHelper extends StatefulWidget {
  TrailingHelper({
    @required this.generate,
    @required this.loader,
    @required this.last,
});
  final Function generate;
  final loader;
  final bool last;

  @override
  _TrailingHelperState createState() => _TrailingHelperState();
}

class _TrailingHelperState extends State<TrailingHelper> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.loader != true ? TouchableOpacity(
            onTap: widget.generate,
            child: Text(widget.last != true ? Translation.of(context).navigationNext : Translation.of(context).navigationDone,
                style: TextStyle(
                    color: CupertinoColors.activeGreen,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,))) : Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: CupertinoActivityIndicator(),
        ),
      ],
    );
  }
}

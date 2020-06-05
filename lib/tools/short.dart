import 'package:flutter/cupertino.dart';

class SliverBuilder extends StatefulWidget {

  final Widget build;
  const SliverBuilder({Key key, @required this.build}) : super(key: key);

  @override
  _SliverBuilderState createState() => _SliverBuilderState();
}

class _SliverBuilderState extends State<SliverBuilder> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(10.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return widget.build;
          },
          childCount: 1,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mgcm_tools/screens/large/DressesPageLarge.dart';
import 'package:mgcm_tools/screens/small/DressesPageSmall.dart';

class DressesPage extends StatefulWidget {
  DressesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DressesPageState createState() => _DressesPageState();
}

class _DressesPageState extends State<DressesPage> {
  @override
  Widget build(BuildContext context) {
    body:
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return DressesPageSmall(
          title: widget.title,
        );
      } else {
        return DressesPageLarge(
          title: widget.title,
        );
      }
    });
  }
}

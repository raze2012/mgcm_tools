import 'package:flutter/material.dart';
import 'package:mgcm_tools/screens/large/DressDetailPageLarge.dart';
import 'package:mgcm_tools/screens/small/DressDetailPageSmall.dart';

class DressDetailPage extends StatefulWidget {
  DressDetailPage({Key key, this.dressName}) : super(key: key);

  final String dressName;

  @override
  _DressDetailPageState createState() => _DressDetailPageState(dressName);
}

class _DressDetailPageState extends State<DressDetailPage> {

  final String dressName;

  _DressDetailPageState(this.dressName);

  @override
  Widget build(BuildContext context) {
    body:
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return DressDetailPageSmall(
          dressName: dressName,
        );
      } else {
        return DressDetailPageLarge(
          dressName: dressName,
        );
      }
    });
  }
}

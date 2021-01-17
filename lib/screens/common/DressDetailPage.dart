import 'package:flutter/material.dart';
import 'package:mgcm_tools/screens/large/DressDetailPageLarge.dart';
import 'package:mgcm_tools/screens/small/DressDetailPageSmall.dart';

class DressDetailPage extends StatefulWidget {
  DressDetailPage(this.id, this.dressName, {Key key}) : super(key: key);

  final int id;
  final String dressName;

  @override
  _DressDetailPageState createState() => _DressDetailPageState(id, dressName);
}

class _DressDetailPageState extends State<DressDetailPage> {
  final String dressName;
  final int id;

  _DressDetailPageState(this.id, this.dressName);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return DressDetailPageSmall(id, dressName);
      } else {
        return DressDetailPageLarge(id, dressName);
      }
    });
  }
}

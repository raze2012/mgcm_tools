import 'package:flutter/material.dart';
import 'package:mgcm_tools/screens/large/DamageCalcPageLarge.dart';
import 'package:mgcm_tools/screens/small/DamageCalcPageSmall.dart';

class DamageCalcPage extends StatefulWidget {
  DamageCalcPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DamageCalcPageState createState() => _DamageCalcPageState();
}

class _DamageCalcPageState extends State<DamageCalcPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return DamageCalcPageSmall(
          title: widget.title,
        );
      } else {
        return DamageCalcPageLarge(
          title: widget.title,
        );
      }
    });
  }
}

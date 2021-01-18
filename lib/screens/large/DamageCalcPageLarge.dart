import 'package:flutter/material.dart';
import 'package:mgcm_tools/nav/routeConsts.dart';
import 'package:mgcm_tools/widgets/common/AppDrawer.dart';
import 'package:mgcm_tools/widgets/common/WebAppBar.dart';

class DamageCalcPageLarge extends StatefulWidget {
  DamageCalcPageLarge({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DamageCalcPageLargeState createState() => _DamageCalcPageLargeState();
}

class _DamageCalcPageLargeState extends State<DamageCalcPageLarge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: new AppDrawer(
          currentRoute: DamageCalcRoute,
        ),
        appBar: WebAppBar(DamageCalcRoute),
        body: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1200),
                child: ListView(
                  children: [],
                ))));
  }
}

import 'package:flutter/material.dart';
import 'package:mgcm_tools/nav/routeConsts.dart';
import 'package:mgcm_tools/widgets/common/AppDrawer.dart';
import 'package:mgcm_tools/widgets/common/ComboSliderInt.dart';
import 'package:mgcm_tools/widgets/common/ComboSliderPercent.dart';

class DamageCalcPageSmall extends StatefulWidget {
  DamageCalcPageSmall({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DamageCalcPageSmallState createState() => _DamageCalcPageSmallState();
}

class _DamageCalcPageSmallState extends State<DamageCalcPageSmall> {
  double _atk = 1200;
  double _passiveBonus = 0;
  double _skillEnhanceBonus = 0;
  double _critBonus = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: new AppDrawer(
          currentRoute: DamageCalcRoute,
        ),
        appBar: AppBar(
          title: Text("Damage Calculator"),
        ),
        body: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ComboSliderInt("Attack", _atk, 100, 5000, (value) {
                        setState(() {
                          _atk = value;
                        });
                      }),
                      ComboSliderPercent("Passive bonus damage", _passiveBonus, 0, 300, (value) {
                        setState(() {
                          _passiveBonus = value;
                        });
                      }),
                      ComboSliderPercent("Skill Enhance Bonus", _skillEnhanceBonus, 0, 100, (value) {
                        setState(() {
                          _skillEnhanceBonus = value;
                        });
                      }),
                      ComboSliderPercent("Critical Damage Bonus", _critBonus, 0, 100, (value) {
                        setState(() {
                          _critBonus = value;
                        });
                      })
                    ],
                  ),
                ))));
  }
}

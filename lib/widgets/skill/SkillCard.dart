import 'package:flutter/material.dart';
import 'package:mgcm_tools/model/DressSkill.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';
import 'package:mgcm_tools/widgets/common/SilverGridDelegateCustomHeight.dart';

class SkillCard extends StatelessWidget {
  final DressSkill skill;

  SkillCard(this.skill);

  List<Widget> recastWidget(BuildContext context) {
    var header = Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        color: Theme.of(context).accentColor,
        child: Text(
          "Recast turns",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
        ));

    Widget emptyChild = Center(
      child: Text(
        "None",
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );

    Widget fillChild = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "Min: " + skill.recastMin.toString(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              "Max: " + skill.recastMax.toString(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          )
        ]);

    Widget base;
    base = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Colors.black,
              width: 1,
            )),
        child: skill.recastMax < 2 ? emptyChild : fillChild,
      ),
    );
    return [header, Padding(padding: EdgeInsets.symmetric(vertical: 2)), base];
  }

  List<Widget> enhanceTable(BuildContext context, List<SkillEnhance> enhances) {
    bool exist = false;
    for (var enhance in enhances) exist = exist || enhance.exists;

    if (!exist) return [SizedBox.shrink()];

    var enhanceWidgets = enhances.map<Widget>((enhance) {
      return Visibility(
        visible: enhance.exists,
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 75,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      )),
                  child: Text(
                    "Lv. " + (enhances.indexOf(enhance) + 2).toString(),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        )),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          enhance.effect == null ? "" : enhance.effect,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });

    return enhanceWidgets.toList();
  }

  Color getColorMod(int index, int columnCount, bool hasSpecialMod) {
    if (hasSpecialMod && index == 3) return Colors.green;

    return index < columnCount ? Colors.blue : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    if (skill == null) return SizedBox.shrink();

    List<SkillEnhance> enhances = [
      skill.skillUp2,
      skill.skillUp3,
      skill.skillUp4,
      skill.skillUp5,
      skill.skillUp6,
      skill.skillUp7,
      skill.skillUp8,
    ];

    String skillImgName = skill.kind.toString() + "_" + skill.skillID.toString();

    bool hasSpecialMod = false;

    List<String> info = [
      "Hit Count",
      "Mod",
      "Mod * Hit",
      skill.numHits.toString(),
      skill.skillMod >= 0 ? skill.skillMod.toStringAsFixed(1) : "--",
      skill.skillMod >= 0 ? (skill.skillMod * skill.numHits).toStringAsFixed(1) : "--"
    ];

    if (skill.hpMod != 0) {
      info.insert(3, "HP Mod");
      info.add(skill.hpMod > 0 ? skill.hpMod.toStringAsFixed(2) : "--");
      hasSpecialMod = true;
    }
    if (skill.defMod != 0) {
      info.insert(3, "DEF Mod");
      info.add(skill.defMod > 0 ? skill.defMod.toStringAsFixed(1) : "--");
      hasSpecialMod = true;
    }
    if (skill.spdMod != 0) {
      info.insert(3, "SPD Mod");
      info.add(skill.spdMod > 0 ? skill.spdMod.toStringAsFixed(1) : "--");
      hasSpecialMod = true;
    }
    if (skill.enemyHPMod != 0) {
      info.insert(3, "Enemy HP Mod");
      info.add(skill.enemyHPMod > 0 ? skill.enemyHPMod.toStringAsFixed(2) : "--");
      hasSpecialMod = true;
    }
    if (skill.enemySPDMod != 0) {
      info.insert(3, "Enemy SPD Mod");
      info.add(skill.enemySPDMod > 0 ? skill.enemySPDMod.toStringAsFixed(1) : "--");
      hasSpecialMod = true;
    }

    var modColCount = info.length ~/ 2;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                color: Theme.of(context).accentColor,
                child: Text(
                  skill.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                )),
            Row(children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10),
                  child: FadeInImage(
                    image: AssetImage("assets/skill/" + skillImgName + (skill.kind == 3 ? "_1.png" : ".png")),
                    placeholder: AssetImage("assets/skill/placeholder.png"),
                    width: 100,
                    height: 100,
                    fadeInDuration: Duration(milliseconds: 10),
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        skill.effect,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    for (var widget in recastWidget(context)) widget,
                  ],
                ),
              ),
            ]),
            Padding(padding: EdgeInsets.all(10)),
            GridView.builder(
              shrinkWrap: true,
              primary: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              itemCount: info.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                height: 50,
                crossAxisCount: modColCount,
              ),
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: getColorMod(index, modColCount, hasSpecialMod),
                    border: Border.all(
                      color: Colors.black54,
                      width: 0.3,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    info[index],
                    style: TextStyle(color: index < modColCount ? Colors.white : Colors.black),
                  )),
                );
              },
            ),
            Padding(padding: EdgeInsets.all(10)),
            for (var widget in enhanceTable(context, enhances)) widget,
          ],
        ),
      ),
    );
  }
}

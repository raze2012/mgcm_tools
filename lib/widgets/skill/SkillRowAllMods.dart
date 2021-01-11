import 'package:flutter/material.dart';
import 'package:mgcm_tools/model/DressSkill.dart';
import 'package:mgcm_tools/screens/common/DressDetailPage.dart';
import 'package:mgcm_tools/widgets/common/SilverGridDelegateCustomHeight.dart';

class SkillRowAllMods extends StatelessWidget {
  final DressSkill skill;
  String value;

  SkillRowAllMods(this.skill);

  Color getColorMod(int index, int columnCount, bool hasSpecialMod) {
    if (hasSpecialMod && index == 3) return Colors.green;

    return index < columnCount ? Colors.blue : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    bool hasSpecialMod = false;
    String skillImgName = skill.kind.toString() + "_" + skill.skillID.toString();

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

    var columnCount = info.length ~/ 2;

    return Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DressDetailPage(dressName: skill.ownerDressName)),
            );
          },
          child: Row(children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: FadeInImage(
                  image: AssetImage("assets/skill/" + skillImgName + (skill.kind == 3 ? "_1.png" : ".png")),
                  placeholder: AssetImage("assets/skill/placeholder.png"),
                  width: 100,
                  height: 100,
                  fadeInDuration: Duration(milliseconds: 10),
                )),
            Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(5), child: Text(skill.name, textAlign: TextAlign.center)),
                    GridView.builder(
                      shrinkWrap: true,
                      primary: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      itemCount: info.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        height: 50,
                        crossAxisCount: columnCount,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: getColorMod(index, columnCount, hasSpecialMod),
                            border: Border.all(
                              color: Colors.black54,
                              width: 0.3,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            info[index],
                            style: TextStyle(color: index < columnCount ? Colors.white : Colors.black),
                          )),
                        );
                      },
                    ),
                  ],
                ))
          ])),
    );
  }

  getColor(int index, bool hasSpecialMod) {}
}

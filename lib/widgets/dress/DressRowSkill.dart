import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mgcm_tools/model/Dress.dart';
import 'package:mgcm_tools/model/DressSkill.dart';
import 'package:mgcm_tools/nav/routeConsts.dart';
import 'package:mgcm_tools/widgets/dress/SkillPopup.dart';

class DressRowSkill extends StatelessWidget {
  final Dress dress;
  DressSkill s1;
  DressSkill s2;
  DressSkill s3;
  DressSkill s4;

  DressRowSkill(this.dress) {
    var skillDB = Hive.box<DressSkill>('skills');

    s1 = skillDB.values.firstWhere((skill) => dress.skill1ID == skill.id);
    if (dress.skill2ID > 0) s2 = skillDB.values.firstWhere((skill) => dress.skill2ID == skill.id);
    if (dress.skill3ID > 0) s3 = skillDB.values.firstWhere((skill) => dress.skill3ID == skill.id);
    if (dress.skill4ID > 0) s4 = skillDB.values.firstWhere((skill) => dress.skill4ID == skill.id);
  }

  @override
  Widget build(BuildContext context) {
    List<DressSkill> skills = [s1, s2, s3, s4];

    return Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.pushNamed(
              context,
              Uri(path: DressDetailsRoute, queryParameters: {'name': dress.name.replaceAll(' ', '_')}).toString(),
            );
          },
          child: Row(children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: FadeInImage(
                  image: AssetImage("assets/dress/" + dress.id.toString() + ".png"),
                  placeholder: AssetImage("assets/dress/placeholder.png"),
                  width: 100,
                  height: 100,
                  fadeInDuration: Duration(milliseconds: 10),
                )),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: skills.map<Widget>((skill) {
                    if (skill == null)
                      return SizedBox.shrink();
                    else
                      return Padding(
                        padding: EdgeInsets.all(0),
                        child: IconButton(
                            padding: EdgeInsets.all(2),
                            icon: Image.asset(
                              getImage(skill),
                              width: 50,
                              height: 50,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                    barrierDismissible: true,
                                    opaque: false,
                                    pageBuilder: (context, _, __) => AlertDialog(
                                            content: SkillPopup(
                                          imgDir: getImage(skill),
                                          name: skill.name,
                                          desc: skill.effect,
                                        ))),
                              );
                            }),
                      );
                  }).toList()),
            )
          ])),
    );
  }

  String getImage(DressSkill skill) {
    String base = "assets/skill/" + skill.kind.toString() + "_" + skill.skillID.toString();
    String suffix = skill.kind == 3 ? "_1.png" : ".png";
    return base + suffix;
  }
}

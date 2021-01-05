import 'package:flutter/material.dart';
import 'package:mgcm_tools/model/DressSkill.dart';
import 'package:mgcm_tools/screens/DressDetailPage.dart';

class SkillRowMod extends StatelessWidget {
  final DressSkill skill;
  String skillImgName;
  String skillModText;

  SkillRowMod(this.skill) {
    skillImgName = skill.kind.toString() + "_" + skill.skillID.toString();
    skillModText = skill.skillMod < 0 ? "--" : skill.skillMod.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DressDetailPage(title: skill.ownerDressName)),
            );
          },
          child: Row(children: <Widget>[
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
                children: [
                  Text(
                    skill.name,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      skill.effect,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Text(
                skillModText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          ])),
    );
  }
}

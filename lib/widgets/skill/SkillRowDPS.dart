import 'package:flutter/material.dart';
import 'package:mgcm_tools/model/DressSkill.dart';
import 'package:mgcm_tools/nav/routeConsts.dart';

class SkillRowDPS extends StatelessWidget {
  final DressSkill skill;

  SkillRowDPS(this.skill);

  @override
  Widget build(BuildContext context) {
    String skillImgName = skill.kind.toString() + "_" + skill.skillID.toString();
    var dpsText = skill.skillMod < 0 ? "--" : (skill.skillMod * skill.numHits).toStringAsFixed(1);

    return Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.pushNamed(
              context,
              Uri(path: DressDetailsRoute, queryParameters: {'name': skill.ownerDressName.replaceAll(' ', '_')}).toString(),
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
                dpsText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          ])),
    );
  }
}

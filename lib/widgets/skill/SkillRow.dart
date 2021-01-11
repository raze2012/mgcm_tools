import 'package:flutter/material.dart';
import 'package:mgcm_tools/model/Dress.dart';
import 'package:mgcm_tools/model/DressSkill.dart';
import 'package:mgcm_tools/screens/common/DressDetailPage.dart';

class SkillRow extends StatelessWidget {
  final DressSkill skill;
  final Dress dress;

  SkillRow(this.skill, this.dress);

  @override
  Widget build(BuildContext context) {
    String skillImgName = skill.kind.toString() + "_" + skill.skillID.toString();

    return Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DressDetailPage(dressName: dress.name)),
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
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Tooltip(
                    message: dress.name,
                    child: FadeInImage(
                      image: AssetImage("assets/dress/" + dress.id.toString() + ".png"),
                      placeholder: AssetImage("assets/dress/placeholder.png"),
                      width: 50,
                      height: 50,
                      fadeInDuration: Duration(milliseconds: 10),
                    ),
                  )),
            )
          ])),
    );
  }
}

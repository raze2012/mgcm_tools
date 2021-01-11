import 'package:flutter/material.dart';
import 'package:mgcm_tools/model/DressSkill.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';
import 'package:mgcm_tools/screens/common/DressDetailPage.dart';

class SkillRowEnhance extends StatelessWidget {
  final DressSkill skill;
  String value;

  SkillRowEnhance(this.skill);

  List<Widget> recastWidget(BuildContext context) {
    var header = Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Colors.black,
              width: 1,
            )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Recast turns",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    Widget emptyChild = Center(
      child: Text(
        "None",
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.center,
      ),
    );

    Widget fillChild = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
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
      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Colors.black,
              width: 1,
            )),
        child: Padding(padding: EdgeInsets.all(5), child: skill.recastMax < 2 ? emptyChild : fillChild),
      ),
    );
    return [header, base];
  }

  List<Widget> enhanceTable(BuildContext context, List<SkillEnhance> enhances) {
    bool exist = false;
    for (var enhance in enhances) exist = exist || enhance.exists;

    if (!exist)
      return [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: Center(
              child: Text(
            "None",
            style: Theme.of(context).textTheme.headline3,
          )),
        )
      ];

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

  @override
  Widget build(BuildContext context) {
    String skillImgName = skill.kind.toString() + "_" + skill.skillID.toString();
    List<SkillEnhance> enhances = [
      skill.skillUp2,
      skill.skillUp3,
      skill.skillUp4,
      skill.skillUp5,
      skill.skillUp6,
      skill.skillUp7,
      skill.skillUp8,
    ];

    return Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DressDetailPage(dressName: skill.ownerDressName)),
            );
          },
          child: Row(children: [
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
                    Padding(padding: EdgeInsets.all(10)),
                    for (var widget in recastWidget(context)) widget,
                    Padding(padding: EdgeInsets.all(10)),
                    for (var widget in enhanceTable(context, enhances)) widget,
                    Padding(padding: EdgeInsets.all(10)),
                  ],
                ))
          ])),
    );
  }

  getColor(int index, bool hasSpecialMod) {}
}

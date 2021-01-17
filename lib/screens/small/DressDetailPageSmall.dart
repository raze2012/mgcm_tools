import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mgcm_tools/model/Dress.dart';
import 'package:mgcm_tools/model/DressSkill.dart';
import 'package:mgcm_tools/widgets/common/AppDrawer.dart';
import 'package:mgcm_tools/widgets/common/SilverGridDelegateCustomHeight.dart';
import 'package:mgcm_tools/widgets/skill/SkillCard.dart';

class DressDetailPageSmall extends StatefulWidget {
  DressDetailPageSmall(this.id,this.dressName,{Key key}) : super(key: key);

  final String dressName;
  final int id;

  @override
  _DressDetailPageStateSmall createState() => _DressDetailPageStateSmall(id,dressName);
}

class _DressDetailPageStateSmall extends State<DressDetailPageSmall> {
  Dress dress;
  DressSkill s1;
  DressSkill s2;
  DressSkill s3;
  DressSkill s4;
  final formatter = new NumberFormat("#,###");
   String dressName;
   int id;

  int _curLevel = 80;
  List<bool> _levelToggles = [false, false, false, false, false, false, true];
  List<int> _levels = [1, 30, 60, 65, 70, 75, 80];
  List<String> _stats = [];

  _DressDetailPageStateSmall(this.id,this.dressName);

  void updateStatsTable() {
    _stats.clear();
    num hp = dress.hp1 + (dress.hp80 - dress.hp1) / 79 * (_curLevel - 1);
    num atk = dress.atk1 + (dress.atk80 - dress.atk1) / 79 * (_curLevel - 1);
    num def = dress.def1 + (dress.def80 - dress.def1) / 79 * (_curLevel - 1);
    num spd = dress.spd1 + (dress.spd80 - dress.spd1) / 79 * (_curLevel - 1);

    _stats = [
      "HP",
      formatter.format(hp.round()),
      "ATK",
      formatter.format(atk.round()),
      "DEF",
      formatter.format(def.round()),
      "SPD",
      formatter.format(spd.round()),
      "FCS",
      formatter.format(dress.fcs),
      "RES",
      formatter.format(dress.res),
    ];
  }

  @override
  void initState() {
    super.initState();
    if(dressName != null) {
      dress = Hive
          .box<Dress>("dresses")
          .values
          .firstWhere((e) {
        return e.name.toLowerCase() == dressName.toLowerCase();
      }, orElse: () => null);
    }
    else
    {
      dress = Hive
          .box<Dress>("dresses")
          .values
          .firstWhere((e) {
        return e.id == id;
      }, orElse: () => null);
    }

    if (dress != null) {
      dressName = dress.name;
      id = dress.id;
      s1 = Hive.box<DressSkill>("skills").values.firstWhere((e) {
        return dress.skill1ID == e.id;
      }, orElse: () => null);

      s2 = Hive.box<DressSkill>("skills").values.firstWhere((e) {
        return dress.skill2ID == e.id;
      }, orElse: () => null);

      s3 = Hive.box<DressSkill>("skills").values.firstWhere((e) {
        return dress.skill3ID == e.id;
      }, orElse: () => null);

      s4 = Hive.box<DressSkill>("skills").values.firstWhere((e) {
        return dress.skill4ID == e.id;
      }, orElse: () => null);
    }
    updateStatsTable();
  }

  @override
  Widget build(BuildContext context) {
    if (dress == null) {
      return Scaffold(
        drawer: new AppDrawer(),
        appBar: AppBar(
          title: Text(dressName),
        ),
        body: Center(
          child: Text(
            'No Dress',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      );
    }
    return Scaffold(
        drawer: new AppDrawer(),
        appBar: AppBar(
          title: Text(dressName),
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Center(
              child: FadeInImage(
                image: AssetImage("assets/dress/" + dress.id.toString() + ".png"),
                placeholder: AssetImage("assets/dress/placeholder.png"),
                width: 200,
                height: 200,
                fadeInDuration: Duration(milliseconds: 10),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Image(
                image: AssetImage("assets/attribute/" +
                    dress.attribute.toString().toLowerCase().split('.').last.toLowerCase() +
                    ".png"),
                width: 50,
                height: 50,
              ),
              Image(image: AssetImage("assets/rarity/" + dress.rarity.toString() + ".png"), width: 50, height: 50),
              Image(
                  image: AssetImage("assets/type/" + dress.type.toString().toLowerCase() + ".png"),
                  width: 50,
                  height: 50)
            ]),
            Padding(padding: EdgeInsets.all(10)),
            Container(
                margin: EdgeInsets.all(5),
                width: double.infinity,
                color: Theme.of(context).accentColor,
                child: Text(
                  "Levels",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                )),
            Center(
              child: ToggleButtons(
                children: _levels.map((level) {
                  return Text(level.toString());
                }).toList(),
                selectedColor: Colors.blue,
                isSelected: _levelToggles,
                onPressed: (index) {
                  setState(() {
                    for (int i = 0; i < _levelToggles.length; i++) _levelToggles[i] = false;

                    _levelToggles[index] = true;
                    _curLevel = _levels[index];
                    updateStatsTable();
                  });
                },
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            GridView.builder(
              shrinkWrap: true,
              primary: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              itemCount: _stats.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                height: 50,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                bool even = index % 2 == 0;
                return Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: even ? Colors.blue : Colors.white,
                    border: Border.all(
                      color: Colors.black54,
                      width: 0.3,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    _stats[index],
                    style: Theme.of(context).textTheme.headline6.copyWith(color: even ? Colors.white : Colors.black),
                  )),
                );
              },
            ),
            Padding(padding: EdgeInsets.all(30)),
            SkillCard(s1),
            Padding(padding: EdgeInsets.all(10)),
            SkillCard(s2),
            Padding(padding: EdgeInsets.all(10)),
            SkillCard(s3),
            Padding(padding: EdgeInsets.all(10)),
            SkillCard(s4),
          ],
        ));
  }
}

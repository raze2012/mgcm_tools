import 'package:flutter/material.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';
import 'package:mgcm_tools/widgets/common/SilverGridDelegateCustomHeight.dart';
import 'package:tuple/tuple.dart';
import 'package:mgcm_tools/widgets/skill/SkillFilterModel.dart';

class SkillFilterMenu extends StatefulWidget {
  SkillFilterModel skillFilter;
  Function(SkillFilterModel) parentCallback;

  SkillFilterMenu(this.skillFilter,this.parentCallback,{Key key}): super(key: key);

  @override
  _SkillFilterMenuState createState() => _SkillFilterMenuState(skillFilter);
}

class _SkillFilterMenuState extends State<SkillFilterMenu> {

  SkillFilterModel model;
  _SkillFilterMenuState(this.model);

  List<Widget> extraDebuffs(BuildContext context, StateSetter setState) {
    var mbd = Debuff.move_gauge_down.toString();
    var moveGaugeDown = mbd.substring(mbd.indexOf('.') + 1);

    var er = Debuff.extend_recast.toString();
    var extendRecast = er.substring(mbd.indexOf('.') + 1);

    var rb = Debuff.remove_buff.toString();
    var removeBuff = rb.substring(rb.indexOf('.') + 1);

    var mgdIndex =model.debuffs.indexWhere((element) => element.item1 == moveGaugeDown);
    var erIndex =model.debuffs.indexWhere((element) => element.item1 == extendRecast);
    var rbIndex =model.debuffs.indexWhere((element) => element.item1 == removeBuff);

    Widget row = Row(
        children: [mgdIndex, erIndex, rbIndex].map((i) {
      return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Opacity(
            opacity:model.debuffs[i].item2 ? 1.0 : 0.4,
            child: RaisedButton(
              child: Text(
               model.debuffs[i].item1.replaceAll('_', ' '),
                style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              color: Colors.red,
              onPressed: () {
                setState(() {
                 model.debuffs[i] =
                      Tuple2<String, bool>(model.debuffs[i].item1, !model.debuffs[i].item2);

                 widget.parentCallback(model);
                });
              },
            ),
          ),
        ),
      );
    }).toList(growable: false));

    return [row];
  }

  List<Widget> extraBuffs(BuildContext context, StateSetter setState) {
    var mgb = Buff.move_gauge_boost.toString();
    var moveGaugeBoost = mgb.substring(mgb.indexOf('.') + 1);

    var rr = Buff.reduce_recast.toString();
    var reduceRecast = rr.substring(mgb.indexOf('.') + 1);

    var rd = Buff.remove_debuff.toString();
    var removeDebuff = rd.substring(rd.indexOf('.') + 1);

    var mgbIndex =model.buffs.indexWhere((element) => element.item1 == moveGaugeBoost);
    var rrIndex =model.buffs.indexWhere((element) => element.item1 == reduceRecast);
    var rdIndex =model.buffs.indexWhere((element) => element.item1 == removeDebuff);

    Widget row = Row(
        children: [mgbIndex, rrIndex, rdIndex].map((i) {
      return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Opacity(
            opacity:model.buffs[i].item2 ? 1.0 : 0.4,
            child: RaisedButton(
              child: Text(
               model.buffs[i].item1.replaceAll('_', ' '),
                style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              color: Colors.blue,
              onPressed: () {
                setState(() {
                 model.buffs[i] =
                      Tuple2<String, bool>(model.buffs[i].item1, !model.buffs[i].item2);
                 widget.parentCallback(model);
                });
              },
            ),
          ),
        ),
      );
    }).toList(growable: false));

    return [row];
  }

  List<Widget> makeToggles(List<Tuple2<String, bool>> stateList, String folder, void Function(void Function()) setState,
      {double scale = 1.0}) {
    List<String> names = stateList.map((e) => e.item1).toList();

    return names.map((name) {
      var idx = names.indexOf(name);
      return Opacity(
          opacity: stateList[idx].item2 ? 1 : 0.4,
          child: IconButton(
            tooltip: name.replaceAll('_', ' '),
            icon: Image.asset("assets/" + folder + "/" + name + ".png", scale: scale),
            onPressed: () {
              setState(() {
                stateList[idx] = new Tuple2<String, bool>(stateList[idx].item1, !stateList[idx].item2);
               widget.parentCallback(model);
                print(stateList);
              });
            },
            padding: EdgeInsets.all(2),
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 1,
              child: ListView(
                children: [
                  //attribute
                  Container(
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Attribute",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                      )),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: makeToggles(model.attributes, "attribute", setState)),
                  //character
                  Container(
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Character",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                      )),
                  GridView.builder(
                    padding: EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                      height: 70,
                      crossAxisCount: 3,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return makeToggles(model.characters, "character", setState)[index];
                    },
                  ),
                  //target type
                  Container(
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Target Type",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                      )),
                  GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        height: 50, crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
                    itemCount:model.targetType.length,
                    itemBuilder: (context, i) {
                      return Opacity(
                          opacity:model.targetType[i].item2 ? 1.0 : 0.4,
                          child: RaisedButton(
                            child: Text(
                             model.targetType[i].item1,
                              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                               model.targetType[i] = Tuple2<String, bool>(
                                   model.targetType[i].item1, !model.targetType[i].item2);
                               widget.parentCallback(model);
                                print(model.targetType);
                              });
                            },
                          ));
                    },
                  ),
                  //attack kind (does it hit enemy or not)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:model.attackKind.map((attackKind) {
                      int i =model.attackKind.indexOf(attackKind);
                      return Opacity(
                          opacity:model.attackKind[i].item2 ? 1.0 : 0.4,
                          child: RaisedButton(
                            child: Text(
                             model.attackKind[i].item1,
                              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.lightGreen,
                            onPressed: () {
                              setState(() {
                               model.attackKind[i] = Tuple2<String, bool>(
                                   model.attackKind[i].item1, !model.attackKind[i].item2);
                               widget.parentCallback(model);
                                print(model.attackKind);
                              });
                            },
                          ));
                    }).toList(),
                  ),
                  Container(
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Proportional Damage",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                      )),
                  GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        height: 50, crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
                    itemCount:model.specialMods.length,
                    itemBuilder: (context, i) {
                      return Opacity(
                          opacity:model.specialMods[i].item2 ? 1.0 : 0.4,
                          child: RaisedButton(
                            child: Text(
                             model.specialMods[i].item1,
                              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                               model.specialMods[i] = Tuple2<String, bool>(
                                   model.specialMods[i].item1, !model.specialMods[i].item2);
                               widget.parentCallback(model);
                                print(model.specialMods);
                              });
                            },
                          ));
                    },
                  ),
                  //buffs
                  Container(
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Buffs",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                      )),
                  GridView.builder(
                    padding: EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                      height: 30,
                      crossAxisCount: 4,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:model.buffs.length - 3,
                    itemBuilder: (context, index) {
                      return makeToggles(model.buffs, "buff_debuff", setState)[index];
                    },
                  ),
                  for (var widget in extraBuffs(context, setState)) widget,
                  //debuffs
                  Container(
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Debuffs",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                      )),
                  GridView.builder(
                    padding: EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                      height: 30,
                      crossAxisCount: 4,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:model.debuffs.length - 3,
                    itemBuilder: (context, index) {
                      return makeToggles(model.debuffs, "buff_debuff", setState)[index];
                    },
                  ),
                  for (var widget in extraDebuffs(context, setState)) widget,
                ],
              )),
          ButtonBar(
              buttonHeight: 50,
              buttonMinWidth: 100,
              buttonPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              alignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // this will take space as minimum as posible(to center)
              children: <Widget>[
                RaisedButton(
                  textTheme: ButtonTextTheme.primary,
                  color: Colors.blue,
                  child: new Text('Reset'),
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i <model.attributes.length; i++)
                       model.attributes[i] = Tuple2<String, bool>(model.attributes[i].item1, false);
                      for (int i = 0; i <model.characters.length; i++)
                       model.characters[i] = Tuple2<String, bool>(model.characters[i].item1, false);
                      for (int i = 0; i <model.targetType.length; i++)
                       model.targetType[i] = Tuple2<String, bool>(model.targetType[i].item1, false);
                      for (int i = 0; i <model.buffs.length; i++)
                       model.buffs[i] = Tuple2<String, bool>(model.buffs[i].item1, false);
                      for (int i = 0; i <model.debuffs.length; i++)
                       model.debuffs[i] = Tuple2<String, bool>(model.debuffs[i].item1, false);

                     widget.parentCallback(model);
                    });
                  },
                ),
                RaisedButton(
                    textTheme: ButtonTextTheme.primary,
                    color: Colors.blue,
                    child: new Text('Search'),
                    onPressed: () => Navigator.pop(context))
              ])
        ],
      ),
    );
  }


}

import 'package:flutter/material.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';
import 'package:mgcm_tools/screens/SkillsPage.dart';
import 'package:mgcm_tools/widgets/common/SilverGridDelegateCustomHeight.dart';
import 'package:tuple/tuple.dart';

class SkillFilterMenu extends StatefulWidget {
  SkillFilterMenu({Key key, this.parent}) : super(key: key);

  final SkillsPageState parent;

  @override
  _SkillFilterMenuState createState() => _SkillFilterMenuState();
}

class _SkillFilterMenuState extends State<SkillFilterMenu> {
  List<Widget> extraDebuffs(BuildContext context, StateSetter setState) {
    var mbd = Debuff.move_gauge_down.toString();
    var moveGaugeDown = mbd.substring(mbd.indexOf('.') + 1);

    var er = Debuff.extend_recast.toString();
    var extendRecast = er.substring(mbd.indexOf('.') + 1);

    var rb = Debuff.remove_buff.toString();
    var removeBuff = rb.substring(rb.indexOf('.') + 1);

    var mgdIndex = widget.parent.debuffs.indexWhere((element) => element.item1 == moveGaugeDown);
    var erIndex = widget.parent.debuffs.indexWhere((element) => element.item1 == extendRecast);
    var rbIndex = widget.parent.debuffs.indexWhere((element) => element.item1 == removeBuff);

    Widget row = Row(
        children: [mgdIndex, erIndex, rbIndex].map((i) {
      return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Opacity(
            opacity: widget.parent.debuffs[i].item2 ? 1.0 : 0.4,
            child: RaisedButton(
              child: Text(
                widget.parent.debuffs[i].item1.replaceAll('_', ' '),
                style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              color: Colors.red,
              onPressed: () {
                setState(() {
                  widget.parent.debuffs[i] =
                      Tuple2<String, bool>(widget.parent.debuffs[i].item1, !widget.parent.debuffs[i].item2);
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

    var mgbIndex = widget.parent.buffs.indexWhere((element) => element.item1 == moveGaugeBoost);
    var rrIndex = widget.parent.buffs.indexWhere((element) => element.item1 == reduceRecast);
    var rdIndex = widget.parent.buffs.indexWhere((element) => element.item1 == removeDebuff);

    Widget row = Row(
        children: [mgbIndex, rrIndex, rdIndex].map((i) {
      return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Opacity(
            opacity: widget.parent.buffs[i].item2 ? 1.0 : 0.4,
            child: RaisedButton(
              child: Text(
                widget.parent.buffs[i].item1.replaceAll('_', ' '),
                style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  widget.parent.buffs[i] =
                      Tuple2<String, bool>(widget.parent.buffs[i].item1, !widget.parent.buffs[i].item2);
                  widget.parent.setState(() {});
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
                widget.parent.setState(() {});
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
                      children: makeToggles(widget.parent.attributes, "attribute", setState)),
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
                      return makeToggles(widget.parent.characters, "character", setState)[index];
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
                    itemCount: widget.parent.targetType.length,
                    itemBuilder: (context, i) {
                      return Opacity(
                          opacity: widget.parent.targetType[i].item2 ? 1.0 : 0.4,
                          child: RaisedButton(
                            child: Text(
                              widget.parent.targetType[i].item1,
                              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                widget.parent.targetType[i] = Tuple2<String, bool>(
                                    widget.parent.targetType[i].item1, !widget.parent.targetType[i].item2);
                                widget.parent.setState(() {});
                                print(widget.parent.targetType);
                              });
                            },
                          ));
                    },
                  ),
                  //attack kind (does it hit enemy or not)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.parent.attackKind.map((attackKind) {
                      int i = widget.parent.attackKind.indexOf(attackKind);
                      return Opacity(
                          opacity: widget.parent.attackKind[i].item2 ? 1.0 : 0.4,
                          child: RaisedButton(
                            child: Text(
                              widget.parent.attackKind[i].item1,
                              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.lightGreen,
                            onPressed: () {
                              setState(() {
                                widget.parent.attackKind[i] = Tuple2<String, bool>(
                                    widget.parent.attackKind[i].item1, !widget.parent.attackKind[i].item2);
                                widget.parent.setState(() {});
                                print(widget.parent.attackKind);
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
                    itemCount: widget.parent.specialMods.length,
                    itemBuilder: (context, i) {
                      return Opacity(
                          opacity: widget.parent.specialMods[i].item2 ? 1.0 : 0.4,
                          child: RaisedButton(
                            child: Text(
                              widget.parent.specialMods[i].item1,
                              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                widget.parent.specialMods[i] = Tuple2<String, bool>(
                                    widget.parent.specialMods[i].item1, !widget.parent.specialMods[i].item2);
                                widget.parent.setState(() {});
                                print(widget.parent.specialMods);
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
                    itemCount: widget.parent.buffs.length - 3,
                    itemBuilder: (context, index) {
                      return makeToggles(widget.parent.buffs, "buff_debuff", setState)[index];
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
                    itemCount: widget.parent.debuffs.length - 3,
                    itemBuilder: (context, index) {
                      return makeToggles(widget.parent.debuffs, "buff_debuff", setState)[index];
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
                      for (int i = 0; i < widget.parent.attributes.length; i++)
                        widget.parent.attributes[i] = Tuple2<String, bool>(widget.parent.attributes[i].item1, false);
                      for (int i = 0; i < widget.parent.characters.length; i++)
                        widget.parent.characters[i] = Tuple2<String, bool>(widget.parent.characters[i].item1, false);
                      for (int i = 0; i < widget.parent.targetType.length; i++)
                        widget.parent.targetType[i] = Tuple2<String, bool>(widget.parent.targetType[i].item1, false);
                      for (int i = 0; i < widget.parent.buffs.length; i++)
                        widget.parent.buffs[i] = Tuple2<String, bool>(widget.parent.buffs[i].item1, false);
                      for (int i = 0; i < widget.parent.debuffs.length; i++)
                        widget.parent.debuffs[i] = Tuple2<String, bool>(widget.parent.debuffs[i].item1, false);

                      widget.parent.setState(() {});
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

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mgcm_tools/model/Dress.dart';
import 'package:mgcm_tools/nav/routeConsts.dart';
import 'package:mgcm_tools/widgets/common/AppDrawer.dart';
import 'package:mgcm_tools/widgets/common/ComboSliderInt.dart';
import 'package:mgcm_tools/widgets/common/ComboSliderPercent.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

enum DisplayType
{
  Custom,
  Dress
}

class HelperWrap {
  final String _name;
  final String _imagePath;
  DisplayType type;

  HelperWrap(this._name, this._imagePath,this.type);

  Widget makeWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          _imagePath,
          width: 30,
          height: 30,
        ),
        Expanded(child: Center(child: Text(_name)))
      ],
    );
  }

  DropdownMenuItem<HelperWrap> makeDropDown() {
    return DropdownMenuItem(
      child: makeWidget(),
      value: this,
    );
  }

  @override
  String toString() {
    return _name;
  }
}

class DamageCalcPageSmall extends StatefulWidget {
  DamageCalcPageSmall({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DamageCalcPageSmallState createState() => _DamageCalcPageSmallState();
}

class _DamageCalcPageSmallState extends State<DamageCalcPageSmall> {
  double _atk = 1200;
  double _passiveBonus = 0;
  double _skillEnhanceBonus = 0;
  double _critBonus = 0;

  HelperWrap _selectedItem;
  List<DropdownMenuItem<HelperWrap>> _dropdownItems;

  @override
  void initState() {
    var dresses = Hive.box<Dress>('dresses').values.toList(growable: false);
    _dropdownItems = [HelperWrap("Custom", 'dress/placeholder.png',DisplayType.Custom).makeDropDown()];
    _dropdownItems.addAll(dresses.map((dress) => HelperWrap(dress.name, 'assets/dress/${dress.id}.png',DisplayType.Dress).makeDropDown()));

    _selectedItem = _dropdownItems[0].value;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: new AppDrawer(
          currentRoute: DamageCalcRoute,
        ),
        appBar: AppBar(
          title: Text("Damage Calculator"),
        ),
        body: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SearchableDropdown.single(
                        value: _selectedItem,
                        items: _dropdownItems,
                        dialogBox: false,
                        isExpanded: true,
                        menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
                        onChanged: (item) {
                          setState(() {
                            _selectedItem = item;
                          });
                        },
                      ),
                      ComboSliderInt("Attack", _atk, 100, 5000, (value) {
                        setState(() {
                          _atk = value;
                        });
                      }),
                      ComboSliderPercent("Passive bonus damage", _passiveBonus, 0, 300, (value) {
                        setState(() {
                          _passiveBonus = value;
                        });
                      }),
                      ComboSliderPercent("Skill Enhance Bonus", _skillEnhanceBonus, 0, 100, (value) {
                        setState(() {
                          _skillEnhanceBonus = value;
                        });
                      }),
                      ComboSliderPercent("Critical Damage Bonus", _critBonus, 0, 100, (value) {
                        setState(() {
                          _critBonus = value;
                        });
                      })
                    ],
                  ),
                ))));
  }
}

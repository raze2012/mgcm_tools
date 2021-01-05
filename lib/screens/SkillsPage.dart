import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mgcm_tools/model/DressSort.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';
import 'package:mgcm_tools/widgets/common/AppDrawer.dart';
import 'package:mgcm_tools/widgets/skill/SkillDB.dart';
import 'package:mgcm_tools/widgets/skill/SkillFilterMenu.dart';
import 'package:tuple/tuple.dart';

class SkillsPage extends StatefulWidget {
  SkillsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SkillsPageState createState() => SkillsPageState();
}

class SkillsPageState extends State<SkillsPage> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _curQuery = "";
  SkillSort _sortBy = SkillSort.ID;
  bool _ascending = true;

  List<Tuple2<String, bool>> attributes = [
    Tuple2<String, bool>("fire", false),
    Tuple2<String, bool>("water", false),
    Tuple2<String, bool>("lightning", false),
    Tuple2<String, bool>("light", false),
    Tuple2<String, bool>("dark", false)
  ];

  List<Tuple2<String, bool>> attackKind = [
    Tuple2<String, bool>("Attack", false),
    Tuple2<String, bool>("NonAttack", false),
  ];

  List<Tuple2<String, bool>> targetType = [
    Tuple2<String, bool>("Single", false),
    Tuple2<String, bool>("Multiple", false),
    Tuple2<String, bool>("Random", false),
    Tuple2<String, bool>("All", false),
    Tuple2<String, bool>("Self", false)
  ];

  List<Tuple2<String, bool>> specialMods = [
    Tuple2<String, bool>("HP", false),
    Tuple2<String, bool>("DEF", false),
    Tuple2<String, bool>("SPD", false),
    Tuple2<String, bool>("Enemy HP", false),
    Tuple2<String, bool>("Enemy SPD", false)
  ];

  List<Tuple2<String, bool>> buffs = Buff.values.map((buff) {
    var buffString = buff.toString().substring(buff.toString().indexOf('.') + 1);
    return Tuple2<String, bool>(buffString, false);
  }).toList();

  List<Tuple2<String, bool>> debuffs = Debuff.values.map((debuff) {
    var buffString = debuff.toString().substring(debuff.toString().indexOf('.') + 1);
    return Tuple2<String, bool>(buffString, false);
  }).toList();

  List<Tuple2<String, bool>> characters = [
    Tuple2<String, bool>("iroha", false),
    Tuple2<String, bool>("kaori", false),
    Tuple2<String, bool>("seira", false),
    Tuple2<String, bool>("cocoa", false),
    Tuple2<String, bool>("akisa", false),
    Tuple2<String, bool>("ao", false),
    Tuple2<String, bool>("aka", false),
    Tuple2<String, bool>("eliza", false),
    Tuple2<String, bool>("lilly", false),
    Tuple2<String, bool>("hanabi", false),
    Tuple2<String, bool>("marianne", false),
    Tuple2<String, bool>("iko", false)
  ];

  //basic, stat, skill
  List<bool> _displayMode = [true, false, false];

  AppBar buildAppBar(BuildContext context) {
    clearSearch();
    return new AppBar(title: new Text(widget.title), actions: [searchBar.getSearchAction(context)]);
  }

  SkillsPageState() {
    searchBar = new SearchBar(
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onChanged: onChanged,
        onCleared: clearSearch,
        onClosed: clearSearch,
        hintText: "Search by skill or dress name");
  }

  void clearSearch() {
    print("cleared");
    setState(() {
      _curQuery = "";
    });
  }

  void onChanged(String text) {
    print("changed to " + text);
    setState(() {
      _curQuery = text;
    });
  }

  Widget filterBar(BuildContext context, StateSetter setState) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      DropdownButton<SkillSort>(
          value: _sortBy,
          items: SkillSort.values.toList().map<DropdownMenuItem<SkillSort>>((SkillSort value) {
            return DropdownMenuItem<SkillSort>(
                value: value,
                child: SizedBox(
                  width: 70,
                  child: Text(value.getLabel(), textAlign: TextAlign.center),
                ));
          }).toList(),
          icon: IconButton(
            icon: _ascending ? Icon(Icons.arrow_upward) : Icon(Icons.arrow_downward),
            onPressed: () {
              setState(() => _ascending = !_ascending);
            },
          ),
          elevation: 16,
          style: TextStyle(color: Colors.blueGrey),
          underline: Container(
            height: 2,
            color: Colors.blueAccent,
          ),
          onChanged: (SkillSort newValue) {
            setState(() => _sortBy = newValue);
          }),
      IconButton(
        icon: Icon(Icons.filter_list_sharp),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return Dialog(
                    insetPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: SkillFilterMenu(
                      parent: this,
                    ));
              });
            },
          );
        },
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: new AppDrawer(
          currentRoute: '/skills',
        ),
        appBar: searchBar.build(context),
        body: Column(
          children: <Widget>[
            filterBar(context, setState),
            //display buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  textTheme: ButtonTextTheme.primary,
                  child: Text("Info"),
                  color: _displayMode[0] ? Colors.blueGrey : Colors.blue,
                  onPressed: () {
                    setState(() {
                      _displayMode[0] = true;
                      _displayMode[1] = false;
                      _displayMode[2] = false;
                    });
                  },
                ),
                RaisedButton(
                  textTheme: ButtonTextTheme.primary,
                  child: Text("Enhance"),
                  color: _displayMode[1] ? Colors.blueGrey : Colors.blue,
                  onPressed: () {
                    setState(() {
                      _displayMode[0] = false;
                      _displayMode[1] = true;
                      _displayMode[2] = false;
                    });
                  },
                ),
                RaisedButton(
                  textTheme: ButtonTextTheme.primary,
                  child: Text("Skill Mod"),
                  color: _displayMode[2] ? Colors.blueGrey : Colors.blue,
                  onPressed: () {
                    setState(() {
                      _displayMode[0] = false;
                      _displayMode[1] = false;
                      _displayMode[2] = true;
                    });
                  },
                )
              ],
            ),
            //Displayed skills
            Expanded(
                child: SkillDB(
                    nameQuery: _curQuery,
                    ascending: _ascending,
                    sortBy: _sortBy,
                    attributeFilter: attributes,
                    characterFilter: characters,
                    targetFilter: targetType,
                    buffFilter: buffs,
                    debuffFilter: debuffs,
                    attackFilter: attackKind,
                    specialFilter: specialMods,
                    mode: _displayMode[0]
                        ? 0
                        : _displayMode[1]
                            ? 1
                            : 2))
          ],
        ));
  }
}

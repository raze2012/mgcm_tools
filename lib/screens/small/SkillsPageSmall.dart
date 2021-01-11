import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mgcm_tools/model/DressSort.dart';
import 'package:mgcm_tools/widgets/common/AppDrawer.dart';
import 'package:mgcm_tools/widgets/skill/SkillDB.dart';
import 'package:mgcm_tools/widgets/skill/SkillFilterMenu.dart';
import 'package:mgcm_tools/widgets/skill/SkillFilterModel.dart';

class SkillsPageSmall extends StatefulWidget {
  SkillsPageSmall({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SkillsPageSmallState createState() => SkillsPageSmallState();
}

class SkillsPageSmallState extends State<SkillsPageSmall> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  SkillFilterModel filterModel;

  AppBar buildAppBar(BuildContext context) {
    clearSearch();
    return new AppBar(title: new Text(widget.title), actions: [searchBar.getSearchAction(context)]);
  }

  SkillsPageSmallState() {
    filterModel = new SkillFilterModel();

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
      filterModel.nameQuery = "";
    });
  }

  void onChanged(String text) {
    print("changed to " + text);
    setState(() {
      filterModel.nameQuery = text;
    });
  }

  void _update() {
    setState(() {

    });
  }

  Widget filterBar(BuildContext context, StateSetter setState) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      DropdownButton<SkillSort>(
          value: filterModel.sortBy,
          items: SkillSort.values.toList().map<DropdownMenuItem<SkillSort>>((SkillSort value) {
            return DropdownMenuItem<SkillSort>(
                value: value,
                child: SizedBox(
                  width: 70,
                  child: Text(value.getLabel(), textAlign: TextAlign.center),
                ));
          }).toList(),
          icon: IconButton(
            icon: filterModel.ascending ? Icon(Icons.arrow_upward) : Icon(Icons.arrow_downward),
            onPressed: () {
              setState(() => filterModel.ascending = !filterModel.ascending);
            },
          ),
          elevation: 16,
          style: TextStyle(color: Colors.blueGrey),
          underline: Container(
            height: 2,
            color: Colors.blueAccent,
          ),
          onChanged: (SkillSort newValue) {
            setState(() => filterModel.sortBy = newValue);
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
                    child: SkillFilterMenu(filterModel, (model) {
                      _update();
                    }));
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
                  color: filterModel.displayMode[0] ? Colors.blueGrey : Colors.blue,
                  onPressed: () {
                    setState(() {
                      filterModel.displayMode[0] = true;
                      filterModel.displayMode[1] = false;
                      filterModel.displayMode[2] = false;
                    });
                  },
                ),
                RaisedButton(
                  textTheme: ButtonTextTheme.primary,
                  child: Text("Enhance"),
                  color: filterModel.displayMode[1] ? Colors.blueGrey : Colors.blue,
                  onPressed: () {
                    setState(() {
                      filterModel.displayMode[0] = false;
                      filterModel.displayMode[1] = true;
                      filterModel.displayMode[2] = false;
                    });
                  },
                ),
                RaisedButton(
                  textTheme: ButtonTextTheme.primary,
                  child: Text("Skill Mod"),
                  color: filterModel.displayMode[2] ? Colors.blueGrey : Colors.blue,
                  onPressed: () {
                    setState(() {
                      filterModel.displayMode[0] = false;
                      filterModel.displayMode[1] = false;
                      filterModel.displayMode[2] = true;
                    });
                  },
                )
              ],
            ),
            //Displayed skills
            Expanded(child: SkillDB(filterModel))
          ],
        ));
  }
}

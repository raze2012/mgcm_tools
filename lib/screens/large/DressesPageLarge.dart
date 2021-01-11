import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mgcm_tools/model/DressSort.dart';
import 'package:mgcm_tools/widgets/dress/DressDB.dart';
import 'package:mgcm_tools/widgets/common/AppDrawer.dart';
import 'package:mgcm_tools/widgets/dress/DressFilterModel.dart';
import 'package:mgcm_tools/widgets/dress/DressFilterMenu.dart';

class DressesPageLarge extends StatefulWidget {
  DressesPageLarge({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DressesPageLargeState createState() => _DressesPageLargeState();
}

class _DressesPageLargeState extends State<DressesPageLarge> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  DressFilterModel filterModel;

  AppBar buildAppBar(BuildContext context) {
    clearSearch();
    return new AppBar(title: new Text(widget.title), actions: [searchBar.getSearchAction(context)]);
  }

  _DressesPageLargeState() {
    searchBar = new SearchBar(
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onChanged: onChanged,
        onCleared: clearSearch,
        onClosed: clearSearch);

    filterModel = new DressFilterModel();
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

  void _update()
  {
    print("set state from child large");
    setState(() {

    });
  }

  Widget filterBar(BuildContext context, StateSetter setState) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      DropdownButton<DressSort>(
          value: filterModel.sortBy,
          items: DressSort.values.toList().map<DropdownMenuItem<DressSort>>((DressSort value) {
            return DropdownMenuItem<DressSort>(
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
          onChanged: (DressSort newValue) {
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
                    child: DressFilterMenu(filterModel,(model) => _update()));
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
          currentRoute: '/dresses',
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
                  child: Text("Basic"),
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
                  child: Text("Stats"),
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
                  child: Text("skills"),
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
            Expanded(child: DressDB(filterModel))
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mgcm_tools/model/DressSort.dart';
import 'package:mgcm_tools/widgets/dress/DressDB.dart';
import 'package:mgcm_tools/widgets/common/AppDrawer.dart';
import 'package:mgcm_tools/widgets/common/SilverGridDelegateCustomHeight.dart';
import 'package:tuple/tuple.dart';

class DressesPage extends StatefulWidget {
  DressesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DressesPageState createState() => _DressesPageState();
}

class _DressesPageState extends State<DressesPage> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _curQuery = "";
  DressSort _sortBy = DressSort.DressNumber;
  bool _ascending = true;

  List<Tuple2<String, bool>> _types = [
    Tuple2<String, bool>("assist", false),
    Tuple2<String, bool>("attack", false),
    Tuple2<String, bool>("guard", false),
    Tuple2<String, bool>("tank", false)
  ];

  List<Tuple2<String, bool>> _rarities = [
    Tuple2<String, bool>("UR", false),
    Tuple2<String, bool>("SR", false),
    Tuple2<String, bool>("R", false),
    Tuple2<String, bool>("N", false)
  ];

  List<Tuple2<String, bool>> _attributes = [
    Tuple2<String, bool>("fire", false),
    Tuple2<String, bool>("water", false),
    Tuple2<String, bool>("lightning", false),
    Tuple2<String, bool>("light", false),
    Tuple2<String, bool>("dark", false)
  ];

  List<Tuple2<String, bool>> _characters = [
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

  _DressesPageState() {
    searchBar = new SearchBar(
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onChanged: onChanged,
        onCleared: clearSearch,
        onClosed: clearSearch);
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

  void _refresh() {
    setState(() {});
  }

  List<Widget> makeToggles(List<Tuple2<String, bool>> stateList, String folder, void Function(void Function()) setState,
      {double scale = 1.0}) {
    List<String> names = stateList.map((e) => e.item1).toList();

    return names.map((name) {
      var idx = names.indexOf(name);
      return Opacity(
          opacity: stateList[idx].item2 ? 1 : 0.4,
          child: IconButton(
            icon: Image.asset("assets/" + folder + "/" + name + ".png", scale: scale),
            onPressed: () {
              setState(() {
                stateList[idx] = new Tuple2<String, bool>(stateList[idx].item1, !stateList[idx].item2);
                _refresh();
                print(stateList);
              });
            },
            padding: EdgeInsets.all(2),
          ));
    }).toList();
  }

  Widget filterMenu(BuildContext context, StateSetter setState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 1,
            child: ListView(
              children: [
                Container(
                    margin: EdgeInsets.all(5),
                    width: double.infinity,
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Rarity",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: makeToggles(_rarities, "rarity", setState)),
                Container(
                    margin: EdgeInsets.all(5),
                    width: double.infinity,
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Type",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                    )),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: makeToggles(_types, "type", setState)),
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
                    children: makeToggles(_attributes, "attribute", setState)),
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
                    return makeToggles(_characters, "character", setState)[index];
                  },
                )
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
                    for (int i = 0; i < _rarities.length; i++)
                      _rarities[i] = Tuple2<String, bool>(_rarities[i].item1, false);
                    for (int i = 0; i < _types.length; i++) _types[i] = Tuple2<String, bool>(_types[i].item1, false);
                    for (int i = 0; i < _attributes.length; i++)
                      _attributes[i] = Tuple2<String, bool>(_attributes[i].item1, false);
                    for (int i = 0; i < _characters.length; i++)
                      _characters[i] = Tuple2<String, bool>(_characters[i].item1, false);

                    _refresh();
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
    );
  }

  Widget filterBar(BuildContext context, StateSetter setState) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      DropdownButton<DressSort>(
          value: _sortBy,
          items: DressSort.values.toList().map<DropdownMenuItem<DressSort>>((DressSort value) {
            return DropdownMenuItem<DressSort>(
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
          onChanged: (DressSort newValue) {
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
                    child: filterMenu(context, setState));
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
                  child: Text("Stats"),
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
                  child: Text("skills"),
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
            Expanded(
                child: DressDB(
                    nameQuery: _curQuery,
                    ascending: _ascending,
                    sortBy: _sortBy,
                    rarityFilter: _rarities,
                    typeFilter: _types,
                    attributeFilter: _attributes,
                    characterFilter: _characters,
                    mode: _displayMode[0]
                        ? 0
                        : _displayMode[1]
                            ? 1
                            : 2))
          ],
        ));
  }
}

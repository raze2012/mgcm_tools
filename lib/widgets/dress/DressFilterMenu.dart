import 'package:flutter/material.dart';
import 'package:mgcm_tools/widgets/common/SilverGridDelegateCustomHeight.dart';
import 'package:mgcm_tools/widgets/dress/DressFilterModel.dart';
import 'package:tuple/tuple.dart';

class DressFilterMenu extends StatefulWidget {

  DressFilterModel model;
  Function(DressFilterModel) onUpdateCallback;

  DressFilterMenu(this.model,this.onUpdateCallback,{Key key}): super(key: key);

  @override
  _DressFilterMenuState createState() => _DressFilterMenuState(model);

}

class _DressFilterMenuState extends State<DressFilterMenu> {
  DressFilterModel model;

  _DressFilterMenuState(this.model);

  void _update()
  {
      setState(()
      {
        widget.onUpdateCallback(model);
      });
  }
  @override
  Widget build(BuildContext context) {
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
                    color: Theme
                        .of(context)
                        .accentColor,
                    child: Text(
                      "Rarity",
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: model.makeToggles(model.rarities, "rarity", setState,_update)),
                Container(
                    margin: EdgeInsets.all(5),
                    width: double.infinity,
                    color: Theme
                        .of(context)
                        .accentColor,
                    child: Text(
                      "Type",
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: model.makeToggles(model.types, "type", setState,_update)),
                Container(
                    margin: EdgeInsets.all(5),
                    width: double.infinity,
                    color: Theme
                        .of(context)
                        .accentColor,
                    child: Text(
                      "Attribute",
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                    model.makeToggles(model.attributes, "attribute", setState,_update)),
                Container(
                    margin: EdgeInsets.all(5),
                    width: double.infinity,
                    color: Theme
                        .of(context)
                        .accentColor,
                    child: Text(
                      "Character",
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    )),
                GridView.builder(
                  padding: EdgeInsets.all(5),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    height: 70,
                    crossAxisCount: 3,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return model.makeToggles(
                        model.characters, "character", setState,() => _update())[index];
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
                    for (int i = 0; i < model.rarities.length; i++)
                      model.rarities[i] =
                          Tuple2<String, bool>(model.rarities[i].item1, false);
                    for (int i = 0; i < model.types.length; i++)
                      model.types[i] =
                          Tuple2<String, bool>(model.types[i].item1, false);
                    for (int i = 0; i < model.attributes.length; i++)
                      model.attributes[i] =
                          Tuple2<String, bool>(model.attributes[i].item1, false);
                    for (int i = 0; i < model.characters.length; i++)
                      model.characters[i] =
                          Tuple2<String, bool>(model.characters[i].item1, false);

                    print("am updating");
                    widget.onUpdateCallback(model);

                  });
                },
              ),
              RaisedButton(
                  textTheme: ButtonTextTheme.primary,
                  color: Colors.blue,
                  child: new Text('Search'),
                  onPressed: () {
                    _update();
                    Navigator.pop(context);
                  }
              )
            ])
      ],
    );
  }
}

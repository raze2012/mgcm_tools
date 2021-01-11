import 'package:mgcm_tools/model/DressSort.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';

class DressFilterModel
{
    String nameQuery = "";
    DressSort sortBy = DressSort.DressNumber;
    bool ascending = true;

    List<Tuple2<String, bool>> types = [
        Tuple2<String, bool>("assist", false),
        Tuple2<String, bool>("attack", false),
        Tuple2<String, bool>("guard", false),
        Tuple2<String, bool>("tank", false)
    ];

    List<Tuple2<String, bool>> rarities = [
        Tuple2<String, bool>("UR", false),
        Tuple2<String, bool>("SR", false),
        Tuple2<String, bool>("R", false),
        Tuple2<String, bool>("N", false)
    ];

    List<Tuple2<String, bool>> attributes = [
        Tuple2<String, bool>("fire", false),
        Tuple2<String, bool>("water", false),
        Tuple2<String, bool>("lightning", false),
        Tuple2<String, bool>("light", false),
        Tuple2<String, bool>("dark", false)
    ];

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
    List<bool> displayMode = [true, false, false];

    int get mode => displayMode[0] ? 0 : displayMode[1] ? 1 : 2;
}

extension DFMUtils on DressFilterModel
{
    List<Widget> makeToggles(List<Tuple2<String, bool>> stateList, String folder, void Function(void Function()) setState, void Function() parentCallback,
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
                            print(stateList);
                            parentCallback();
                        });
                    },
                    padding: EdgeInsets.all(2),
                ));
        }).toList();
    }


}
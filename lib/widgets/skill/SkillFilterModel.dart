import 'package:mgcm_tools/model/DressSort.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';
import 'package:tuple/tuple.dart';

class SkillFilterModel
{
  String nameQuery = "";
  SkillSort sortBy = SkillSort.ID;
  bool ascending = true;

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
  List<bool> displayMode = [true, false, false];
  int get mode => displayMode[0] ? 0 : displayMode[1] ? 1 : 2;

}
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mgcm_tools/model/Dress.dart';
import 'package:mgcm_tools/model/DressSort.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';
import 'package:mgcm_tools/widgets/dress/DressRowSingleStat.dart';
import 'package:mgcm_tools/widgets/dress/DressRowSkill.dart';
import 'package:mgcm_tools/widgets/dress/DressRowStats.dart';
import 'package:tuple/tuple.dart';

import 'DressRow.dart';

class DressDB extends StatelessWidget {
  final String nameQuery;
  final DressSort sortBy;
  final bool ascending;

  //basic, stats, skills
  final int mode;
  final List<Tuple2<String, bool>> rarityFilter;
  final List<Tuple2<String, bool>> typeFilter;
  final List<Tuple2<String, bool>> attributeFilter;
  final List<Tuple2<String, bool>> characterFilter;

  const DressDB(
      {Key key,
      this.nameQuery,
      this.sortBy,
      this.ascending,
      this.rarityFilter,
      this.typeFilter,
      this.attributeFilter,
      this.characterFilter,
      this.mode})
      : super(key: key);

  int dressSort(Dress a, Dress b) {
    switch (sortBy) {
      case DressSort.DressNumber:
        return a.id - b.id;
      case DressSort.Type:
        return a.type.compareTo(b.type);
      case DressSort.Attribute:
        return a.attribute.toString().compareTo(b.attribute.toString());
      case DressSort.Name:
        return a.name.compareTo(b.name);
      case DressSort.Rarity:
        return a.rarity.compareTo(b.rarity);
      case DressSort.HP:
        return a.hp1 - b.hp1;
      case DressSort.ATK:
        return a.atk1 - b.atk1;
      case DressSort.DEF:
        return a.def1 - b.def1;
      case DressSort.SPD:
        return a.spd1 - b.spd1;
      case DressSort.FCS:
        return a.fcs - b.fcs;
      case DressSort.RES:
        return a.res - b.res;
      default:
        return -1;
    }
  }

  bool matchFilter(String prop, List<Tuple2<String, bool>> filter) {
    bool clearFilter = true;
    for (var item in filter) clearFilter = clearFilter && !item.item2;

    //return true if there's nothing to check
    if (clearFilter) return true;

    return filter.contains(Tuple2<String, bool>(prop, true));
  }

  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Dress>('dresses').listenable(),
        builder: (context, Box<Dress> box, widget) {
          Iterable<Dress> filteredBox;

          filteredBox = box.values.where((dress) {
            var nameFilter = nameQuery.isEmpty ? true : dress.name.toLowerCase().contains(nameQuery.toLowerCase());
            var propFilters = matchFilter(dress.rarity, rarityFilter) &&
                matchFilter(dress.type.toLowerCase(), typeFilter) &&
                matchFilter(dress.attribute.toName(), attributeFilter) &&
                matchFilter(dress.owner.toFirstName().toLowerCase(), characterFilter);

            return nameFilter && propFilters;
          });

          if (filteredBox.isEmpty)
            return Center(
              child: Text("No dresses"),
            );

          var dresses = filteredBox.toList();
          dresses.sort(dressSort);
          if (!ascending) dresses = dresses.reversed.toList();

          switch (mode) {
            case 0:
              switch (sortBy) {
                case DressSort.HP:
                case DressSort.ATK:
                case DressSort.DEF:
                case DressSort.SPD:
                case DressSort.FCS:
                case DressSort.RES:
                  return ListView(children: <Widget>[for (var dress in dresses) DressRowSingleStat(dress, sortBy)]);
                  break;
                default:
                  return ListView(children: <Widget>[for (var dress in dresses) DressRow(dress)]);
              }
              break;
            case 1:
              return ListView(children: <Widget>[for (var dress in dresses) DressRowStats(dress, sortBy)]);
              break;
            case 2:
              return ListView(children: <Widget>[for (var dress in dresses) DressRowSkill(dress)]);
            default:
              return ListView(children: <Widget>[for (var dress in dresses) DressRow(dress)]);
          }
        });
  }
}

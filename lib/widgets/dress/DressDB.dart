import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:mgcm_tools/model/Dress.dart';
import 'package:mgcm_tools/model/DressSort.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';
import 'package:mgcm_tools/widgets/dress/DressFilterModel.dart';
import 'package:mgcm_tools/widgets/dress/DressRowSingleStat.dart';
import 'package:mgcm_tools/widgets/dress/DressRowSkill.dart';
import 'package:mgcm_tools/widgets/dress/DressRowStats.dart';
import 'package:tuple/tuple.dart';

import 'DressRow.dart';


class DressDB extends StatelessWidget {

  final DressFilterModel filterModel;
  const DressDB(
      this.filterModel,{Key key})
      : super(key: key);

  int dressSort(Dress a, Dress b) {
    switch (filterModel.sortBy) {
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
    var dressDB = Hive.box<Dress>('dresses').values;

    var filteredDressDB = dressDB.where((dress) {
      var nameFilter = filterModel.nameQuery.isEmpty
          ? true
          : dress.name.toLowerCase().contains(filterModel.nameQuery.toLowerCase());
      var propFilters = matchFilter(dress.rarity, filterModel.rarities) &&
          matchFilter(dress.type.toLowerCase(), filterModel.types) &&
          matchFilter(dress.attribute.toName(), filterModel.attributes) &&
          matchFilter(dress.owner.toFirstName().toLowerCase(), filterModel.characters);

      return nameFilter && propFilters;
    });

    if (filteredDressDB.isEmpty)
      return Center(
        child: Text("No dresses"),
      );

    var filteredDresses = filteredDressDB.toList();
    filteredDresses.sort(dressSort);
    if (!filterModel.ascending) filteredDresses = filteredDresses.reversed.toList();

    switch (filterModel.mode) {
      case 0:
        switch (filterModel.sortBy) {
          case DressSort.HP:
          case DressSort.ATK:
          case DressSort.DEF:
          case DressSort.SPD:
          case DressSort.FCS:
          case DressSort.RES:
            return ListView(children: <Widget>[
              for (var dress in filteredDresses) DressRowSingleStat(dress, filterModel.sortBy)
            ]);
            break;
          default:
            return ListView(
                children: <Widget>[for (var dress in filteredDresses) DressRow(dress)]);
        }
        break;
      case 1:
        return ListView(children: <Widget>[
          for (var dress in filteredDresses) DressRowStats(dress, filterModel.sortBy)
        ]);
        break;
      case 2:
        return ListView(children: <Widget>[
          for (var dress in filteredDresses) DressRowSkill(dress)
        ]);
      default:
        return ListView(
            children: <Widget>[for (var dress in filteredDresses) DressRow(dress)]);
    }
  }
}

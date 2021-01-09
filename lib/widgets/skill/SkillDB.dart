import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mgcm_tools/model/Dress.dart';
import 'package:mgcm_tools/model/DressSkill.dart';
import 'package:mgcm_tools/model/DressSort.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';
import 'package:mgcm_tools/widgets/skill/SkillRow.dart';
import 'package:mgcm_tools/widgets/skill/SkillRowAllMods.dart';
import 'package:mgcm_tools/widgets/skill/SkillRowDPS.dart';
import 'package:mgcm_tools/widgets/skill/SkillRowEnhance.dart';
import 'package:mgcm_tools/widgets/skill/SkillRowHitCount.dart';
import 'package:mgcm_tools/widgets/skill/SkillRowMod.dart';
import 'package:tuple/tuple.dart';

class SkillDB extends StatelessWidget {
  final String nameQuery;
  final SkillSort sortBy;
  final bool ascending;

  //info, enhance, skill mod
  final int mode;
  final List<Tuple2<String, bool>> attributeFilter;
  final List<Tuple2<String, bool>> characterFilter;
  final List<Tuple2<String, bool>> targetFilter;
  final List<Tuple2<String, bool>> buffFilter;
  final List<Tuple2<String, bool>> debuffFilter;
  final List<Tuple2<String, bool>> attackFilter;
  final List<Tuple2<String, bool>> specialFilter;

  const SkillDB(
      {Key key,
      this.nameQuery,
      this.sortBy,
      this.ascending,
      this.attributeFilter,
      this.characterFilter,
      this.targetFilter,
      this.buffFilter,
      this.debuffFilter,
      this.attackFilter,
      this.specialFilter,
      this.mode})
      : super(key: key);

  int skillSort(DressSkill a, DressSkill b) {
    double dpsA = a.skillMod * a.numHits;
    double dpsB = b.skillMod * b.numHits;

    switch (sortBy) {
      case SkillSort.ID:
        return a.id - b.id;
      case SkillSort.Attribute:
        return a.attribute.toString().compareTo(b.attribute.toString());
      case SkillSort.Name:
        return a.name.compareTo(b.name);
      case SkillSort.SkillMod:
        return a.skillMod < b.skillMod ? -1 : 1;
      case SkillSort.NumHits:
        return a.numHits - b.numHits;
      case SkillSort.DPS:
        return dpsA < dpsB ? -1 : 1;

      default:
        return -1;
    }
  }

  bool matchFilter(String prop, List<Tuple2<String, bool>> filter) {
    bool clearFilter = true;
    for (var item in filter) clearFilter = clearFilter && !item.item2;

    //return true if there's nothing to check
    if (clearFilter) return true;

    var contains = filter.contains(Tuple2<String, bool>(prop, true));
    return contains;
  }

  bool hasStatus(String statuses, List<Tuple2<String, bool>> filter) {
    bool clearFilter = true;
    for (var item in filter) clearFilter = clearFilter && !item.item2;

    //return true if there's nothing to check
    if (clearFilter) return true;

    var statusList = statuses
        .split(',')
        .map((status) => status.trim().replaceAll(' ', '_').toLowerCase());

    bool hasStatus = true;
    for (var filterStatus in filter.where((s) => s.item2 == true)) {
      hasStatus = hasStatus && statusList.contains(filterStatus.item1);
    }

    return hasStatus;
  }

  Widget build(BuildContext context) {
    var dressDB = Hive.box<Dress>('dresses');
    var skillDB = Hive.box<DressSkill>('skills');

    Iterable<DressSkill> filteredBox = skillDB.values.where((skill) {
      var skillOwnerName = skill.ownerDressName.toLowerCase();
      var skillName = skill.name.toLowerCase();
      var query = nameQuery.toLowerCase();
      var skillTargetFull = skill.targetType.toString();
      var skillTarget =
          skillTargetFull.substring(skillTargetFull.indexOf('.') + 1);
      var attackKind = skill.isAttack ? "Attack" : "NonAttack";
      var specialMod = "";
      if (skill.hpMod != 0) specialMod = "HP";
      if (skill.defMod != 0) specialMod = "DEF";
      if (skill.spdMod != 0) specialMod = "SPD";
      if (skill.enemyHPMod != 0) specialMod = "Enemy HP";
      if (skill.enemySPDMod != 0) specialMod = "Enemy SPD";

      var nameFilter = nameQuery.isEmpty
          ? true
          : skillOwnerName.contains(query) || skillName.contains(query);
      var propFilters = matchFilter(
              skill.attribute.toName(), attributeFilter) &&
          matchFilter(
              skill.skillOwner.toFirstName().toLowerCase(), characterFilter) &&
          matchFilter(skillTarget, targetFilter) &&
          matchFilter(attackKind, attackFilter) &&
          matchFilter(specialMod, specialFilter);

      var buffFilters = hasStatus(skill.buffs, buffFilter) &&
          hasStatus(skill.debuffs, debuffFilter);

      return nameFilter && propFilters && buffFilters;
    });

    if (filteredBox.isEmpty)
      return Center(
        child: Text("No skills"),
      );

    var skills = filteredBox.toList();
    skills.sort(skillSort);
    if (!ascending) skills = skills.reversed.toList();

    switch (mode) {
      case 1:
        return ListView.builder(
            itemCount: skills.length,
            itemBuilder: (context, index) {
              return SkillRowEnhance(skills[index]);
            });
        break;
      case 2:
        return ListView.builder(
            itemCount: skills.length,
            itemBuilder: (context, index) {
              return SkillRowAllMods(skills[index]);
            });
      default:
        return ListView.builder(
          itemCount: skills.length,
          itemBuilder: (context, index) {
            var skill = skills[index];
            switch (sortBy) {
              case SkillSort.SkillMod:
                return SkillRowMod(skill);
              case SkillSort.NumHits:
                return SkillRowHitCount(skill);
              case SkillSort.DPS:
                return SkillRowDPS(skill);
              default:
                return SkillRow(
                    skill,
                    dressDB.values.firstWhere((dress) =>
                        skill.ownerDressName.toLowerCase() ==
                        dress.name.toLowerCase()));
            }
          },
        );
    }
  }
}

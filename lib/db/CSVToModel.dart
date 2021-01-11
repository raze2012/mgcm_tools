import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mgcm_tools/db/CSVValidator.dart';
import 'package:mgcm_tools/model/Dress.dart';
import 'package:mgcm_tools/model/DressSkill.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';

class CSVToModel {
  static Future<void> setDressDB(List<List<dynamic>> table) async {
    final dressBox = await Hive.openBox<Dress>('dresses');
    await dressBox.clear();

    for (int i = 1; i < table.length; i++) {
      var dress = CSVToModel.makeDress(table[i]);
      dressBox.add(dress);
    }
  }

  static Future<void> setSkillDB(List<List<dynamic>> table) async {
    final skillsBox = await Hive.openBox<DressSkill>('skills');
    await skillsBox.clear();

    for (int i = 1; i < table.length; i++) {
      var skill = CSVToModel.makeSkill(table[i]);
      skillsBox.add(skill);
    }
  }

  static Future<void> flutterLoadDefaultDB() async {
    var skillFuture = rootBundle.loadStructuredData('assets/skills.csv', (String csv) async {
      var conversion = CsvToListConverter().convert(csv, shouldParseNumbers: false);

      List<String> errorMessage = [];
      //in case I'm dumb, if default \r\n line endings fails, it should be \n instead
      if (!CSVValidator.validateSkillHeaders(conversion, errorMessage)) {
        errorMessage.clear();
        conversion = CsvToListConverter().convert(csv, eol: "\n", shouldParseNumbers: true);
      }
      return conversion;
    });

    var dressFuture = rootBundle.loadStructuredData('assets/dresses.csv', (String csv) async {
      var conversion = CsvToListConverter().convert(csv, shouldParseNumbers: false);

      List<String> errorMessage = [];
      //in case I'm dumb, if default \r\n line endings fails, it should be \n instead
      if (!CSVValidator.validateDressHeaders(conversion, errorMessage)) {
        errorMessage.clear();
        conversion = CsvToListConverter().convert(csv, eol: "\n", shouldParseNumbers: true);
      }
      return conversion;
    });

    var skillDBFuture = setSkillDB(await skillFuture);
    var dressDBFuture = setDressDB(await dressFuture);

    await skillDBFuture;
    await dressDBFuture;
  }

  static Future<bool> networkLoadDB() async {
    var dressResponse = http.get(CSVValidator.dressURL);
    var skillResponse = http.get(CSVValidator.skillURL);

    var dressCSV;
    var skillCSV;

    var dressResult = await dressResponse;

    if (dressResult.statusCode == 200)
      dressCSV = dressResult.body;
    else
      return false;

    var skillResult = await skillResponse;
    if (skillResult.statusCode == 200)
      skillCSV = skillResult.body;
    else
      return false;

    var dressTable = CsvToListConverter().convert(dressCSV, eol: "\n", shouldParseNumbers: true);
    var skillTable = CsvToListConverter().convert(skillCSV, eol: "\n", shouldParseNumbers: true);

    var dressFuture = CSVToModel.setDressDB(dressTable);
    var skillFuture = CSVToModel.setSkillDB(skillTable);

    await dressFuture;
    await skillFuture;

    return true;
  }

  static DressSkill makeSkill(List<dynamic> row) {
    DressSkill skill = new DressSkill(int.parse(row[0].toString()), int.parse(row[1].toString()), row[2], row[3]);

    switch (row[4].toString().toLowerCase()) {
      case "fire":
        skill.attribute = Attribute.Fire;
        break;
      case "water":
        skill.attribute = Attribute.Water;
        break;
      case "lightning":
        skill.attribute = Attribute.Lightning;
        break;
      case "dark":
        skill.attribute = Attribute.Dark;
        break;
      case "light":
        skill.attribute = Attribute.Light;
        break;
      case "none":
        skill.attribute = Attribute.None;
        break;
      default:
        assert(false, "invalid attribute");
    }

    skill.effect = row[5];
    switch (row[6].toString().toLowerCase()) {
      case "single":
        skill.targetType = SkillTargetType.Single;
        break;
      case "multiple":
        skill.targetType = SkillTargetType.Multiple;
        break;
      case "all":
        skill.targetType = SkillTargetType.All;
        break;
      case "random":
        skill.targetType = SkillTargetType.Random;
        break;
      case "self":
        skill.targetType = SkillTargetType.Self;
        break;
      default:
        assert(false, "input valid skill target type");
    }
    skill.isAttack = row[7].toString().toUpperCase() == "TRUE";
    skill.recastMax = int.parse(row[8].toString());
    skill.recastMin = int.parse(row[9].toString());
    skill.maxLevel = int.parse(row[10].toString());
    skill.skillUp2 = new SkillEnhance((row[11] as String).isNotEmpty);
    skill.skillUp3 = new SkillEnhance((row[12] as String).isNotEmpty);
    skill.skillUp4 = new SkillEnhance((row[13] as String).isNotEmpty);
    skill.skillUp5 = new SkillEnhance((row[14] as String).isNotEmpty);
    skill.skillUp6 = new SkillEnhance((row[15] as String).isNotEmpty);
    skill.skillUp7 = new SkillEnhance((row[16] as String).isNotEmpty);
    skill.skillUp8 = new SkillEnhance((row[17] as String).isNotEmpty);

    if (skill.skillUp2.exists) makeSkillEnhance(skill.skillUp2, row[11] as String);
    if (skill.skillUp3.exists) makeSkillEnhance(skill.skillUp3, row[12] as String);
    if (skill.skillUp4.exists) makeSkillEnhance(skill.skillUp4, row[13] as String);
    if (skill.skillUp5.exists) makeSkillEnhance(skill.skillUp5, row[14] as String);
    if (skill.skillUp6.exists) makeSkillEnhance(skill.skillUp6, row[15] as String);
    if (skill.skillUp7.exists) makeSkillEnhance(skill.skillUp7, row[16] as String);
    if (skill.skillUp8.exists) makeSkillEnhance(skill.skillUp8, row[17] as String);

    skill.buffs = row[18];
    skill.debuffs = row[19];
    //todo: add special effects to dressDB sheet. mostly for future damage calculation
    skill.specialEffects = row[20];

    skill.numHits = int.parse(row[21].toString());
    skill.skillMod = double.parse(row[22].toString());
    skill.hpMod = double.parse(row[23].toString());
    skill.defMod = double.parse(row[24].toString());
    skill.spdMod = double.parse(row[25].toString());
    skill.enemyHPMod = double.parse(row[26].toString());
    skill.enemySPDMod = double.parse(row[27].toString());

    return skill;
  }

  static void makeSkillEnhance(SkillEnhance skillEnhance, String effect) {
    skillEnhance.effect = effect == null ? "" : effect;
    if (effect == "Recast Turns -1") {
      skillEnhance.type = SkillEnhanceType.Recast;
      skillEnhance.amount = -1;
    } else if (effect.substring(0, effect.indexOf(' ')) == "DMG") {
      skillEnhance.type = SkillEnhanceType.DMG;
      skillEnhance.amount = int.parse(effect.substring(effect.indexOf(' ') + 1, effect.indexOf('%')));
    } else if (effect.substring(0, effect.indexOf(' ')) == "Debuff") {
      skillEnhance.type = SkillEnhanceType.Debuff;
      skillEnhance.amount = int.parse(effect.substring(effect.lastIndexOf(' ') + 1, effect.indexOf('%')));
    } else if (effect.substring(0, effect.indexOf(' ')) == "Heal") {
      skillEnhance.type = SkillEnhanceType.Heal;
      skillEnhance.amount = int.parse(effect.substring(effect.lastIndexOf(' ') + 1, effect.indexOf('%')));
    } else if (effect.substring(0, effect.indexOf(' ')) == "Barrier") {
      skillEnhance.type = SkillEnhanceType.Barrier;
      skillEnhance.amount = int.parse(effect.substring(effect.lastIndexOf(' ') + 1, effect.indexOf('%')));
    }
  }

  static Dress makeDress(List<dynamic> row) {
    Dress dress = new Dress(int.parse(row[1].toString()), row[2]);
    dress.rarity = row[3];
    dress.type = row[4];
    switch (row[5]) {
      case "Fire":
        dress.attribute = Attribute.Fire;
        break;
      case "Water":
        dress.attribute = Attribute.Water;
        break;
      case "Lightning":
        dress.attribute = Attribute.Lightning;
        break;
      case "Dark":
        dress.attribute = Attribute.Dark;
        break;
      case "Light":
        dress.attribute = Attribute.Light;
        break;
      default:
        assert(false, "invalid attribute");
    }

    dress.hp1 = int.parse(row[7].toString());
    dress.atk1 = int.parse(row[8].toString());
    dress.def1 = int.parse(row[9].toString());
    dress.spd1 = int.parse(row[10].toString());

    dress.hp80 = int.parse(row[15].toString());
    dress.atk80 = int.parse(row[16].toString());
    dress.def80 = int.parse(row[17].toString());
    dress.spd80 = int.parse(row[18].toString());

    dress.fcs = int.parse(row[19].toString());
    dress.res = int.parse(row[20].toString());

    //make sure skill 1 exists; every skill has one
    assert(row[21].toString().isNotEmpty, "missing skill 1");
    assert(row[22].toString().isNotEmpty, "missing skill 1");

    dress.skill1ID = int.parse(row[21]) * 10000 + int.parse(row[22]);
    dress.skill2ID = -1;
    dress.skill3ID = -1;
    dress.skill4ID = -1;

    if (row[23].toString().isNotEmpty)
      dress.skill2ID = int.parse(row[23].toString()) * 10000 + int.parse(row[24].toString());
    if (row[25].toString().isNotEmpty)
      dress.skill3ID = int.parse(row[25].toString()) * 10000 + int.parse(row[26].toString());
    if (row[27].toString().isNotEmpty)
      dress.skill4ID = int.parse(row[27].toString()) * 10000 + int.parse(row[28].toString());

    return dress;
  }
}

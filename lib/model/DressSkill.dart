import 'package:hive/hive.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';

part 'DressSkill.g.dart';

@HiveType(typeId: 1)
class DressSkill {
  //ID = 10,000 * kind + skillID
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int skillID;

  //1 = Command, 2 = Passive, 3 = Arousal (Skill 4)
  @HiveField(2)
  final int kind;

  @HiveField(3)
  final String name;

  @HiveField(4)
  final String ownerDressName;
  @HiveField(5)
  final Character skillOwner;

  @HiveField(6)
  Attribute attribute;
  @HiveField(7)
  String effect;
  @HiveField(8)
  SkillTargetType targetType;
  @HiveField(9)
  bool isAttack;
  @HiveField(10)
  int recastMax;
  @HiveField(11)
  int recastMin;
  @HiveField(12)
  int maxLevel;

  @HiveField(13)
  SkillEnhance skillUp2;
  @HiveField(14)
  SkillEnhance skillUp3;
  @HiveField(15)
  SkillEnhance skillUp4;
  @HiveField(16)
  SkillEnhance skillUp5;
  @HiveField(17)
  SkillEnhance skillUp6;
  @HiveField(18)
  SkillEnhance skillUp7;
  @HiveField(19)
  SkillEnhance skillUp8;

  //comma separated list of effects
  @HiveField(20)
  String buffs;
  @HiveField(21)
  String debuffs;
  @HiveField(22)
  String specialEffects;

  @HiveField(23)
  int numHits;
  @HiveField(24)
  double skillMod;
  @HiveField(25)
  double hpMod;
  @HiveField(26)
  double defMod;
  @HiveField(27)
  double spdMod;
  @HiveField(28)
  double enemyHPMod;
  @HiveField(29)
  double enemySPDMod;

  DressSkill(this.kind, this.skillID, this.name, this.ownerDressName)
      : id = kind * 10000 + skillID,
        skillOwner = getCharacter(ownerDressName.substring(ownerDressName.lastIndexOf(' ') + 1));
}

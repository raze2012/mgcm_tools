import 'package:hive/hive.dart';

part 'ModelEnums.g.dart';

@HiveType(typeId: 2)
enum SkillTargetType {
  @HiveField(0)
  Single,
  @HiveField(1)
  All,
  @HiveField(2)
  Self,
  @HiveField(3)
  Random,
  @HiveField(4)
  Multiple
}

@HiveType(typeId: 3)
enum SkillEnhanceType {
  @HiveField(0)
  DMG,
  @HiveField(1)
  Debuff,
  @HiveField(2)
  Heal,
  @HiveField(3)
  Barrier,
  @HiveField(4)
  Recast,
  @HiveField(5)
  Other
}

@HiveType(typeId: 4)
class SkillEnhance {
  @HiveField(0)
  final bool exists;
  @HiveField(1)
  SkillEnhanceType type;
  @HiveField(2)
  int amount;
  @HiveField(3)
  String effect;

  SkillEnhance(this.exists);
}

@HiveType(typeId: 5)
enum Attribute {
  @HiveField(0)
  Fire,
  @HiveField(1)
  Lightning,
  @HiveField(2)
  Water,
  @HiveField(3)
  Dark,
  @HiveField(4)
  Light,
  @HiveField(5)
  None,
}

extension AttributeUtils on Attribute {
  String toName() {
    switch (this) {
      case Attribute.Fire:
        return "fire";
      case Attribute.Water:
        return "water";
      case Attribute.Lightning:
        return "lightning";
      case Attribute.Light:
        return "light";
      case Attribute.Dark:
        return "dark";
      case Attribute.None:
        return "none";
      default:
        return "error: unknown attribute";
    }
  }
}

@HiveType(typeId: 6)
enum Character {
  @HiveField(1)
  Iroha,
  @HiveField(2)
  Kaori,
  @HiveField(3)
  Seira,
  @HiveField(4)
  Cocoa,
  @HiveField(5)
  Akisa,
  @HiveField(6)
  Ao,
  @HiveField(7)
  Aka,
  @HiveField(8)
  Eliza,
  @HiveField(9)
  Lilly,
  @HiveField(10)
  Hanabi,
  @HiveField(11)
  Marianne,
  @HiveField(12)
  Iko
}

extension CharacterUtils on Character {
  int toID() {
    switch (this) {
      case Character.Iroha:
        return 1;
      case Character.Kaori:
        return 2;
      case Character.Seira:
        return 3;
      case Character.Cocoa:
        return 4;
      case Character.Akisa:
        return 5;
      case Character.Ao:
        return 6;
      case Character.Aka:
        return 7;
      case Character.Eliza:
        return 8;
      case Character.Lilly:
        return 9;
      case Character.Hanabi:
        return 10;
      case Character.Marianne:
        return 11;
      case Character.Iko:
        return 12;
      default:
        return -1;
    }
  }

  String toFirstName() {
    switch (this) {
      case Character.Iroha:
        return "Iroha";
      case Character.Kaori:
        return "Kaori";
      case Character.Seira:
        return "Seira";
      case Character.Cocoa:
        return "Cocoa";
      case Character.Akisa:
        return "Akisa";
      case Character.Ao:
        return "Ao";
      case Character.Aka:
        return "Aka";
      case Character.Eliza:
        return "Eliza";
      case Character.Lilly:
        return "Lilly";
      case Character.Hanabi:
        return "Hanabi";
      case Character.Marianne:
        return "Marianne";
      case Character.Iko:
        return "Iko";
      default:
        return "No Name";
    }
  }
}

Character getCharacterFullName(String fullname) {
  //this is so passing in a non-full name can retyrn the right name.
  var indexOf = fullname.indexOf(' ');

  var firstName = fullname.substring(0, indexOf >= 0 ? indexOf : fullname.length);

  return Character.values.firstWhere((e) {
    return e.toFirstName().toLowerCase() == firstName.toLowerCase();
  });
}

Character getCharacter(String name) {
  return Character.values.firstWhere((e) {
    var enumName = e.toFirstName().toLowerCase();
    return enumName == name.toLowerCase();
  });
}

enum Buff {
  atk_up,
  def_up,
  spd_up,
  fcs_up,
  rst_up,
  crit_hit_rate_boost,
  crit_hit_received_rate_down,
  invincible,
  will,
  regen,
  barrier,
  immune,
  counter_stance,
  move_gauge_boost,
  reduce_recast,
  remove_debuff
}

enum Debuff {
  atk_down,
  def_down,
  spd_down,
  fcs_down,
  rst_down,
  taunt,
  no_recovery,
  no_buff,
  cut,
  sleep,
  stun,
  oblivion,
  miss_rate_boost,
  silence,
  burn,
  shock,
  freeze,
  seal,
  confusion,
  poison,
  move_gauge_down,
  extend_recast,
  remove_buff
}

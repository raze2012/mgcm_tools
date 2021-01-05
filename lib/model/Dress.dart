import 'package:hive/hive.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';
part 'Dress.g.dart';

@HiveType(typeId: 0)
class Dress {
  //based on DressAssetID
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final Character owner;

  @HiveField(3)
  String rarity;
  @HiveField(4)
  String type;
  @HiveField(5)
  Attribute attribute;

  @HiveField(6)
  int hp1;
  @HiveField(7)
  int atk1;
  @HiveField(8)
  int def1;
  @HiveField(9)
  int spd1;

  @HiveField(10)
  int hp80;
  @HiveField(11)
  int atk80;
  @HiveField(12)
  int def80;
  @HiveField(13)
  int spd80;

  @HiveField(14)
  int fcs;
  @HiveField(15)
  int res;

  //based on DressSkill.id
  @HiveField(16)
  int skill1ID;
  @HiveField(17)
  int skill2ID;
  @HiveField(18)
  int skill3ID;
  @HiveField(19)
  int skill4ID;

  Dress(this.id, this.name) : owner = getCharacter(name.substring(name.lastIndexOf(' ') + 1));
}

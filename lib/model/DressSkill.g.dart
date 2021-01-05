// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DressSkill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DressSkillAdapter extends TypeAdapter<DressSkill> {
  @override
  final int typeId = 1;

  @override
  DressSkill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DressSkill(
      fields[2] as int,
      fields[1] as int,
      fields[3] as String,
      fields[4] as String,
    )
      ..attribute = fields[6] as Attribute
      ..effect = fields[7] as String
      ..targetType = fields[8] as SkillTargetType
      ..isAttack = fields[9] as bool
      ..recastMax = fields[10] as int
      ..recastMin = fields[11] as int
      ..maxLevel = fields[12] as int
      ..skillUp2 = fields[13] as SkillEnhance
      ..skillUp3 = fields[14] as SkillEnhance
      ..skillUp4 = fields[15] as SkillEnhance
      ..skillUp5 = fields[16] as SkillEnhance
      ..skillUp6 = fields[17] as SkillEnhance
      ..skillUp7 = fields[18] as SkillEnhance
      ..skillUp8 = fields[19] as SkillEnhance
      ..buffs = fields[20] as String
      ..debuffs = fields[21] as String
      ..specialEffects = fields[22] as String
      ..numHits = fields[23] as int
      ..skillMod = fields[24] as double
      ..hpMod = fields[25] as double
      ..defMod = fields[26] as double
      ..spdMod = fields[27] as double
      ..enemyHPMod = fields[28] as double
      ..enemySPDMod = fields[29] as double;
  }

  @override
  void write(BinaryWriter writer, DressSkill obj) {
    writer
      ..writeByte(30)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.skillID)
      ..writeByte(2)
      ..write(obj.kind)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.ownerDressName)
      ..writeByte(5)
      ..write(obj.skillOwner)
      ..writeByte(6)
      ..write(obj.attribute)
      ..writeByte(7)
      ..write(obj.effect)
      ..writeByte(8)
      ..write(obj.targetType)
      ..writeByte(9)
      ..write(obj.isAttack)
      ..writeByte(10)
      ..write(obj.recastMax)
      ..writeByte(11)
      ..write(obj.recastMin)
      ..writeByte(12)
      ..write(obj.maxLevel)
      ..writeByte(13)
      ..write(obj.skillUp2)
      ..writeByte(14)
      ..write(obj.skillUp3)
      ..writeByte(15)
      ..write(obj.skillUp4)
      ..writeByte(16)
      ..write(obj.skillUp5)
      ..writeByte(17)
      ..write(obj.skillUp6)
      ..writeByte(18)
      ..write(obj.skillUp7)
      ..writeByte(19)
      ..write(obj.skillUp8)
      ..writeByte(20)
      ..write(obj.buffs)
      ..writeByte(21)
      ..write(obj.debuffs)
      ..writeByte(22)
      ..write(obj.specialEffects)
      ..writeByte(23)
      ..write(obj.numHits)
      ..writeByte(24)
      ..write(obj.skillMod)
      ..writeByte(25)
      ..write(obj.hpMod)
      ..writeByte(26)
      ..write(obj.defMod)
      ..writeByte(27)
      ..write(obj.spdMod)
      ..writeByte(28)
      ..write(obj.enemyHPMod)
      ..writeByte(29)
      ..write(obj.enemySPDMod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DressSkillAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

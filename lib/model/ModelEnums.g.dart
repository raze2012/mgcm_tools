// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ModelEnums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SkillTargetTypeAdapter extends TypeAdapter<SkillTargetType> {
  @override
  final int typeId = 2;

  @override
  SkillTargetType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SkillTargetType.Single;
      case 1:
        return SkillTargetType.All;
      case 2:
        return SkillTargetType.Self;
      case 3:
        return SkillTargetType.Random;
      case 4:
        return SkillTargetType.Multiple;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, SkillTargetType obj) {
    switch (obj) {
      case SkillTargetType.Single:
        writer.writeByte(0);
        break;
      case SkillTargetType.All:
        writer.writeByte(1);
        break;
      case SkillTargetType.Self:
        writer.writeByte(2);
        break;
      case SkillTargetType.Random:
        writer.writeByte(3);
        break;
      case SkillTargetType.Multiple:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkillTargetTypeAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class SkillEnhanceTypeAdapter extends TypeAdapter<SkillEnhanceType> {
  @override
  final int typeId = 3;

  @override
  SkillEnhanceType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SkillEnhanceType.DMG;
      case 1:
        return SkillEnhanceType.Debuff;
      case 2:
        return SkillEnhanceType.Heal;
      case 3:
        return SkillEnhanceType.Barrier;
      case 4:
        return SkillEnhanceType.Recast;
      case 5:
        return SkillEnhanceType.Other;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, SkillEnhanceType obj) {
    switch (obj) {
      case SkillEnhanceType.DMG:
        writer.writeByte(0);
        break;
      case SkillEnhanceType.Debuff:
        writer.writeByte(1);
        break;
      case SkillEnhanceType.Heal:
        writer.writeByte(2);
        break;
      case SkillEnhanceType.Barrier:
        writer.writeByte(3);
        break;
      case SkillEnhanceType.Recast:
        writer.writeByte(4);
        break;
      case SkillEnhanceType.Other:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkillEnhanceTypeAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class AttributeAdapter extends TypeAdapter<Attribute> {
  @override
  final int typeId = 5;

  @override
  Attribute read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Attribute.Fire;
      case 1:
        return Attribute.Lightning;
      case 2:
        return Attribute.Water;
      case 3:
        return Attribute.Dark;
      case 4:
        return Attribute.Light;
      case 5:
        return Attribute.None;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, Attribute obj) {
    switch (obj) {
      case Attribute.Fire:
        writer.writeByte(0);
        break;
      case Attribute.Lightning:
        writer.writeByte(1);
        break;
      case Attribute.Water:
        writer.writeByte(2);
        break;
      case Attribute.Dark:
        writer.writeByte(3);
        break;
      case Attribute.Light:
        writer.writeByte(4);
        break;
      case Attribute.None:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AttributeAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final int typeId = 6;

  @override
  Character read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return Character.Iroha;
      case 2:
        return Character.Kaori;
      case 3:
        return Character.Seira;
      case 4:
        return Character.Cocoa;
      case 5:
        return Character.Akisa;
      case 6:
        return Character.Ao;
      case 7:
        return Character.Aka;
      case 8:
        return Character.Eliza;
      case 9:
        return Character.Lilly;
      case 10:
        return Character.Hanabi;
      case 11:
        return Character.Marianne;
      case 12:
        return Character.Iko;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    switch (obj) {
      case Character.Iroha:
        writer.writeByte(1);
        break;
      case Character.Kaori:
        writer.writeByte(2);
        break;
      case Character.Seira:
        writer.writeByte(3);
        break;
      case Character.Cocoa:
        writer.writeByte(4);
        break;
      case Character.Akisa:
        writer.writeByte(5);
        break;
      case Character.Ao:
        writer.writeByte(6);
        break;
      case Character.Aka:
        writer.writeByte(7);
        break;
      case Character.Eliza:
        writer.writeByte(8);
        break;
      case Character.Lilly:
        writer.writeByte(9);
        break;
      case Character.Hanabi:
        writer.writeByte(10);
        break;
      case Character.Marianne:
        writer.writeByte(11);
        break;
      case Character.Iko:
        writer.writeByte(12);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CharacterAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class SkillEnhanceAdapter extends TypeAdapter<SkillEnhance> {
  @override
  final int typeId = 4;

  @override
  SkillEnhance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SkillEnhance(
      fields[0] as bool,
    )
      ..type = fields[1] as SkillEnhanceType
      ..amount = fields[2] as int
      ..effect = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, SkillEnhance obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.exists)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.effect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkillEnhanceAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

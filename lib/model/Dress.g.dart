// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Dress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DressAdapter extends TypeAdapter<Dress> {
  @override
  final int typeId = 0;

  @override
  Dress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dress(
      fields[0] as int,
      fields[1] as String,
    )
      ..rarity = fields[3] as String
      ..type = fields[4] as String
      ..attribute = fields[5] as Attribute
      ..hp1 = fields[6] as int
      ..atk1 = fields[7] as int
      ..def1 = fields[8] as int
      ..spd1 = fields[9] as int
      ..hp80 = fields[10] as int
      ..atk80 = fields[11] as int
      ..def80 = fields[12] as int
      ..spd80 = fields[13] as int
      ..fcs = fields[14] as int
      ..res = fields[15] as int
      ..skill1ID = fields[16] as int
      ..skill2ID = fields[17] as int
      ..skill3ID = fields[18] as int
      ..skill4ID = fields[19] as int;
  }

  @override
  void write(BinaryWriter writer, Dress obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.owner)
      ..writeByte(3)
      ..write(obj.rarity)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.attribute)
      ..writeByte(6)
      ..write(obj.hp1)
      ..writeByte(7)
      ..write(obj.atk1)
      ..writeByte(8)
      ..write(obj.def1)
      ..writeByte(9)
      ..write(obj.spd1)
      ..writeByte(10)
      ..write(obj.hp80)
      ..writeByte(11)
      ..write(obj.atk80)
      ..writeByte(12)
      ..write(obj.def80)
      ..writeByte(13)
      ..write(obj.spd80)
      ..writeByte(14)
      ..write(obj.fcs)
      ..writeByte(15)
      ..write(obj.res)
      ..writeByte(16)
      ..write(obj.skill1ID)
      ..writeByte(17)
      ..write(obj.skill2ID)
      ..writeByte(18)
      ..write(obj.skill3ID)
      ..writeByte(19)
      ..write(obj.skill4ID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

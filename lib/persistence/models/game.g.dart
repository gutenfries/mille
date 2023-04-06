// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerAdapter extends TypeAdapter<_Player> {
  @override
  final int typeId = 0;

  @override
  _Player read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _Player()
      ..name = fields[0] as String?
      ..playerID = fields[1] as String
      ..totalScore = fields[2] == null ? 0 : fields[2] as int
      ..miles = fields[3] == null ? 0 : fields[3] as int
      ..safeties = fields[4] == null ? 0 : fields[4] as int
      ..poofs = fields[5] == null ? 0 : fields[5] as int
      ..hasTripCompleted = fields[6] == null ? false : fields[6] as bool
      ..hasDelayedAction = fields[7] == null ? false : fields[7] as bool
      ..hasSafeTrip = fields[8] == null ? false : fields[8] as bool
      ..hasExtension = fields[9] == null ? false : fields[9] as bool
      ..hasAllSafeties = fields[10] == null ? false : fields[10] as bool
      ..hasShutout = fields[11] == null ? false : fields[11] as bool;
  }

  @override
  void write(BinaryWriter writer, _Player obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.playerID)
      ..writeByte(2)
      ..write(obj.totalScore)
      ..writeByte(3)
      ..write(obj.miles)
      ..writeByte(4)
      ..write(obj.safeties)
      ..writeByte(5)
      ..write(obj.poofs)
      ..writeByte(6)
      ..write(obj.hasTripCompleted)
      ..writeByte(7)
      ..write(obj.hasDelayedAction)
      ..writeByte(8)
      ..write(obj.hasSafeTrip)
      ..writeByte(9)
      ..write(obj.hasExtension)
      ..writeByte(10)
      ..write(obj.hasAllSafeties)
      ..writeByte(11)
      ..write(obj.hasShutout);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GameAdapter extends TypeAdapter<Game> {
  @override
  final int typeId = 1;

  @override
  Game read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Game()
      ..gameID = fields[0] as String
      ..players = (fields[1] as List).cast<_Player>()
      ..createdAt = fields[2] as DateTime?
      ..lastUpdatedAt = fields[3] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Game obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.gameID)
      ..writeByte(1)
      ..write(obj.players)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.lastUpdatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

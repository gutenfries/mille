import 'dart:math';

import 'package:hive/hive.dart';

part 'game.g.dart';

// Players are managed by the Game object.
@HiveType(typeId: 0)
class Player extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String playerID = Random.secure().nextInt(0xFFFFFFFF).toRadixString(16);

  @HiveField(2, defaultValue: 0)
  int totalScore = 0;

  @HiveField(3, defaultValue: 0)
  int miles = 0;

  @HiveField(4, defaultValue: 0)
  int safeties = 0;

  @HiveField(5, defaultValue: 0)
  int poofs = 0;

  @HiveField(6, defaultValue: false)
  bool hasTripCompleted = false;

  @HiveField(7, defaultValue: false)
  bool hasDelayedAction = false;

  @HiveField(8, defaultValue: false)
  bool hasSafeTrip = false;

  @HiveField(9, defaultValue: false)
  bool hasExtension = false;

  @HiveField(10, defaultValue: false)
  bool hasAllSafeties = false;

  @HiveField(11, defaultValue: false)
  bool hasShutout = false;
}

@HiveType(typeId: 1)
class Game extends HiveObject {
  @HiveField(0)
  String gameID = Random.secure().nextInt(0xFFFFFFFF).toRadixString(16);

  @HiveField(1)
  List<Player> players = [];

  @HiveField(2)
  DateTime? createdAt;

  @HiveField(3)
  DateTime? lastUpdatedAt;
}

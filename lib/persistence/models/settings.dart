import 'package:hive_flutter/hive_flutter.dart';

part 'settings.g.dart';

@HiveType(typeId: 3)
enum ThemeMode {
  @HiveField(0)
  light,
  @HiveField(1)
  dark,
  @HiveField(2, defaultValue: true)
  system,
}

@HiveType(typeId: 4)
class Settings extends HiveObject {
  @HiveField(0)
  ThemeMode themeMode = ThemeMode.system;
}

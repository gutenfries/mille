import 'package:hive_flutter/hive_flutter.dart';

import 'models/game.dart' show GameAdapter, PlayerAdapter;
import 'models/settings.dart' show SettingsAdapter, ThemeModeAdapter;

/// Static Wrapper class for Data Persistence Adapters.
class Adapters {
  static void registerAdapters() {
    Hive.registerAdapter(GameAdapter());
    Hive.registerAdapter(PlayerAdapter());
    Hive.registerAdapter(SettingsAdapter());
    Hive.registerAdapter(ThemeModeAdapter());
  }
}

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'persistence/models/game.dart';

/// A collection of functions that handle data persistence and manipulation.
///
/// This is a static class, and should be accessed via `Handlers.methodName()`.
class Handlers {
  /// Clears all data from the persistent storage.
  ///
  /// This clears the GlobalApplicationState box, which will require an app restart.
  ///
  /// ## This is a destructive operation and cannot be undone.
  static void clearAllData() {
    Hive.deleteBoxFromDisk('HiveGlobalApplicationState');
  }

  /// Creates a new game and returns the gameID of the created game.
  static String createNewGame() {
    final Box<Game> box = Hive.box('HiveGlobalApplicationState');

    // instantiate the class BEFORE adding it to the box, so that the gameID
    // can be accessed without throwing a static access error.
    final Game game = Game();
    box.add(game);

    return game.gameID;
  }

  /// Deletes a game from the persistent storage.
  void deleteGame(String gameID) {
    final Box<Game> box = Hive.box('HiveGlobalApplicationState');
    final Game game = box.values.firstWhere(
      (Game game) => game.gameID == gameID,
    );
    box.delete(game.key);
  }

  /// Returns a list of all gameIDs.
  static List<String> getAllGameIDs() {
    final Box<Game> box = Hive.box('HiveGlobalApplicationState');
    return box.values.map((Game game) => game.gameID).toList();
  }
}

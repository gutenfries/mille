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
    Hive.deleteBoxFromDisk('GameBox');
  }

  /// Creates a new game and returns the gameID of the created game.
  static String createGame() {
    final Box<Game> box = Hive.box('GameBox');

    // instantiate the class BEFORE adding it to the box, so that the gameID
    // can be accessed without throwing a static access error.
    final Game game = Game();

    box.add(game);

    return game.gameID;
  }

  /// Creates a new player on a game and returns the playerID of the created player.
  static String createPlayer(String gameID) {
    final Box<Game> box = Hive.box('GameBox');
    // find the game with the matching gameID\
    final Game game = box.values.firstWhere(
      (Game game) => game.gameID == gameID,
    );

    // instantiate the class BEFORE adding it to the box, so that the playerID
    // can be accessed without throwing a static access error.
    final Player player = Player();

    game.players.add(player);
    box.put(game.key, game);

    return player.playerID;
  }

  /// Deletes a player from a game.
  /// If the player is the last player in the game, the game will be deleted.
  static void deletePlayer(String gameID, String playerID) {
    final Box<Game> box = Hive.box('GameBox');
    // find the game with the matching gameID
    final Game game = box.values.firstWhere(
      (Game game) => game.gameID == gameID,
    );

    // find the player with the matching playerID
    final Player player = game.players.firstWhere(
      (Player player) => player.playerID == playerID,
    );

    // remove the player from the game
    game.players.remove(player);

    // if the game is now empty, delete it
    if (game.players.isEmpty) {
      box.delete(game.key);
    } else {
      box.put(game.key, game);
    }
  }

  /// Deletes a game from the persistent storage.
  void deleteGame(String gameID) {
    final Box<Game> box = Hive.box('GameBox');
    final Game game = box.values.firstWhere(
      (Game game) => game.gameID == gameID,
    );
    box.delete(game.key);
  }

  /// Returns a list of all gameIDs.
  static List<String> getAllGameIDs() {
    final Box<Game> box = Hive.box('GameBox');
    return box.values.map((Game game) => game.gameID).toList();
  }

  /// Returns a list of all the games
  static List<Game> getAllGames() {
    final Box<Game> box = Hive.box('GameBox');
    return box.values.toList();
  }

  /// Returns a list of all the players in a game.
  static List<Player> getAllPlayers(String gameID) {
    final Box<Game> box = Hive.box('GameBox');
    final Game game = box.values.firstWhere(
      (Game game) => game.gameID == gameID,
    );
    return game.players;
  }
}

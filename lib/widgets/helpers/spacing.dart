import 'package:fluent_ui/fluent_ui.dart';

/// Static access class for spacing widgets.
///
/// Spacing is cubic, meaning that it will work both horizontally and vertically.
class Spacing {
  static Widget small() {
    return const SizedBox(height: 4.0, width: 4.0);
  }

  static Widget medium() {
    return const SizedBox(height: 8.0, width: 8.0);
  }

  static Widget large() {
    return const SizedBox(height: 16.0, width: 16.0);
  }

  static Widget extraLarge() {
    return const SizedBox(height: 22.0, width: 22.0);
  }

  static Widget fuckingGiant() {
    return const SizedBox(height: 32.0, width: 32.0);
  }
}

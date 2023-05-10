import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;
import 'package:flutter/foundation.dart' as flutter_foundation;
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:system_theme/system_theme.dart';

import 'constants.dart';

class AppTheme extends ChangeNotifier {
  static const String appTitle = 'Mille Bournes Scorekeeper App';

  /// Static constant containing supported window effects on Linux.
  ///
  /// Does **NOT** indicate that the current environment is Linux.
  static const List<WindowEffect> linuxWindowEffects = [
    WindowEffect.disabled,
    WindowEffect.transparent,
  ];

  /// Static constant containing supported window effects on Windows.
  ///
  /// Does **NOT** indicate that the current environment is Windows.
  static const List<WindowEffect> windowsWindowEffects = [
    WindowEffect.disabled,
    WindowEffect.solid,
    WindowEffect.transparent,
    WindowEffect.aero,
    WindowEffect.acrylic,
    WindowEffect.mica,
    WindowEffect.tabbed,
  ];

  /// Static constant containing supported window effects on MacOS.
  ///
  /// Does **NOT** indicate that the current environment is MacOS.
  static const List<WindowEffect> macosWindowEffects = [
    WindowEffect.disabled,
    WindowEffect.titlebar,
    WindowEffect.selection,
    WindowEffect.menu,
    WindowEffect.popover,
    WindowEffect.sidebar,
    WindowEffect.headerView,
    WindowEffect.sheet,
    WindowEffect.windowBackground,
    WindowEffect.hudWindow,
    WindowEffect.fullScreenUI,
    WindowEffect.toolTip,
    WindowEffect.contentBackground,
    WindowEffect.underWindowBackground,
    WindowEffect.underPageBackground,
  ];

  /// Static constant that returns `true` if the current application
  /// environment supports a system accent color.
  ///
  /// Suppported platforms:
  /// - (Native) Windows
  /// - (Native) Android
  /// - Web
  static bool get isSystemAccentColorSupported {
    return flutter_foundation.kIsWeb ||
        [
          flutter_foundation.TargetPlatform.windows,
          flutter_foundation.TargetPlatform.android,
        ].contains(flutter_foundation.defaultTargetPlatform);
  }

  /// Static constant that returns `true` if the current application
  /// environment supports a window transparency effects.
  ///
  /// Suppported platforms: (All desktop platforms)
  /// - (Native) Windows
  /// - (Native) Unix/Linux/BSD
  /// - (Native) MacOS
  static bool get isWindowEffectsSupported {
    return !flutter_foundation.kIsWeb &&
        [
          flutter_foundation.TargetPlatform.windows,
          flutter_foundation.TargetPlatform.linux,
          flutter_foundation.TargetPlatform.macOS,
        ].contains(flutter_foundation.defaultTargetPlatform);
  }

  final spacerSmall = const SizedBox(height: 10.0);

  final spacerMedium = const SizedBox(height: 20.0);

  final spacerLarge = const SizedBox(height: 40.0);

  TextDirection _textDirection = TextDirection.ltr;
  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection direction) {
    _textDirection = direction;
    notifyListeners();
  }

  /// Static constant containing supported window effects on the current environment.
  /// Returns an empty list if there are no supported window effects.
  static List<WindowEffect> get supportedWindowEffects {
    // return empty if not on desktop
    if (!Constants.isDesktop) return [];

    // return corresponding list for the current desktop platform
    if (Constants.isNativeWindows) {
      return windowsWindowEffects;
    } else if (Constants.isNativeLinux) {
      return linuxWindowEffects;
    } else if (Constants.isNativeMacOS) {
      return macosWindowEffects;
    }

    /// this should never return, but leave it here to comply with
    /// dart-analyzer `dart(body_might_complete_normally)`
    return [];
  }

  Locale? _locale;

  /// Returns the supported locales for the current application as a `List<Locale>`.
  final supportedLocales = FluentLocalizations.supportedLocales;

  ThemeMode _mode = ThemeMode.system;
  PaneDisplayMode _displayMode = PaneDisplayMode.auto;
  WindowEffect _windowEffect = WindowEffect.disabled;
  AccentColor systemAccentColor = _SystemAccentColor().systemAccentColor;
  AccentColor _color = _SystemAccentColor().systemAccentColor;

  AccentColor get accentColor => _color;

  set accentColor(AccentColor color) {
    _color = color;
    notifyListeners();
  }

  PaneDisplayMode get displayMode => _displayMode;

  set displayMode(PaneDisplayMode displayMode) {
    _displayMode = displayMode;
    notifyListeners();
  }

  Locale? get locale => _locale;

  set locale(Locale? locale) {
    _locale = locale;
    notifyListeners();
  }

  /// Returns the dynamic width of the current screen.
  ///
  /// This is the width of the screen that the application is currently
  /// running on, or the width of the window if the application is running
  /// in a window.
  ///
  /// ## Parameters:
  ///
  /// - `context`: The [BuildContext] of the widget that is requesting the
  ///  width of the screen.
  ///
  /// ## See Also:
  /// - [screenHeight]
  /// - [screenSize]
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Returns the dynamic height of the current screen.
  ///
  /// This is the height of the screen that the application is currently
  /// running on, or the height of the window if the application is running
  /// in a window.
  ///
  /// ## Parameters:
  ///
  /// - `context`: The [BuildContext] of the widget that is requesting the
  ///  height of the screen.
  ///
  /// ## See Also:
  /// - [screenWidth]
  /// - [screenSize]
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Returns the dynamic size of the current screen.
  ///
  /// This is the size of the screen that the application is currently
  /// running on, or the size of the window if the application is running
  /// in a window.
  ///
  /// ## Parameters:
  ///
  /// - `context`: The [BuildContext] of the widget that is requesting the
  ///  size of the screen.
  ///
  /// ## See Also:
  /// - [screenWidth]
  /// - [screenHeight]
  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  ThemeMode get themeMode => _mode;

  set themeMode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  WindowEffect get windowEffect => _windowEffect;

  set windowEffect(WindowEffect windowEffect) {
    _windowEffect = windowEffect;
    notifyListeners();
  }

  /// Returns the current locale of the application.
  ///
  /// ## Parameters:
  /// - `context`: The [BuildContext] of the widget that is requesting the
  /// current locale of the application.\
  Locale currentLocale(BuildContext context) {
    return Localizations.localeOf(context);
  }

  void setWindowEffect(WindowEffect effect, BuildContext context) {
    Window.setEffect(
      effect: effect,
      color: [
        WindowEffect.solid,
        WindowEffect.acrylic,
      ].contains(effect)
          ? FluentTheme.of(context).micaBackgroundColor.withOpacity(0.05)
          : Colors.transparent,
      dark: FluentTheme.of(context).brightness.isDark,
    );
  }
}

class _SystemAccentColor {
  AccentColor get systemAccentColor {
    if (AppTheme.isSystemAccentColorSupported) {
      return AccentColor.swatch({
        'darkest': SystemTheme.accentColor.darkest,
        'darker': SystemTheme.accentColor.darker,
        'dark': SystemTheme.accentColor.dark,
        'normal': SystemTheme.accentColor.accent,
        'light': SystemTheme.accentColor.light,
        'lighter': SystemTheme.accentColor.lighter,
        'lightest': SystemTheme.accentColor.lightest,
      });
    }
    return Colors.blue;
  }
}

import 'package:flutter/foundation.dart' as flutter_foundation;
import 'package:flutter/services.dart';

/// Environment constants.
///
/// This is a static class and should be accessed
/// without instantiation via `Constants.methodName()` or `Constants.propertyName`.
class Constants {
  /// The short name of the application.
  static const String appTitle = 'Mille';

  /// The full name of the application.
  static const String appName =
      'Mille: An intelligent Mille Bornes scorekeeper';

  /// allow numbers, decimal point, and negative sign
  static final FilteringTextInputFormatter signedFloatRegex =
      FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'));

  /// allow positive integers 1-4
  static final FilteringTextInputFormatter positiveIntRegex =
      FilteringTextInputFormatter.allow(RegExp(r'^[1-4]$'));

  /// Static constant that returns the current platform as
  /// `flutter:foundatipn.TargetPlatform`.
  ///
  /// Platforms:
  /// - (Native) Windows
  /// - (Native) Unix/Linux/BSD
  /// - (Native) MacOS
  static flutter_foundation.TargetPlatform get currentPlatform =>
      flutter_foundation.defaultTargetPlatform;

  /// Static constant that returns `true` if the current application
  /// environment is on the web.
  ///
  /// This implementation takes advantage of the fact that JavaScript
  /// does not support integers. In this environment, Dart's `double`s and
  /// `int`s are backed by the same kind of object. Thus a `double` `0.0` is identical
  /// to an `integer` `0`. This is _not_ true for Dart code running in AOT or on the VM.
  ///
  /// Platforms:
  /// - Web
  ///
  /// ## See Also:
  /// - [isNative]
  static const bool isWeb = flutter_foundation.kIsWeb;

  /// Static constant that returns `true` if the current application
  /// environment is native.
  ///
  /// Platforms:
  /// - (Native) Windows
  /// - (Native) Unix/Linux/BSD
  /// - (Native) MacOS
  /// - (Native) iOS
  /// - (Native) Android
  ///
  /// ## See Also:
  /// - [isWeb]
  static const bool isNative = !flutter_foundation.kIsWeb;

  /// Static constant that returns `true` if the current application
  /// environment is desktop.
  ///
  /// Platforms:
  /// - Windows
  /// - Unix/Linux/BSD
  /// - MacOS
  static bool get isDesktop {
    return [
      flutter_foundation.TargetPlatform.windows,
      flutter_foundation.TargetPlatform.linux,
      flutter_foundation.TargetPlatform.macOS,
    ].contains(flutter_foundation.defaultTargetPlatform);
  }

  ///  Static const constant that returns `true` if the current application
  /// environment is native desktop.
  ///
  /// Platforms:
  /// - (Native) Windows
  /// - (Native) Unix/Linux/BSD
  /// - (Native) MacOS
  static bool get isNativeDesktop {
    if (flutter_foundation.kIsWeb) return false;
    return [
      flutter_foundation.TargetPlatform.windows,
      flutter_foundation.TargetPlatform.linux,
      flutter_foundation.TargetPlatform.macOS,
    ].contains(flutter_foundation.defaultTargetPlatform);
  }

  /// Static constant that returns `true` if the current application
  /// environment is mobile.
  ///
  /// Platforms:
  /// - iOS
  /// - Android
  static bool get isMobile {
    return [
      flutter_foundation.TargetPlatform.android,
      flutter_foundation.TargetPlatform.iOS,
    ].contains(flutter_foundation.defaultTargetPlatform);
  }

  /// Static constant that returns `true` if the current application
  /// environment is native mobile.
  ///
  /// Platforms:
  /// - (Native) iOS
  /// - (Native) Android
  static bool get isNativeMobile {
    if (flutter_foundation.kIsWeb) return false;
    return [
      flutter_foundation.TargetPlatform.android,
      flutter_foundation.TargetPlatform.iOS,
    ].contains(flutter_foundation.defaultTargetPlatform);
  }

  /// Static constant that returns `true` if the current application
  /// environment is running on Windows.
  ///
  /// Windows: https://www.windows.com/
  ///
  /// ## See Also:
  /// - [isNativeWindows]
  static bool get isWindows =>
      flutter_foundation.defaultTargetPlatform ==
      flutter_foundation.TargetPlatform.windows;

  /// Static constant that returns `true` if the current application
  /// environment is running on Linux.
  ///
  /// Linux: https://www.linux.org/
  ///
  /// ## See Also:
  /// - [isNativeLinux]
  static bool get isLinux =>
      flutter_foundation.defaultTargetPlatform ==
      flutter_foundation.TargetPlatform.linux;

  /// Static constant that returns `true` if the current application
  /// environment is running on MacOS.
  ///
  /// MacOS: https://www.apple.com/macos/
  ///
  /// ## See Also:
  /// - [isNativeMacOS]
  static bool get isMacOS =>
      flutter_foundation.defaultTargetPlatform ==
      flutter_foundation.TargetPlatform.macOS;

  /// Static constant that returns `true` if the current application
  /// environment is running on Android.
  ///
  /// Android: https://www.android.com/
  ///
  /// ## See Also:
  /// - [isNativeAndroid]
  static bool get isAndroid =>
      flutter_foundation.defaultTargetPlatform ==
      flutter_foundation.TargetPlatform.android;

  /// Static constant that returns `true` if the current application
  /// environment is running on iOS.
  ///
  /// iOS: https://www.apple.com/ios/
  ///
  /// ## See Also:
  /// - [isNativeIOS]
  static bool get isIOS =>
      flutter_foundation.defaultTargetPlatform ==
      flutter_foundation.TargetPlatform.iOS;

  /// Static constant that returns `true` if the current application
  /// environment is running on native Windows.
  ///
  /// Windows: https://www.windows.com
  ///
  /// ## See Also:
  /// - [isNative]
  /// - [isWindows]
  static bool get isNativeWindows =>
      // if isn't on the web
      !flutter_foundation.kIsWeb &&
      // and is on Windows
      flutter_foundation.defaultTargetPlatform ==
          flutter_foundation.TargetPlatform.windows;

  /// Static constant that returns `true` if the current application
  /// environment is running on native Linux.
  ///
  /// Linux: https://www.linux.org
  ///
  /// ## See Also:
  /// - [isNative]
  /// - [isLinux]
  static bool get isNativeLinux =>
      // if isn't on the web
      !flutter_foundation.kIsWeb &&
      // and is on Linux
      flutter_foundation.defaultTargetPlatform ==
          flutter_foundation.TargetPlatform.linux;

  /// Static constant that returns `true` if the current application
  /// environment is running on native MacOS.
  ///
  /// macOS: https://www.apple.com/macos
  ///
  /// ## See Also:
  /// - [isNative]
  /// - [isMacOS]
  static bool get isNativeMacOS =>
      // if isn't on the web
      !flutter_foundation.kIsWeb &&
      // and is on MacOS
      flutter_foundation.defaultTargetPlatform ==
          flutter_foundation.TargetPlatform.macOS;

  /// Static constant that returns `true` if the current application
  /// environment is running on native Android.
  ///
  /// Android: https://www.android.com/
  ///
  /// ## See Also:
  /// - [isNative]
  /// - [isAndroid]
  static bool get isNativeAndroid =>
      // if isn't on the web
      !flutter_foundation.kIsWeb &&
      // and is on Android
      flutter_foundation.defaultTargetPlatform ==
          flutter_foundation.TargetPlatform.android;

  /// Static constant that returns `true` if the current application
  /// environment is running on native iOS.
  ///
  /// iOS: https://www.apple.com/ios/
  ///
  /// ## See Also:
  /// - [isNative]
  /// - [isIOS]
  static bool get isNativeIOS =>
      // if isn't on the web
      !flutter_foundation.kIsWeb &&
      // and is on IOS
      flutter_foundation.defaultTargetPlatform ==
          flutter_foundation.TargetPlatform.iOS;

  /// Static constant that returns `true` if the current application
  /// environment was compiled in debug mode.
  ///
  /// More specifically, this is a constant that is true if the application
  /// **WAS NOT** compiled with
  ///
  /// `-Ddart.vm.product=true` _and_ `-Ddart.vm.profile=true`.
  ///
  /// ## See Also:
  /// - [isProfileMode]
  /// - [isReleaseMode]
  static const bool isDebugMode = flutter_foundation.kDebugMode;

  /// Static constant that returns `true` if the current application
  /// environment was compiled in profile mode.
  ///
  /// More specifically, this is a constant that is true if the application
  /// **WAS** compiled in Dart with
  ///
  /// `-Ddart.vm.profile=true`.
  ///
  /// ## See Also:
  /// - [isDebugMode]
  /// - [isReleaseMode]
  static const bool isProfileMode = flutter_foundation.kProfileMode;

  /// Static constant that returns `true` if the current application
  /// environment was compiled in release mode.
  ///
  /// More specifically, this is a constant that is true if the application
  /// **WAS** compiled in Dart with
  ///
  /// `-Ddart.vm.product=true`.
  ///
  /// ## See Also:
  /// - [isDebugMode]
  /// - [isProfileMode]
  static const bool isReleaseMode = flutter_foundation.kReleaseMode;
}

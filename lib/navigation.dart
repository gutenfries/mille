import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'constants.dart';

import 'screens/scorecards.dart';
import 'screens/home.dart';
import 'screens/debug.dart';
import 'screens/settings.dart';
import 'screens/about.dart';
import 'widgets/helpers/deferred_widget.dart';

class Navigation {
  static int navIndex = 0;
  static final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  static final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  static final searchFocusNode = FocusNode();
  static final searchController = TextEditingController();

  static final List<NavigationPaneItem> navItems = [
    PaneItem(
      key: const Key('home'),
      icon: const Icon(TablerIcons.home),
      title: const Text('Home'),
      body: const HomePage(),
    ),
    PaneItem(
      key: const Key('rules'),
      icon: const Icon(TablerIcons.book),
      title: const Text('Official Rules'),
      body: const Center(child: Text('Wow. Such empty. Much rules.')),
    ),
    PaneItemSeparator(),
    PaneItem(
      key: const Key('scorecards'),
      title: const Text('ScoreCards'),
      body: const ScoreCardsPage(),
      icon: const Icon(TablerIcons.device_gamepad_2),
    )
  ];

  static final List<NavigationPaneItem> navFooterItems = [
    PaneItemSeparator(),
    PaneItem(
      key: const Key('about'),
      icon: const Icon(TablerIcons.info_circle),
      title: const Text('About'),
      body: AboutScreen(),
    ),
    PaneItem(
      key: const Key('settings'),
      icon: const Icon(TablerIcons.settings),
      title: const Text('Settings'),
      body: SettingsPage(),
    ),
    if (Constants.isDebugMode)
      PaneItem(
        key: const Key('debug'),
        icon: const Icon(TablerIcons.bug),
        title: const Text('Debug'),
        body: DebugScreen(),
      ),
  ];
}

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'constants.dart';

import 'handlers.dart';
import 'screens/home.dart';
import 'screens/debug.dart';
import 'screens/settings.dart';
import 'screens/about.dart';
import 'widgets/scorecard/scorecard.dart';

class Navigation {
  static int navIndex = 0;
  static final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  static final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  static final searchFocusNode = FocusNode();
  static final searchController = TextEditingController();

  static final List<NavigationPaneItem> navItems = [
    PaneItem(
      icon: const Icon(TablerIcons.home),
      title: const Text('Home'),
      body: const HomePage(),
    ),
    PaneItem(
      icon: const Icon(TablerIcons.book),
      title: const Text('Official Rules'),
      body: const Center(child: Text('Wow. Such empty. Much rules.')),
    ),
    PaneItemSeparator(),
    for (final game in Handlers.getAllGameIDs())
      PaneItem(
        icon: const Icon(TablerIcons.device_gamepad_2),
        title: Text(game),
        body: const ScoreCard(),
      ),
  ];

  static final List<NavigationPaneItem> navFooterItems = [
    PaneItemSeparator(),
    PaneItem(
      icon: const Icon(TablerIcons.info_circle),
      title: const Text('About'),
      body: AboutScreen(),
    ),
    PaneItem(
      icon: const Icon(TablerIcons.settings),
      title: const Text('Settings'),
      body: SettingsScreen(),
    ),
    if (Constants.isDebugMode)
      PaneItem(
        icon: const Icon(TablerIcons.bug),
        title: const Text('Debug'),
        body: DebugScreen(),
      ),
  ];
}

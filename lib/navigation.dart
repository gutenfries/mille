import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'constants.dart';

import 'screens/home.dart';
import 'screens/debug.dart';
import 'screens/settings.dart';
import 'screens/about.dart';
import 'widgets/scorecard/scorecard.dart';

int navIndex = 0;
final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
final searchFocusNode = FocusNode();
final searchController = TextEditingController();

final List<NavigationPaneItem> navItems = [
  PaneItem(
    icon: const Icon(TablerIcons.home),
    title: const Text('Home'),
    body: const HomePage(),
  ),
  PaneItemSeparator(),

  // plus button to create new pane
  PaneItem(
    icon: const Icon(TablerIcons.device_gamepad_2),
    title: const Text('Scorecard'),
    body: ScoreCard(),
  ),
];
final List<NavigationPaneItem> navFooterItems = [
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

import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:url_launcher/link.dart';

import 'constants.dart';

import 'main.dart';
import 'screens/scorecards.dart';
import 'screens/home.dart';
import 'screens/debug.dart';
import 'screens/settings.dart';
import 'screens/about.dart';

class _LinkPaneItemAction extends PaneItem {
  _LinkPaneItemAction({
    required super.icon,
    required this.link,
    required super.body,
    super.title,
  });

  final String link;

  @override
  Widget build(
    BuildContext context,
    bool selected,
    VoidCallback? onPressed, {
    PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
    int? itemIndex,
  }) {
    return Link(
      uri: Uri.parse(link),
      builder: (context, followLink) => super.build(
        context,
        selected,
        followLink,
        displayMode: displayMode,
        showTextOnTop: showTextOnTop,
        itemIndex: itemIndex,
        autofocus: autofocus,
      ),
    );
  }
}

class Navigation {
  static int navIndex = 0;
  static final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  static final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  static final searchFocusNode = FocusNode();
  static final searchController = TextEditingController();
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return GlobalApplication(
            shellContext: _shellNavigatorKey.currentContext,
            state: state,
            child: child,
          );
        },
        routes: [
          /// Home
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),

          /// Settings
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => SettingsPage(),
          ),

          /// Rules
          GoRoute(
            path: '/rules',
            name: 'rules',
            builder: (context, state) => const Center(
              child: Text('Wow. Such empty. Much rules.'), // TODO
            ),
          ),

          /// Debug
          if (Constants.isDebugMode)
            GoRoute(
              path: '/debug',
              name: 'debug',
              builder: (context, state) => DebugScreen(),
            ),

          /// About
          GoRoute(
            path: '/about',
            name: 'about',
            builder: (context, state) => AboutScreen(),
          ),

          /// Scorecards
          GoRoute(
            path: '/scorecards',
            name: 'scorecards',
            builder: (context, state) => const ScoreCardsPage(),
          ),
        ],
      ),
    ],
  );

  static final List<NavigationPaneItem> navItems = [
    PaneItem(
      key: const Key('home'),
      icon: const Icon(TablerIcons.home),
      title: const Text('Home'),
      body: const HomePage(),
      onTap: () {
        if (router.location != '/') {
          router.pushNamed('home');
        }
      },
    ),
    PaneItem(
      key: const Key('rules'),
      icon: const Icon(TablerIcons.book),
      title: const Text('Official Rules'),
      body: const Center(child: Text('Wow. Such empty. Much rules.')),
      onTap: () {
        if (router.location != '/rules') {
          router.pushNamed('rules');
        }
      },
    ),
    PaneItemSeparator(),
    PaneItem(
      key: const Key('scorecards'),
      title: const Text('ScoreCards'),
      body: const ScoreCardsPage(),
      icon: const Icon(TablerIcons.device_gamepad_2),
      onTap: () {
        if (router.location != '/scorecards') {
          router.pushNamed('scorecards');
        }
      },
    )
  ];

  static final List<NavigationPaneItem> navFooterItems = [
    PaneItemSeparator(),
    PaneItem(
      key: const Key('about'),
      icon: const Icon(TablerIcons.info_circle),
      title: const Text('About'),
      body: AboutScreen(),
      onTap: () {
        if (router.location != '/about') {
          router.pushNamed('about');
        }
      },
    ),
    PaneItem(
      key: const Key('settings'),
      icon: const Icon(TablerIcons.settings),
      title: const Text('Settings'),
      body: SettingsPage(),
      onTap: () {
        if (router.location != '/settings') {
          router.pushNamed('settings');
        }
      },
    ),
    if (Constants.isDebugMode)
      PaneItem(
        key: const Key('debug'),
        icon: const Icon(TablerIcons.bug),
        title: const Text('Debug'),
        body: DebugScreen(),
        onTap: () {
          if (router.location != '/debug') {
            router.pushNamed('debug');
          }
        },
      ),
  ];
}

// final List<NavigationPaneItem> originalItems = [
//   PaneItem(
//     key: const Key('/'),
//     icon: const Icon(FluentIcons.home),
//     title: const Text('Home'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/') router.pushNamed('home');
//     },
//   ),
//   PaneItemHeader(header: const Text('Inputs')),
//   PaneItem(
//     key: const Key('/inputs/buttons'),
//     icon: const Icon(FluentIcons.button_control),
//     title: const Text('Button'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/inputs/buttons') {
//         router.pushNamed('inputs_buttons');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/inputs/checkbox'),
//     icon: const Icon(FluentIcons.checkbox_composite),
//     title: const Text('Checkbox'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/inputs/checkbox') {
//         router.pushNamed('inputs_checkbox');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/inputs/slider'),
//     icon: const Icon(FluentIcons.slider),
//     title: const Text('Slider'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/inputs/slider') {
//         router.pushNamed('inputs_slider');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/inputs/toggle_switch'),
//     icon: const Icon(FluentIcons.toggle_left),
//     title: const Text('ToggleSwitch'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/inputs/toggle_switch') {
//         router.pushNamed('inputs_toggle_switch');
//       }
//     },
//   ),
//   PaneItemHeader(header: const Text('Form')),
//   PaneItem(
//     key: const Key('/forms/text_box'),
//     icon: const Icon(FluentIcons.text_field),
//     title: const Text('TextBox'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/forms/text_box') {
//         router.pushNamed('forms_text_box');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/forms/auto_suggest_box'),
//     icon: const Icon(FluentIcons.page_list),
//     title: const Text('AutoSuggestBox'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/forms/auto_suggest_box') {
//         router.pushNamed('forms_auto_suggest_box');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/forms/combobox'),
//     icon: const Icon(FluentIcons.combobox),
//     title: const Text('ComboBox'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/forms/combobox') {
//         router.pushNamed('forms_combobox');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/forms/numberbox'),
//     icon: const Icon(FluentIcons.number),
//     title: const Text('NumberBox'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/forms/numberbox') {
//         router.pushNamed('forms_numberbox');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/forms/passwordbox'),
//     icon: const Icon(FluentIcons.password_field),
//     title: const Text('PasswordBox'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/forms/passwordbox') {
//         router.pushNamed('forms_passwordbox');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/forms/time_picker'),
//     icon: const Icon(FluentIcons.time_picker),
//     title: const Text('TimePicker'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/forms/time_picker') {
//         router.pushNamed('forms_time_picker');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/forms/date_picker'),
//     icon: const Icon(FluentIcons.date_time),
//     title: const Text('DatePicker'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/forms/date_picker') {
//         router.pushNamed('forms_date_picker');
//       }
//     },
//   ),
//   PaneItemHeader(header: const Text('Navigation')),
//   PaneItem(
//     key: const Key('/navigation/nav_view'),
//     icon: const Icon(FluentIcons.navigation_flipper),
//     title: const Text('NavigationView'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/navigation/nav_view') {
//         router.pushNamed('navigation_nav_view');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/navigation/tab_view'),
//     icon: const Icon(FluentIcons.table_header_row),
//     title: const Text('TabView'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/navigation/tab_view') {
//         router.pushNamed('navigation_tab_view');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/navigation/tree_view'),
//     icon: const Icon(FluentIcons.bulleted_tree_list),
//     title: const Text('TreeView'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/navigation/tree_view') {
//         router.pushNamed('navigation_tree_view');
//       }
//     },
//   ),
//   PaneItemHeader(header: const Text('Surfaces')),
//   PaneItem(
//     key: const Key('/surfaces/acrylic'),
//     icon: const Icon(FluentIcons.un_set_color),
//     title: const Text('Acrylic'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/surfaces/acrylic') {
//         router.pushNamed('surfaces_acrylic');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/surfaces/command_bar'),
//     icon: const Icon(FluentIcons.customize_toolbar),
//     title: const Text('CommandBar'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/surfaces/command_bar') {
//         router.pushNamed('surfaces_command_bar');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/surfaces/expander'),
//     icon: const Icon(FluentIcons.expand_all),
//     title: const Text('Expander'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/surfaces/expander') {
//         router.pushNamed('surfaces_expander');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/surfaces/info_bar'),
//     icon: const Icon(FluentIcons.info_solid),
//     title: const Text('InfoBar'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/surfaces/info_bar') {
//         router.pushNamed('surfaces_info_bar');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/surfaces/progress_indicators'),
//     icon: const Icon(FluentIcons.progress_ring_dots),
//     title: const Text('Progress Indicators'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/surfaces/progress_indicators') {
//         router.pushNamed('surfaces_progress_indicators');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/surfaces/tiles'),
//     icon: const Icon(FluentIcons.tiles),
//     title: const Text('Tiles'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/surfaces/tiles') {
//         router.pushNamed('surfaces_tiles');
//       }
//     },
//   ),
//   PaneItemHeader(header: const Text('Popups')),
//   PaneItem(
//     key: const Key('/popups/content_dialog'),
//     icon: const Icon(FluentIcons.comment_urgent),
//     title: const Text('ContentDialog'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/popups/content_dialog') {
//         router.pushNamed('popups_content_dialog');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/popups/tooltip'),
//     icon: const Icon(FluentIcons.hint_text),
//     title: const Text('Tooltip'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/popups/tooltip') {
//         router.pushNamed('popups_tooltip');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/popups/flyout'),
//     icon: const Icon(FluentIcons.pop_expand),
//     title: const Text('Flyout'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/popups/flyout') {
//         router.pushNamed('popups_flyout');
//       }
//     },
//   ),
//   PaneItemHeader(header: const Text('Theming')),
//   PaneItem(
//     key: const Key('/theming/colors'),
//     icon: const Icon(FluentIcons.color_solid),
//     title: const Text('Colors'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/theming/colors') {
//         router.pushNamed('theming_colors');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/theming/typography'),
//     icon: const Icon(FluentIcons.font_color_a),
//     title: const Text('Typography'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/theming/typography') {
//         router.pushNamed('theming_typography');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/theming/icons'),
//     icon: const Icon(FluentIcons.icon_sets_flag),
//     title: const Text('Icons'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/theming/icons') {
//         router.pushNamed('theming_icons');
//       }
//     },
//   ),
//   PaneItem(
//     key: const Key('/theming/reveal_focus'),
//     icon: const Icon(FluentIcons.focus),
//     title: const Text('Reveal Focus'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/theming/reveal_focus') {
//         router.pushNamed('theming_reveal_focus');
//       }
//     },
//   ),
// ];
// final List<NavigationPaneItem> footerItems = [
//   PaneItemSeparator(),
//   PaneItem(
//     key: const Key('/settings'),
//     icon: const Icon(FluentIcons.settings),
//     title: const Text('Settings'),
//     body: const SizedBox.shrink(),
//     onTap: () {
//       if (router.location != '/settings') {
//         router.pushNamed('settings');
//       }
//     },
//   ),
//   _LinkPaneItemAction(
//     icon: const Icon(FluentIcons.open_source),
//     title: const Text('Source code'),
//     link: 'https://github.com/bdlukaa/fluent_ui',
//     body: const SizedBox.shrink(),
//   ),
//   // TODO: mobile widgets, Scrollbar, BottomNavigationBar, RatingBar
// ];

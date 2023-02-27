import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:url_launcher/link.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_manager/window_manager.dart';

import 'screens/debug.dart';
import 'screens/home.dart';
import 'screens/settings.dart';
import 'screens/about.dart';

import 'routes/theming.dart' deferred as theming;

import 'constants.dart';
import 'debug.dart';
import 'theme.dart';
import 'helpers/deferred_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Constants.isSystemAccentColorSupported) {
    SystemTheme.accentColor.load();
  }

  setPathUrlStrategy();

  if (Constants.isNativeDesktop) {
    await flutter_acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.setMinimumSize(const Size(350, 600));
      await windowManager.show();
      await windowManager.setSkipTaskbar(false);
      await windowManager.setAlwaysOnTop(false);
    });
  }

  runApp(const App());

  Future.wait([
    DeferredWidget.preload(theming.loadLibrary),
  ]);

  if (Constants.isDebugMode) {
    Debug.dumpEnviroment();
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp(
          title: Constants.appTitle,
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          color: appTheme.color,
          darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
          theme: FluentThemeData(
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
          locale: appTheme.locale,
          builder: (context, child) {
            return Directionality(
              textDirection: appTheme.textDirection,
              child: NavigationPaneTheme(
                data: NavigationPaneThemeData(
                  backgroundColor: appTheme.windowEffect !=
                          flutter_acrylic.WindowEffect.disabled
                      ? Colors.transparent
                      : null,
                ),
                child: child!,
              ),
            );
          },
          initialRoute: '/',
          routes: {
            '/': (context) => const _GlobalApplication(),
          },
        );
      },
    );
  }
}

class _GlobalApplication extends StatefulWidget {
  const _GlobalApplication({Key? key}) : super(key: key);

  @override
  State<_GlobalApplication> createState() => _GlobalApplicationState();
}

class _GlobalApplicationState extends State<_GlobalApplication>
    with WindowListener {
  bool value = false;

  int navIndex = 0;

  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  final List<NavigationPaneItem> originalItems = [
    PaneItem(
      icon: const Icon(TablerIcons.home),
      title: const Text('Home'),
      body: const HomePage(),
    ),
    PaneItemHeader(header: const Text('Theming')),
    PaneItem(
      icon: const Icon(TablerIcons.color_swatch),
      title: const Text('Colors'),
      body: DeferredWidget(
        theming.loadLibrary,
        () => theming.ColorsPage(),
      ),
    ),
    PaneItem(
      icon: const Icon(TablerIcons.a_b),
      title: const Text('Typography'),
      body: DeferredWidget(
        theming.loadLibrary,
        () => theming.TypographyPage(),
      ),
    ),
    PaneItem(
      icon: const Icon(TablerIcons.icons),
      title: const Text('Icons'),
      body: DeferredWidget(
        theming.loadLibrary,
        () => theming.IconsPage(),
      ),
    ),
    PaneItem(
      icon: const Icon(TablerIcons.focus),
      title: const Text('Reveal Focus'),
      body: DeferredWidget(
        theming.loadLibrary,
        () => theming.RevealFocusPage(),
      ),
    ),
  ];
  final List<NavigationPaneItem> footerItems = [
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

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: () {
          if (Constants.isNativeDesktop) {
            return const DragToMoveArea(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(Constants.appTitle),
              ),
            );
          } else {
            return const Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(Constants.appTitle),
            );
          }
        }(),
        actions: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          if (Constants.screenWidth(context) > 600)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8.0),
              child: Align(
                child: ToggleSwitch(
                  content: const Text('Dark Mode'),
                  checked: FluentTheme.of(context).brightness.isDark,
                  onChanged: (v) {
                    if (v) {
                      appTheme.mode = ThemeMode.dark;
                    } else {
                      appTheme.mode = ThemeMode.light;
                    }
                  },
                ),
              ),
            ),
          if (Constants.isNativeDesktop) const WindowButtons(),
        ]),
      ),
      pane: NavigationPane(
        selected: navIndex,
        onChanged: (i) {
          setState(() => navIndex = i);
        },
        displayMode: appTheme.displayMode,
        indicator: () {
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return const EndNavigationIndicator();
            case NavigationIndicators.sticky:
            default:
              return const StickyNavigationIndicator();
          }
        }(),
        items: originalItems,
        autoSuggestBox: AutoSuggestBox(
          key: searchKey,
          focusNode: searchFocusNode,
          controller: searchController,
          unfocusedColor: Colors.transparent,
          items: originalItems.whereType<PaneItem>().map((item) {
            assert(item.title is Text);
            final text = (item.title as Text).data!;

            return AutoSuggestBoxItem(
              label: text,
              value: text,
              onSelected: () async {
                final navItemIndex = NavigationPane(
                  items: originalItems,
                ).effectiveIndexOf(item);

                setState(() => navIndex = navItemIndex);
                await Future.delayed(const Duration(milliseconds: 17));
                searchController.clear();
              },
            );
          }).toList(),
          placeholder: 'Search',
          trailingIcon: IgnorePointer(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(TablerIcons.search),
            ),
          ),
        ),
        autoSuggestBoxReplacement: const Icon(TablerIcons.search),
        footerItems: footerItems,
      ),
      onOpenSearch: () {
        searchFocusNode.requestFocus();
      },
    );
  }

  @override
  void onWindowClose() async {
    Navigator.pop(context);
    windowManager.destroy();
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

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

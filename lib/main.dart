// flutter & fluent ui
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter/services.dart';
import 'package:mille/persistence/adapters.dart';
import 'package:mille/widgets/scorecard.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

// data persistence
import 'package:hive_flutter/hive_flutter.dart';

import 'persistence/models/game.dart';

// native desktop
import 'package:system_theme/system_theme.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:window_manager/window_manager.dart';

// 3rd party UI
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

// local
import 'navigation.dart';
import 'constants.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (AppTheme.isSystemAccentColorSupported) {
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

  // load data persistence
  await Hive.initFlutter();
  Adapters.registerAdapters();
  await Hive.openBox<Game>('HiveGlobalApplicationState');

  // load app UI
  runApp(const App());

  // load heavy buisness logic
  /* Future.wait([
    /* DeferredWidget.preload(theming.loadLibrary), */
  ]); */
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
          themeMode: appTheme.themeMode,
          debugShowCheckedModeBanner: false,
          color: appTheme.accentColor,
          darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: appTheme.accentColor,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
          theme: FluentThemeData(
            accentColor: appTheme.accentColor,
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
          shortcuts: <LogicalKeySet, Intent>{
            // basic accessibility shortcuts
            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
            LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
            LogicalKeySet(LogicalKeyboardKey.tab): const NextFocusIntent(),
            LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.tab):
                const PreviousFocusIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                const DirectionalFocusIntent(TraversalDirection.left),
            LogicalKeySet(LogicalKeyboardKey.arrowRight):
                const DirectionalFocusIntent(TraversalDirection.right),
            LogicalKeySet(LogicalKeyboardKey.arrowUp):
                const DirectionalFocusIntent(TraversalDirection.up),
            LogicalKeySet(LogicalKeyboardKey.arrowDown):
                const DirectionalFocusIntent(TraversalDirection.down),
          },
        );
      },
    );
  }
}

class _GlobalApplication extends StatefulWidget {
  const _GlobalApplication({Key? key}) : super(key: key);

  @override
  State<_GlobalApplication> createState() => GlobalApplicationState();
}

class GlobalApplicationState extends State<_GlobalApplication>
    with WindowListener {
  late Box<Game> globalApplicationStateBox;

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();

    globalApplicationStateBox = Hive.box<Game>('HiveGlobalApplicationState');
    // TODO here
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    Navigation.searchController.dispose();
    Navigation.searchFocusNode.dispose();
    // not nessesar to call `Hive.close()`, but this will help with the in mem
    // usage of the next app startup
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();

    return NavigationView(
      key: Navigation.viewKey,
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
          if (AppTheme.screenWidth(context) > 600)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8.0),
              child: Align(
                child: ToggleSwitch(
                  content: const Text('Dark Mode'),
                  checked: FluentTheme.of(context).brightness.isDark,
                  onChanged: (v) {
                    if (v) {
                      appTheme.themeMode = ThemeMode.dark;
                    } else {
                      appTheme.themeMode = ThemeMode.light;
                    }
                  },
                ),
              ),
            ),
          if (Constants.isNativeDesktop) const WindowButtons(),
        ]),
      ),
      pane: NavigationPane(
        selected: Navigation.navIndex,
        onChanged: (i) {
          setState(() => Navigation.navIndex = i);
        },
        displayMode: appTheme.displayMode,
        items: [
          ...Navigation.navItems,
          PaneItemAction(
            icon: const Icon(TablerIcons.plus),
            title: const Text('New Game'),
            onTap: () {
              // add the new game to the `Navigation.navItems`
              Navigation.navItems.add(PaneItem(
                icon: const Icon(TablerIcons.device_gamepad_2),
                // ignore: prefer_const_constructors
                title: Text('New Game'),
                trailing: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Button(
                    child: const Icon(TablerIcons.x),
                    onPressed: () {
                      // remove this item from the `Navigation.navItems`
                      Navigation.navItems.removeLast();
                      // calll `setState` to rebuild the `NavigationView`
                      setState(() {});
                    },
                  ),
                ),

                body: const ScoreCard(),
              ));
              // calll `setState` to rebuild the `NavigationView`
              setState(() {});
            },
          ),
        ],
        autoSuggestBox: AutoSuggestBox(
          key: Navigation.searchKey,
          focusNode: Navigation.searchFocusNode,
          controller: Navigation.searchController,
          unfocusedColor: Colors.transparent,
          items: Navigation.navItems.whereType<PaneItem>().map((item) {
            assert(item.title is Text);
            final text = (item.title as Text).data!;

            return AutoSuggestBoxItem(
              label: text,
              value: text,
              onSelected: () async {
                int navItemIndex = NavigationPane(
                  items: Navigation.navItems,
                ).effectiveIndexOf(item);

                setState(() => Navigation.navIndex = navItemIndex);
                Navigation.searchController.clear();
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
        footerItems: Navigation.navFooterItems,
      ),
      onOpenSearch: () {
        Navigation.searchFocusNode.requestFocus();
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

// flutter & fluent ui
import 'package:fluent_ui/fluent_ui.dart' hide Page, FluentIcons;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:go_router/go_router.dart';

// data persistence
import 'package:hive_flutter/hive_flutter.dart';

import 'handlers.dart';
import 'persistence/adapters.dart';
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
import 'widgets/desktop/window_buttons.dart';

// ffi
import 'ffi/ffi.dart' if (dart.library.html) 'ffi/ffi_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform platform = await api.platform();
  bool isRelease = await api.rustReleaseMode();
  print(await api.add(a: 1, b: 2));
  print(platform);
  print(isRelease);

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
  await Hive.openBox<Game>('GameBox');

  // load app UI
  runApp(const App());

  // load heavy buisness logic
  /* Future.wait([
    /* DeferredWidget.preload(theming.loadLibrary), */
  ]); */

  for (final Game game in Handlers.getAllGames()) {
    print(game.gameID);
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // private navigators

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp.router(
          title: AppTheme.appTitle,
          themeMode: appTheme.themeMode,
          debugShowCheckedModeBanner: false,
          color: appTheme.accentColor,
          darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: appTheme.accentColor,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          theme: FluentThemeData(
            accentColor: appTheme.accentColor,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
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
          routeInformationParser: Navigation.router.routeInformationParser,
          routerDelegate: Navigation.router.routerDelegate,
          routeInformationProvider: Navigation.router.routeInformationProvider,
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

class GlobalApplication extends StatefulWidget {
  const GlobalApplication({
    Key? key,
    required this.child,
    required this.shellContext,
    required this.state,
  }) : super(key: key);

  final Widget child;
  final BuildContext? shellContext;
  final GoRouterState state;

  @override
  State<GlobalApplication> createState() => GlobalApplicationState();
}

class GlobalApplicationState extends State<GlobalApplication>
    with WindowListener {
  late Box<Game> gameBox;
  bool value = false;

  // int index = 0;

  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
    gameBox = Hive.box<Game>('GameBox');
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    Navigation.searchController.dispose();
    Navigation.searchFocusNode.dispose();
    // not nessesary to call `Hive.close()`, but this will help with the in mem
    // usage of the next app startup
    Hive.close();
    super.dispose();
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = Navigation.router.location;
    int indexOriginal = Navigation.navItems
        .where((element) => element.key != null)
        .toList()
        .indexWhere((element) => element.key == Key(location));

    if (indexOriginal == -1) {
      int indexFooter = Navigation.navFooterItems
          .where((element) => element.key != null)
          .toList()
          .indexWhere((element) => element.key == Key(location));
      if (indexFooter == -1) {
        return 0;
      }
      return Navigation.navItems
              .where((element) => element.key != null)
              .toList()
              .length +
          indexFooter;
    } else {
      return indexOriginal;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final localizations = FluentLocalizations.of(context);

    final appTheme = context.watch<AppTheme>();
    final theme = FluentTheme.of(context);
    if (widget.shellContext != null) {
      if (Navigation.router.canPop() == false) {
        setState(() {});
      }
    }
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: () {
          if (Constants.isWeb) {
            return const Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(Constants.appTitle),
            );
          }
          return const DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(Constants.appTitle),
            ),
          );
        }(),
        actions: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!Constants.isMobile)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 8.0),
                child: Center(
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
            if (!Constants.isWeb) const WindowButtons(),
          ],
        ),
      ),
      paneBodyBuilder: (item, child) {
        final name =
            item?.key is ValueKey ? (item!.key as ValueKey).value : null;
        return FocusTraversalGroup(
          key: ValueKey('body$name'),
          child: widget.child,
        );
      },
      pane: NavigationPane(
        selected: _calculateSelectedIndex(context),
        header: SizedBox(
          height: kOneLineTileHeight,
          child: ShaderMask(
            shaderCallback: (rect) {
              final color = appTheme.accentColor.defaultBrushFor(
                theme.brightness,
              );
              return LinearGradient(
                colors: [
                  color,
                  color,
                ],
              ).createShader(rect);
            },
          ),
        ),
        displayMode: appTheme.displayMode,
        items: Navigation.navItems,
        autoSuggestBox: AutoSuggestBox(
          key: searchKey,
          focusNode: searchFocusNode,
          controller: searchController,
          unfocusedColor: Colors.transparent,
          items: Navigation.navItems.whereType<PaneItem>().map((item) {
            assert(item.title is Text);
            final text = (item.title as Text).data!;
            return AutoSuggestBoxItem(
              label: text,
              value: text,
              onSelected: () {
                item.onTap?.call();
                searchController.clear();
              },
            );
          }).toList(),
          trailingIcon: IgnorePointer(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(TablerIcons.search),
            ),
          ),
          placeholder: 'Search',
        ),
        autoSuggestBoxReplacement: const Icon(TablerIcons.search),
        footerItems: Navigation.navFooterItems,
      ),
      onOpenSearch: () {
        searchFocusNode.requestFocus();
      },
    );
  }
}

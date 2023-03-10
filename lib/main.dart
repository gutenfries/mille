import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter/services.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_manager/window_manager.dart';

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

  runApp(const App());

  // load heavy buisness logic
  Future.wait([
    /* DeferredWidget.preload(theming.loadLibrary), */
  ]);
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
  State<_GlobalApplication> createState() => _GlobalApplicationState();
}

class _GlobalApplicationState extends State<_GlobalApplication>
    with WindowListener {
  bool value = false;

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
        selected: navIndex,
        onChanged: (i) {
          setState(() => navIndex = i);
        },
        displayMode: appTheme.displayMode,
        items: navItems,
        autoSuggestBox: AutoSuggestBox(
          key: searchKey,
          focusNode: searchFocusNode,
          controller: searchController,
          unfocusedColor: Colors.transparent,
          items: navItems.whereType<PaneItem>().map((item) {
            assert(item.title is Text);
            final text = (item.title as Text).data!;

            return AutoSuggestBoxItem(
              label: text,
              value: text,
              onSelected: () async {
                final navItemIndex = NavigationPane(
                  items: navItems,
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
        footerItems: navFooterItems,
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

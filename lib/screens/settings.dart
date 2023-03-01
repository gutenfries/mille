import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../theme.dart';
import '../widgets/page.dart';

const List<String> accentColorNames = [
  'System',
  'Yellow',
  'Orange',
  'Red',
  'Magenta',
  'Purple',
  'Blue',
  'Teal',
  'Green',
];

class SettingsScreen extends ScrollablePage {
  SettingsScreen({super.key});

  @override
  Widget buildHeader(BuildContext context) {
    return const PageHeader(
      title: Text('Settings'),
      commandBar: Align(
        alignment: Alignment.centerRight,
        child: Icon(TablerIcons.settings, size: 24.0),
      ),
    );
  }

  @override
  List<Widget> buildScrollable(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final appTheme = context.watch<AppTheme>();

    return [
      appTheme.spacingLarge,
      Text('Theme mode', style: FluentTheme.of(context).typography.subtitle),
      appTheme.spacingSmall,
      ...List.generate(ThemeMode.values.length, (index) {
        final mode = ThemeMode.values[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RadioButton(
            checked: appTheme.themeMode == mode,
            onChanged: (value) {
              if (value) {
                appTheme.themeMode = mode;

                if (AppTheme.isWindowEffectsSupported) {
                  // some window effects require on [dark] to look good.
                  // appTheme.setEffect(WindowEffect.disabled, context);
                  appTheme.setWindowEffect(appTheme.windowEffect, context);
                }
              }
            },
            content: Text('$mode'.replaceAll('ThemeMode.', '')),
          ),
        );
      }),
      appTheme.spacingLarge,
      Text(
        'Navigation Display Mode',
        style: FluentTheme.of(context).typography.subtitle,
      ),
      appTheme.spacingSmall,
      ...List.generate(PaneDisplayMode.values.length, (index) {
        final mode = PaneDisplayMode.values[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RadioButton(
            checked: appTheme.displayMode == mode,
            onChanged: (value) {
              if (value) appTheme.displayMode = mode;
            },
            content: Text(
              mode.toString().replaceAll('PaneDisplayMode.', ''),
            ),
          ),
        );
      }),
      appTheme.spacingLarge,
      Text('Accent Color', style: FluentTheme.of(context).typography.subtitle),
      appTheme.spacingSmall,
      Wrap(children: [
        Tooltip(
          message: accentColorNames[0],
          child: _buildColorBlock(appTheme, appTheme.systemAccentColor),
        ),
        ...List.generate(Colors.accentColors.length, (index) {
          final color = Colors.accentColors[index];
          return Tooltip(
            message: accentColorNames[index + 1],
            child: _buildColorBlock(appTheme, color),
          );
        }),
      ]),
      if (AppTheme.isWindowEffectsSupported) ...[
        appTheme.spacingLarge,
        Text(
          'Window Transparency Effects (${Constants.currentPlatform.toString().replaceAll('TargetPlatform.', '')[0].toUpperCase()}${Constants.currentPlatform.toString().replaceAll('TargetPlatform.', '').substring(1)})',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        appTheme.spacingSmall,
        ...List.generate(AppTheme.supportedWindowEffects.length, (index) {
          final mode = AppTheme.supportedWindowEffects[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: RadioButton(
              checked: appTheme.windowEffect == mode,
              onChanged: (value) {
                if (value) {
                  appTheme.windowEffect = mode;
                  appTheme.setWindowEffect(mode, context);
                }
              },
              content: Text(
                mode.toString().replaceAll('WindowEffect.', ''),
              ),
            ),
          );
        }),
      ],
      appTheme.spacingLarge,
      Text('Text Direction',
          style: FluentTheme.of(context).typography.subtitle),
      appTheme.spacingSmall,
      ...List.generate(TextDirection.values.length, (index) {
        final direction = TextDirection.values[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RadioButton(
            checked: appTheme.textDirection == direction,
            onChanged: (value) {
              if (value) {
                appTheme.textDirection = direction;
              }
            },
            content: Text(
              '$direction'
                  .replaceAll('TextDirection.', '')
                  .replaceAll('rtl', 'Right to left')
                  .replaceAll('ltr', 'Left to right'),
            ),
          ),
        );
      }).reversed,
      appTheme.spacingLarge,
      Text('Locale', style: FluentTheme.of(context).typography.subtitle),
      appTheme.spacingSmall,
      Wrap(
        spacing: 15.0,
        runSpacing: 10.0,
        children: List.generate(
          appTheme.supportedLocales.length,
          (index) {
            final locale = appTheme.supportedLocales[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RadioButton(
                checked: appTheme.currentLocale(context) == locale,
                onChanged: (value) {
                  if (value) {
                    appTheme.locale = locale;
                  }
                },
                content: Text('$locale'),
              ),
            );
          },
        ),
      ),
    ];
  }

  Widget _buildColorBlock(AppTheme appTheme, AccentColor color) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Button(
        onPressed: () {
          appTheme.accentColor = color;
        },
        style: ButtonStyle(
          padding: ButtonState.all(EdgeInsets.zero),
          backgroundColor: ButtonState.resolveWith((states) {
            if (states.isPressing) {
              return color.light;
            } else if (states.isHovering) {
              return color.lighter;
            }
            return color;
          }),
        ),
        child: Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          child: appTheme.accentColor == color
              ? Icon(
                  TablerIcons.check,
                  color: color.basedOnLuminance(),
                  size: 22.0,
                )
              : null,
        ),
      ),
    );
  }
}

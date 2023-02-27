import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../theme.dart';
import '../widgets/page.dart';

class DebugScreen extends ScrollablePage {
  DebugScreen({super.key});

  @override
  Widget buildHeader(BuildContext context) {
    return const PageHeader(
      title: Text('Debug'),
      commandBar: Align(
        alignment: Alignment.centerRight,
        child: Icon(TablerIcons.bug, size: 24.0),
      ),
    );
  }

  @override
  List<Widget> buildScrollable(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final appTheme = context.watch<AppTheme>();
    const spacer = SizedBox(height: 10.0);
    const biggerSpacer = SizedBox(height: 40.0);

    const supportedLocales = FluentLocalizations.supportedLocales;
    final currentLocale =
        appTheme.locale ?? Localizations.maybeLocaleOf(context);

    return [
      biggerSpacer,
      Text('Theme mode', style: FluentTheme.of(context).typography.subtitle),
      spacer,
      ...List.generate(ThemeMode.values.length, (index) {
        final mode = ThemeMode.values[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RadioButton(
            checked: appTheme.mode == mode,
            onChanged: (value) {
              if (value) {
                appTheme.mode = mode;

                if (Constants.isWindowEffectsSupported) {
                  // some window effects require on [dark] to look good.
                  // appTheme.setEffect(WindowEffect.disabled, context);
                  appTheme.setEffect(appTheme.windowEffect, context);
                }
              }
            },
            content: Text('$mode'.replaceAll('ThemeMode.', '')),
          ),
        );
      }),
      biggerSpacer,
      Text(
        'Navigation Display Mode',
        style: FluentTheme.of(context).typography.subtitle,
      ),
      spacer,
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
      biggerSpacer,
      Text('Text Direction',
          style: FluentTheme.of(context).typography.subtitle),
      spacer,
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
      biggerSpacer,
      Text('Locale', style: FluentTheme.of(context).typography.subtitle),
      spacer,
      Wrap(
        spacing: 15.0,
        runSpacing: 10.0,
        children: List.generate(
          supportedLocales.length,
          (index) {
            final locale = supportedLocales[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RadioButton(
                checked: currentLocale == locale,
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
          appTheme.color = color;
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
          child: appTheme.color == color
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

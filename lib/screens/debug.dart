import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
// import 'package:provider/provider.dart';

import '../constants.dart';
import '../theme.dart';
import '../widgets/helpers/page.dart';
import '../widgets/helpers/spacing.dart';

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
    // final appTheme = context.watch<AppTheme>();
    final theme = FluentTheme.of(context);

    return [
      Text(
        'Run Mode',
        style: FluentTheme.of(context).typography.subtitle,
      ),
      Spacing.small(),
      SyntaxView(
        code: '''
            isDebugMode: ${Constants.isDebugMode},
            isProfileMode: ${Constants.isProfileMode},
            isReleaseMode: ${Constants.isReleaseMode},
'''
            .replaceAll('            ', ''),
        syntaxTheme: theme.brightness.isDark
            ? SyntaxTheme.vscodeDark()
            : SyntaxTheme.vscodeLight(),
        fontSize: 16,
      ),
      Spacing.large(),
      Text(
        'Runtime Platform',
        style: FluentTheme.of(context).typography.subtitle,
      ),
      Spacing.small(),
      SyntaxView(
        code: '''
            currentPlatform: ${Constants.currentPlatform},

            isWeb: ${Constants.isWeb},

            isNative: ${Constants.isNative},

            isWindows: ${Constants.isWindows},
            isLinux: ${Constants.isLinux},
            isMacOS: ${Constants.isMacOS},
            isAndroid: ${Constants.isAndroid},
            isIOS: ${Constants.isIOS},

            isNativeWindows: ${Constants.isNativeWindows},
            isNativeLinux: ${Constants.isNativeLinux},
            isNativeMacOS: ${Constants.isNativeMacOS},
            isNativeAndroid: ${Constants.isNativeAndroid},
            isNativeIOS: ${Constants.isNativeIOS},
'''
            .replaceAll('            ', ''),
        syntaxTheme: theme.brightness.isDark
            ? SyntaxTheme.vscodeDark()
            : SyntaxTheme.vscodeLight(),
        fontSize: 16,
      ),
      Spacing.large(),
      Text(
        'Dimmensions',
        style: FluentTheme.of(context).typography.subtitle,
      ),
      Spacing.small(),
      SyntaxView(
        code: '''
            screenWidth: ${AppTheme.screenWidth(context)},
            screenHeight: ${AppTheme.screenHeight(context)},
            screenSize: ${AppTheme.screenSize(context)},
'''
            .replaceAll('            ', ''),
        syntaxTheme: theme.brightness.isDark
            ? SyntaxTheme.vscodeDark()
            : SyntaxTheme.vscodeLight(),
        fontSize: 16,
      ),
    ];
  }
}

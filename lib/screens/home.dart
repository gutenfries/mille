import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../widgets/changelog.dart';
import '../widgets/helpers/page.dart';
import '../widgets/helpers/spacing.dart';
import '../widgets/shortcuts.dart';
import '../widgets/sponsor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with PageMixin {
  bool selected = true;
  String? comboboxValue;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    // final theme = FluentTheme.of(context);

    return ScaffoldPage.scrollable(
      header: const PageHeader(
        title: Text('Home'),
        commandBar: Align(
          alignment: Alignment.centerRight,
          child: Icon(TablerIcons.home, size: 24.0),
        ),
      ),
      children: [
        const ShortCuts(),
        Spacing.extraLarge(),
        const ChangeLogButton(),
        Spacing.extraLarge(),
        const SponsorsCard(),
      ],
    );
  }
}

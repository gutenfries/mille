import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import '../theme.dart';
import '../widgets/helpers/page.dart';

class AboutScreen extends ScrollablePage {
  AboutScreen({super.key});

  @override
  Widget buildHeader(BuildContext context) {
    return const PageHeader(
      title: Text('About'),
      commandBar: Align(
        alignment: Alignment.centerRight,
        child: Icon(TablerIcons.info_circle, size: 24.0),
      ),
    );
  }

  @override
  List<Widget> buildScrollable(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final appTheme = context.watch<AppTheme>();

    return [];
  }
}

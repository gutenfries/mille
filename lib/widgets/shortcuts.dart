import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../navigation.dart';

class ShortCuts extends StatelessWidget {
  const ShortCuts({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(TablerIcons.settings),
            title: const Text('Settings'),
            onPressed: () {
              print('hi mom');
              Navigator.of(context).pushNamed('settings');
            },
          ),
          ListTile(
            leading: const Icon(TablerIcons.info_circle),
            title: const Text('Rules'),
            onPressed: () {},
          ),
          ListTile(
            leading: const Icon(TablerIcons.info_circle),
            title: const Text('Settings'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

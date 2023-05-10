import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../navigation.dart';

class ShortCuts extends StatelessWidget {
  const ShortCuts({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Shortcuts',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListTile(
                leading: const Icon(TablerIcons.settings),
                title: const Text('Settings'),
                onPressed: () {
                  if (Navigation.router.location != '/settings') {
                    Navigation.router.pushNamed('settings');
                  }
                },
              ),
            ),
            Expanded(
              child: ListTile(
                leading: const Icon(TablerIcons.info_circle),
                title: const Text('Rules'),
                onPressed: () {
                  if (Navigation.router.location != '/rules') {
                    Navigation.router.pushNamed('rules');
                  }
                },
              ),
            ),
            Expanded(
              child: ListTile(
                leading: const Icon(TablerIcons.info_circle),
                title: const Text('Settings'),
                onPressed: () {
                  if (Navigation.router.location != '/settings') {
                    Navigation.router.pushNamed('settings');
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

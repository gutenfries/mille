import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class CrudBar extends StatelessWidget {
  const CrudBar({super.key});

  /// Define list of CommandBarItem
  static final simpleCommandBarItems = <CommandBarItem>[
    CommandBarBuilderItem(
      builder: (context, mode, w) => Tooltip(
        message: 'Create a new ScoreCard',
        child: w,
      ),
      wrappedItem: CommandBarButton(
        icon: const Icon(TablerIcons.plus),
        label: const Text('New'),
        onPressed: () {
          // TODO
          throw UnimplementedError();
        },
      ),
    ),
    CommandBarBuilderItem(
      builder: (context, mode, w) => Tooltip(
        message: 'Delete the selected ScoreCard',
        child: w,
      ),
      wrappedItem: CommandBarButton(
        icon: const Icon(TablerIcons.trash),
        label: const Text('Delete'),
        onPressed: () {
          // TODO
          throw UnimplementedError();
        },
      ),
    ),
    CommandBarBuilderItem(
      builder: (context, mode, w) => Tooltip(
        message: 'Search for a ScoreCard',
        child: w,
      ),
      wrappedItem: CommandBarButton(
        icon: const Icon(TablerIcons.search),
        label: const Text('Search'),
        onPressed: () {
          // TODO
          throw UnimplementedError();
        },
      ),
    ),
    CommandBarBuilderItem(
      builder: (context, mode, w) => Tooltip(
        message: 'Pin Selected ScoreCard(s)',
        child: w,
      ),
      wrappedItem: CommandBarButton(
        icon: const Icon(TablerIcons.pin),
        label: const Text('Pin'),
        onPressed: () {
          // TODO
          throw UnimplementedError();
        },
      ),
    ),
    CommandBarBuilderItem(
      builder: (context, mode, w) => Tooltip(
        message: 'Unpin Selected ScoreCard(s)',
        child: w,
      ),
      wrappedItem: CommandBarButton(
        icon: const Icon(TablerIcons.pinned_off),
        label: const Text('Unpin'),
        onPressed: () {
          // TODO
          throw UnimplementedError();
        },
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CommandBarCard(
      child: Row(
        children: [
          Expanded(
            child: CommandBar(
              overflowBehavior: CommandBarOverflowBehavior.scrolling,
              primaryItems: [
                ...simpleCommandBarItems,
              ],
            ),
          ),
          // End-aligned button(s)
          CommandBar(
            overflowBehavior: CommandBarOverflowBehavior.noWrap,
            primaryItems: [
              CommandBarBuilderItem(
                builder: (context, mode, w) => Tooltip(
                  message: 'Refresh content',
                  child: w,
                ),
                wrappedItem: CommandBarButton(
                  icon: const Icon(TablerIcons.refresh),
                  label: const Text('Refresh'),
                  onPressed: () {
                    // TODO
                    throw UnimplementedError();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

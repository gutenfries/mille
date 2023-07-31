import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;

mixin HeaderRow {
  Widget headerRow() => Row(
        children: [
          const Expanded(
            child: Column(),
          ),
          for (int i = 0; i < 3; i++)
            Expanded(
              child: Text(
                'Player ${i + 1}',
                textAlign: TextAlign.center,
              ),
            ),
        ],
      );
}

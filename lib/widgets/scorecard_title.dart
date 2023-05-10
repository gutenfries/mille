import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;

class ScoreCardTitle extends StatelessWidget {
  final String title;

  const ScoreCardTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(2),
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    );
  }
}

import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;

import 'scorecard_title.dart';

class ScoreCard extends StatefulWidget {
  final String title;
  final String gameID;

  const ScoreCard({
    required this.title,
    required this.gameID,
    super.key,
  });

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  final List<Widget> players = [];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      // ignore: prefer_const_constructors
      header: PageHeader(
        title: Text(widget.title),
      ),
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        for (final String title in [
                          'Player',
                          'Miles',
                          'Safeties',
                          'Poofs',
                          'Trip Completed',
                          'Delayed Action',
                          'Safe Trip',
                          'Extension',
                          'All Safeties',
                          'Shutout',
                          'Total',
                        ])
                          ScoreCardTitle(title: title),
                      ],
                    ),
                  ),
                ),
                ...players,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

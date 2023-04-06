import 'package:fluent_ui/fluent_ui.dart';

import '../../scorecard.dart' show ScoreCard;

mixin TotalRow on State<ScoreCard> {
  static final Map<String, bool> state_ = {
    'player1Total': false,
    'player2Total': false,
    'player3Total': false,
  };

  Widget totalRow() => Row(
        children: [
          const Expanded(
            child: Text(
              'Total',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Card(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: 30,
                child: Text(state_[0].toString()),
              ),
            ),
          ),
          Expanded(
            child: Card(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: 30,
                child: Text(state_[0].toString()),
              ),
            ),
          ),
          Expanded(
            child: Card(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: 30,
                child: Text(state_[0].toString()),
              ),
            ),
          ),
        ],
      );
}

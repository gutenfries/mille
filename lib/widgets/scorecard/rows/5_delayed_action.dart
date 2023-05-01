import 'package:fluent_ui/fluent_ui.dart';

import '../../../widgets/scorecard.dart' show ScoreCard;

mixin DelayedActionRow on State<ScoreCard> {
  static final Map<String, bool> state_ = {
    'player1DelayedAction': false,
    'player2DelayedAction': false,
    'player3DelayedAction': false,
  };

  Widget delayedActionRow() => Row(
        children: [
          const Expanded(
            child: Text(
              'Delayed Action',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Card(
              padding: const EdgeInsets.all(0),
              child: Align(
                child: Checkbox(
                  checked: state_['player1DelayedAction'],
                  onChanged: (value) => setState(
                    () => state_['player1DelayedAction'] = value!,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              padding: const EdgeInsets.all(0),
              child: Align(
                child: Checkbox(
                  checked: state_['player2DelayedAction'],
                  onChanged: (value) => setState(
                    () => state_['player2DelayedAction'] = value!,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              padding: const EdgeInsets.all(0),
              child: Align(
                child: Checkbox(
                  checked: state_['player3DelayedAction'],
                  onChanged: (value) => setState(
                    () => state_['player3DelayedAction'] = value!,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

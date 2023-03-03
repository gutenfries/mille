import 'package:fluent_ui/fluent_ui.dart';

import '../scorecard.dart' show ScoreCard;

mixin TripCompletedRow on State<ScoreCard> {
  static final Map<String, bool> state_ = {
    'player1TripCompleted': false,
    'player2TripCompleted': false,
    'player3TripCompleted': false,
  };

  Widget tripCompletedRow() => Row(
        children: [
          const Expanded(
            child: Text(
              'Trip Completed',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Card(
              padding: const EdgeInsets.all(0),
              child: Align(
                child: Checkbox(
                  checked: state_['player1TripCompleted'],
                  onChanged: (value) => setState(
                    () => state_['player1TripCompleted'] = value!,
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
                  checked: state_['player2TripCompleted'],
                  onChanged: (value) => setState(
                    () => state_['player2TripCompleted'] = value!,
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
                  checked: state_['player3TripCompleted'],
                  onChanged: (value) => setState(
                    () => state_['player3TripCompleted'] = value!,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

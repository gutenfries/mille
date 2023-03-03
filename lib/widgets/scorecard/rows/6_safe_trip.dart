import 'package:fluent_ui/fluent_ui.dart';

import '../scorecard.dart' show ScoreCard;

mixin SafeTripRow on State<ScoreCard> {
  static final Map<String, bool> state_ = {
    'player1SafeTrip': false,
    'player2SafeTrip': false,
    'player3SafeTrip': false,
  };

  Widget safeTripRow() => Row(
        children: [
          const Expanded(
            child: Text(
              'Safe Trip',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Card(
              padding: const EdgeInsets.all(0),
              child: Align(
                child: Checkbox(
                  checked: state_['player1SafeTrip'],
                  onChanged: (value) => setState(
                    () => state_['player1SafeTrip'] = value!,
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
                  checked: state_['player2SafeTrip'],
                  onChanged: (value) => setState(
                    () => state_['player2SafeTrip'] = value!,
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
                  checked: state_['player3SafeTrip'],
                  onChanged: (value) => setState(
                    () => state_['player3SafeTrip'] = value!,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

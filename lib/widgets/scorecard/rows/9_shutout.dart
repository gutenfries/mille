import 'package:fluent_ui/fluent_ui.dart';

import '../../scorecard.dart' show ScoreCard;

mixin ShutoutRow on State<ScoreCard> {
  static final Map<String, bool> state_ = {
    'player1Shutout': false,
    'player2Shutout': false,
    'player3Shutout': false,
  };

  Widget shutoutRow() => Row(
        children: [
          const Expanded(
            child: Text(
              'Shutout',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Card(
              padding: const EdgeInsets.all(0),
              child: Align(
                child: Checkbox(
                  checked: state_['player1Shutout'],
                  onChanged: (value) => setState(
                    () => state_['player1Shutout'] = value!,
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
                  checked: state_['player2Shutout'],
                  onChanged: (value) => setState(
                    () => state_['player2Shutout'] = value!,
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
                  checked: state_['player3Shutout'],
                  onChanged: (value) => setState(
                    () => state_['player3Shutout'] = value!,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

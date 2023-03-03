import 'package:fluent_ui/fluent_ui.dart';

import '../scorecard.dart' show ScoreCard;

mixin AllSafetiesRow on State<ScoreCard> {
  static final Map<String, bool> state_ = {
    'player1AllSafeties': false,
    'player2AllSafeties': false,
    'player3AllSafeties': false,
  };

  Widget allSafetiesRow() => Row(
        children: [
          const Expanded(
            child: Text(
              'All Safeties',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Card(
              padding: const EdgeInsets.all(0),
              child: Align(
                child: Checkbox(
                  checked: state_['player1AllSafeties'],
                  onChanged: (value) => setState(
                    () => state_['player1AllSafeties'] = value!,
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
                  checked: state_['player2AllSafeties'],
                  onChanged: (value) => setState(
                    () => state_['player2AllSafeties'] = value!,
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
                  checked: state_['player3AllSafeties'],
                  onChanged: (value) => setState(
                    () => state_['player3AllSafeties'] = value!,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

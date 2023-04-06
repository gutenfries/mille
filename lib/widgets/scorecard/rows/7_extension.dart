import 'package:fluent_ui/fluent_ui.dart';

import '../../scorecard.dart' show ScoreCard;

mixin ExtensionRow on State<ScoreCard> {
  static final Map<String, bool> state_ = {
    'player1Extension': false,
    'player2Extension': false,
    'player3Extension': false,
  };

  Widget extensionRow() => Row(
        children: [
          const Expanded(
            child: Text(
              'Extension',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Card(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: 30,
                child: Align(
                  child: Checkbox(
                    checked: state_['player1Extension'],
                    onChanged: (value) => setState(
                      () => state_['player1Extension'] = value!,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: 30,
                child: Align(
                  child: Checkbox(
                    checked: state_['player2Extension'],
                    onChanged: (value) => setState(
                      () => state_['player2Extension'] = value!,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: 30,
                child: Align(
                  child: Checkbox(
                    checked: state_['player3Extension'],
                    onChanged: (value) => setState(
                      () => state_['player3Extension'] = value!,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

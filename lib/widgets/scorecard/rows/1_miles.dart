import 'package:fluent_ui/fluent_ui.dart';

import '../../../constants.dart';
import '../../../widgets/scorecard.dart' show ScoreCard;

mixin MilesRow on State<ScoreCard> {
  static final Map<String, int> state = {
    'player1Miles': 0,
    'player2Miles': 0,
    'player3Miles': 0,
  };

  Widget milesRow() => Row(
        children: [
          const Expanded(
            child: Text(
              'Miles',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: TextBox(
              placeholder: '0',
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true, signed: true),
              inputFormatters: [
                Constants.signedFloatRegex,
              ],
            ),
          ),
          Expanded(
            child: TextBox(
              placeholder: '0',
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true, signed: true),
              inputFormatters: [
                Constants.signedFloatRegex,
              ],
            ),
          ),
          Expanded(
            child: TextBox(
              placeholder: '0',
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true, signed: true),
              inputFormatters: [
                Constants.signedFloatRegex,
              ],
            ),
          ),
        ],
      );
}

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../scorecard.dart' show ScoreCard;

mixin PoofsRow on State<ScoreCard> {
  static const List<int> poofs = [0, 1, 2, 3, 4];

  static final Map<String, int> state = {
    'player1Poofs': poofs[0],
    'player2Poofs': poofs[0],
    'player3Poofs': poofs[0],
  };

  Widget poofsRow() => Row(
        children: [
          const Expanded(
            child: Text(
              'Poofs',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ComboBox<int>(
              icon: const Icon(TablerIcons.chevron_down),
              items: poofs
                  .map(
                    (safetyNum) => ComboBoxItem(
                      value: safetyNum,
                      child: Text(safetyNum.toString()),
                    ),
                  )
                  .toList(),
              placeholder: Text(poofs[0].toString()),
              value: state['player1Poofs'],
              onChanged: (value) => setState(
                () => state['player1Poofs'] = value!,
              ),
            ),
          ),
          Expanded(
            child: ComboBox<int>(
              icon: const Icon(TablerIcons.chevron_down),
              items: poofs
                  .map(
                    (safetyNum) => ComboBoxItem(
                      value: safetyNum,
                      child: Text(safetyNum.toString()),
                    ),
                  )
                  .toList(),
              placeholder: Text(poofs[0].toString()),
              value: state['player2Poofs'],
              onChanged: (value) => setState(
                () => state['player2Poofs'] = value!,
              ),
            ),
          ),
          Expanded(
            child: ComboBox<int>(
              icon: const Icon(TablerIcons.chevron_down),
              items: poofs
                  .map(
                    (safetyNum) => ComboBoxItem(
                      value: safetyNum,
                      child: Text(safetyNum.toString()),
                    ),
                  )
                  .toList(),
              placeholder: Text(poofs[0].toString()),
              value: state['player3Poofs'],
              onChanged: (value) => setState(
                () => state['player3Poofs'] = value!,
              ),
            ),
          ),
        ],
      );
}

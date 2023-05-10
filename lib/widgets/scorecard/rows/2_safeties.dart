import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../widgets/scorecard.dart' show ScoreCard;

mixin SafetiesRow on State<ScoreCard> {
  static const List<int> safeties = [0, 1, 2, 3, 4];

  static final Map<String, int> state = {
    'player1Safeties': safeties[0],
    'player2Safeties': safeties[0],
    'player3Safeties': safeties[0],
  };

  Widget safetiesRow() => Row(
        children: [
          const Expanded(
            child: Text(
              'Safeties',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ComboBox<int>(
              icon: const Icon(TablerIcons.chevron_down),
              items: safeties
                  .map(
                    (safetyNum) => ComboBoxItem(
                      value: safetyNum,
                      child: Text(safetyNum.toString()),
                    ),
                  )
                  .toList(),
              placeholder: Text(safeties[0].toString()),
              value: state['player1Safeties'],
              onChanged: (value) => setState(
                () => state['player1Safeties'] = value!,
              ),
            ),
          ),
          Expanded(
            child: ComboBox<int>(
              icon: const Icon(TablerIcons.chevron_down),
              items: safeties
                  .map(
                    (safetyNum) => ComboBoxItem(
                      value: safetyNum,
                      child: Text(safetyNum.toString()),
                    ),
                  )
                  .toList(),
              placeholder: Text(safeties[0].toString()),
              value: state['player2Safeties'],
              onChanged: (value) => setState(
                () => state['player2Safeties'] = value!,
              ),
            ),
          ),
          Expanded(
            child: ComboBox<int>(
              icon: const Icon(TablerIcons.chevron_down),
              items: safeties
                  .map(
                    (safetyNum) => ComboBoxItem(
                      value: safetyNum,
                      child: Text(safetyNum.toString()),
                    ),
                  )
                  .toList(),
              placeholder: Text(safeties[0].toString()),
              value: state['player3Safeties'],
              onChanged: (value) => setState(
                () => state['player3Safeties'] = value!,
              ),
            ),
          ),
        ],
      );
}

import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../constants.dart';
import 'scorecard_title.dart';

class Player extends StatefulWidget {
  final String playerID;

  const Player({
    super.key,
    required this.playerID,
  });

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  Map<String, dynamic> playerState = {
    'player': 'Player',
    'miles': 0,
    'safeties': 0,
    'poofs': 0,
    'tripCompleted': false,
    'delayedAction': false,
    'safeTrip': false,
    'extension': false,
    'allSafeties': false,
    'shutout': false,
    'total': 0,
  };

  static const List<int> zeroToFour = [0, 1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Player name
        ScoreCardTitle(title: playerState['player']),
        // Miles
        TextBox(
          placeholder: '0',
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: true),
          inputFormatters: [
            Constants.signedFloatRegex,
          ],
          onSubmitted: (val) => {
            setState(() {
              playerState['miles'] = int.parse(val);
            })
          },
        ),
        // Safeties
        ComboBox<int>(
          icon: const Icon(TablerIcons.chevron_down),
          items: zeroToFour
              .map(
                (safetyNum) => ComboBoxItem(
                  value: safetyNum,
                  child: Text(safetyNum.toString()),
                ),
              )
              .toList(),
          placeholder: Text(zeroToFour[0].toString()),
          value: playerState['safeties'],
          onChanged: (value) => setState(
            () => playerState['safeties'] = value!,
          ),
        ),
      ],
    );
  }
}

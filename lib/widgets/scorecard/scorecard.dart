import 'package:fluent_ui/fluent_ui.dart';

import './rows.dart';

class ScoreCard extends StatefulWidget {
  const ScoreCard({Key? key}) : super(key: key);

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard>
    with
        HeaderRow,
        MilesRow,
        SafetiesRow,
        PoofsRow,
        TripCompletedRow,
        DelayedActionRow,
        SafeTripRow,
        ExtensionRow,
        AllSafetiesRow,
        ShutoutRow,
        TotalRow {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Game Title')),
      children: [
        SizedBox(
          width: double.infinity,
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: SizedBox(
              height: 400,
              child: Card(
                child: Column(
                  children: [
                    headerRow(),
                    milesRow(),
                    safetiesRow(),
                    poofsRow(),
                    tripCompletedRow(),
                    delayedActionRow(),
                    safeTripRow(),
                    extensionRow(),
                    allSafetiesRow(),
                    shutoutRow(),
                    totalRow(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

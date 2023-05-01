import 'package:fluent_ui/fluent_ui.dart';

import '../widgets/crudbar.dart';

class ScoreCardsPage extends StatefulWidget {
  const ScoreCardsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScoreCardsPageState();
}

class _ScoreCardsPageState extends State<ScoreCardsPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      children: [
        CrudBar(),
      ],
    );
  }
}

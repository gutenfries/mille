import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:url_launcher/link.dart';

import '../models/sponsor.dart';
import '../widgets/changelog.dart';
import '../widgets/material_equivalents.dart';
import '../widgets/page.dart';
import '../widgets/sponsor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with PageMixin {
  bool selected = true;
  String? comboboxValue;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);

    return ScaffoldPage.scrollable(
      header: const PageHeader(
        title: Text('Home'),
        commandBar: Align(
          alignment: Alignment.centerRight,
          child: Icon(TablerIcons.icons, size: 24.0),
        ),
      ),
      children: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => const Changelog(),
            );
          },
          icon: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What\'s new',
                style: theme.typography.body
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                  // date at compile time
                  'date-time',
                  style: theme.typography.caption),
              Text(
                'description...',
                style: theme.typography.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: 22.0),
        Row(
          children: [
            Text('Sponsors', style: theme.typography.subtitle),
            const SizedBox(width: 4.0),
          ],
        ),
        const SizedBox(height: 4.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            ...sponsors.map(
              (sponsor) {
                return Link(
                  uri: Uri.parse('https://www.github.com/${sponsor.username}'),
                  builder: (context, open) {
                    return IconButton(
                      onPressed: open,
                      icon: SponsorButton(
                        imageUrl: sponsor.imageUrl,
                        username: sponsor.username,
                        name: sponsor.name,
                      ),
                    );
                  },
                );
              },
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SponsorDialog(),
                );
              },
              icon: Column(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.8),
                            ...Colors.accentColors,
                          ],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.srcATop,
                      child: const Icon(TablerIcons.heart_plus, size: 60),
                    ),
                  ),
                  const Text('Become a Sponsor!'),
                ],
              ),
            ),
          ],
        ),
        subtitle(content: const Text('Equivalents with the material library')),
        const MaterialEquivalents(),
      ],
    );
  }
}

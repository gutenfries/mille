import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:url_launcher/link.dart';

import '../widgets/helpers/spacing.dart';

/// Current sponsors of the project <3
final sponsors = [
  Sponsor(
    username: 'gutenfries',
    name: 'marc gutenberger',
  ),
];

class Sponsor {
  final String username;
  final String name;

  late String imageUrl = 'https://avatars.githubusercontent.com/$username';

  Sponsor({
    required this.username,
    required this.name,
    // required this.imageUrl,
  });

  @override
  String toString() =>
      'Sponsor(username: $username, name: $name, imageUrl: $imageUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sponsor &&
        other.username == username &&
        other.name == name &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => username.hashCode ^ name.hashCode ^ imageUrl.hashCode;
}

class SponsorButton extends StatelessWidget {
  const SponsorButton({
    Key? key,
    required this.imageUrl,
    required this.username,
    required this.name,
  }) : super(key: key);
  final String name;
  final String imageUrl;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
            ),
            shape: BoxShape.circle,
          ),
        ),
        Text(name),
        Text('@$username'),
      ],
    );
  }
}

class SponsorDialog extends StatelessWidget {
  const SponsorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);

    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 600),
      title: Row(
        children: [
          const Expanded(child: Text('Become a Sponsor!')),
          SmallIconButton(
            child: Tooltip(
              message: FluentLocalizations.of(context).closeButtonLabel,
              child: IconButton(
                icon: const Icon(TablerIcons.x, size: 16.0),
                onPressed: Navigator.of(context).pop,
              ),
            ),
          ),
        ],
      ),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Mille is free and open source, but it takes a lot of time and effort to maintain and develop.',
                  style: theme.typography.body,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'If you enjoy using Mille, please consider donating to the developer, even small amounts helps! :)',
                  style: theme.typography.body,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Link(
          uri: Uri.parse('https://github.com/sponsors/gutenfries'),
          builder: (context, open) => FilledButton(
            onPressed: open,
            child: const Text('GitHub Sponsors'),
          ),
        ),
        Link(
          uri: Uri.parse('https://account.venmo.com/u/gutenfries'),
          builder: (context, open) => FilledButton(
            // ignore: sort_child_properties_last
            child: const Text('Venmo'),
            onPressed: open,
          ),
        ),
      ],
    );
  }
}

class SponsorsCard extends StatelessWidget {
  const SponsorsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);

    return Wrap(
      children: [
        Row(
          children: [
            Text('Sponsors', style: theme.typography.subtitle),
            const SizedBox(width: 4.0),
          ],
        ),
        Spacing.small(),
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
      ],
    );
  }
}

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:url_launcher/link.dart';

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
            child: const Text('GitHub Sponsors'),
            onPressed: open,
          ),
        ),
        Link(
          uri: Uri.parse('https://account.venmo.com/u/gutenfries'),
          builder: (context, open) => FilledButton(
            child: const Text('Venmo'),
            onPressed: open,
          ),
        ),
      ],
    );
  }
}

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_markdown/flutter_markdown.dart'
    deferred as flutter_markdown;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/deferred_widget.dart';

List<String>? changelog;

class Changelog extends StatefulWidget {
  const Changelog({Key? key}) : super(key: key);

  @override
  State<Changelog> createState() => _ChangelogState();
}

class _ChangelogState extends State<Changelog> {
  @override
  void initState() {
    super.initState();
    fetchChangelog();
  }

  void fetchChangelog() async {
    late http.Response response;
    try {
      response = await http.get(
        Uri.parse(
          'https://raw.githubusercontent.com/gutenfries/mille/main/CHANGELOG.md',
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    if (response.statusCode == 200) {
      final _changelog = response.body.split('\n')..removeRange(0, 2);
      setState(() => changelog = _changelog);
    } else {
      debugPrint(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return DeferredWidget(
      flutter_markdown.loadLibrary,
      () => ContentDialog(
        style: const ContentDialogThemeData(padding: EdgeInsets.zero),
        constraints: const BoxConstraints(maxWidth: 600),
        content: () {
          if (changelog == null) return const ProgressRing();
          return SingleChildScrollView(
            child: flutter_markdown.Markdown(
              shrinkWrap: true,
              data: changelog!.map<String>((line) {
                if (line.startsWith('## [')) {
                  final version = line.split(']').first.replaceAll('## [', '');
                  String date = line
                      .split('-')
                      .last
                      .replaceAll('[', '')
                      .replaceAll(']', '');

                  if (!date.startsWith('##')) {
                    final splitDate = date.split('/');
                    final dateTime = DateTime(
                      int.parse(splitDate[2]),
                      int.parse(splitDate[1]),
                      int.parse(splitDate[0]),
                    );
                    final formatter = DateFormat.MMMMEEEEd();
                    date = '${formatter.format(dateTime)}\n';
                  } else {
                    date = '';
                  }
                  return '## $version\n$date';
                }

                return line;
              }).join('\n'),
              onTapLink: (text, href, title) {
                launchUrl(Uri.parse(href!));
              },
              styleSheet: flutter_markdown.MarkdownStyleSheet.fromTheme(
                material.Theme.of(context),
              ).copyWith(
                a: TextStyle(
                  color: theme.accentColor.defaultBrushFor(
                    theme.brightness,
                    // level: 1,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(20.0),
            ),
          );
        }(),
      ),
    );
  }
}

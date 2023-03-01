// make me an excel like scorecard widget

import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../theme.dart';
import '../widgets/page.dart';

class ScoreCard extends StatefulWidget {
  const ScoreCard({Key? key}) : super(key: key);

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> with PageMixin {
  int currentIndex = 0;
  List<Tab>? tabs;

  TabWidthBehavior tabWidthBehavior = TabWidthBehavior.equal;
  CloseButtonVisibilityMode closeButtonVisibilityMode =
      CloseButtonVisibilityMode.always;
  bool showScrollButtons = true;
  bool wheelScroll = false;

  Tab generateTab(int index) {
    late Tab tab;
    tab = Tab(
      text: Text('Document $index'),
      semanticLabel: 'Document #$index',
      icon: const FlutterLogo(),
      body: Container(
        color:
            Colors.accentColors[Random().nextInt(Colors.accentColors.length)],
        child: Card(
          child: Column(
            children: [
              for (var i = 0; i < 3; i++)
                Row(
                  children: [
                    for (var j = 0; j < 3; j++)
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              // width: 100,
                              child: TextBox(
                                placeholder: '${i + 1}.${j + 1}',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true, signed: true),
                                inputFormatters: [
                                  // allow numbers, decimal point, and negative sign
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^-?\d*\.?\d*')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
      onClosed: () {
        setState(
          () {
            tabs!.remove(tab);

            if (currentIndex > 0) currentIndex--;
          },
        );
      },
    );
    return tab;
  }

  @override
  Widget build(BuildContext context) {
    tabs ??= List.generate(1, generateTab);
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Game Title')),
      children: [
        Card(
          borderRadius: BorderRadius.circular(5),
          child: SizedBox(
            width: double.infinity,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: SizedBox(
                height: 400,
                child: TabView(
                  tabs: tabs!,
                  currentIndex: currentIndex,
                  onChanged: (index) => setState(() => currentIndex = index),
                  tabWidthBehavior: tabWidthBehavior,
                  closeButtonVisibility: closeButtonVisibilityMode,
                  showScrollButtons: showScrollButtons,
                  wheelScroll: wheelScroll,
                  addIconData: TablerIcons.plus,
                  onNewPressed: () {
                    setState(
                      () {
                        final index = tabs!.length + 1;
                        final tab = generateTab(index);
                        tabs!.add(tab);
                      },
                    );
                  },
                  onReorder: (oldIndex, newIndex) {
                    setState(
                      () {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final item = tabs!.removeAt(oldIndex);
                        tabs!.insert(newIndex, item);

                        if (currentIndex == newIndex) {
                          currentIndex = oldIndex;
                        } else if (currentIndex == oldIndex) {
                          currentIndex = newIndex;
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

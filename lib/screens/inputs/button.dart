// ignore_for_file: prefer_const_constructors

import 'package:mille/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../widgets/card_highlight.dart';

const kSplitButtonHeight = 32.0;
const kSplitButtonWidth = 36.0;

class ButtonPage extends StatefulWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> with PageMixin {
  bool simpleDisabled = false;
  bool filledDisabled = false;
  bool iconDisabled = false;
  bool toggleDisabled = false;
  bool toggleState = false;
  bool splitButtonDisabled = false;
  bool radioButtonDisabled = false;
  int radioButtonSelected = -1;

  AccentColor splitButtonColor = Colors.red;
  final splitButtonFlyout = FlyoutController();

  @override
  void dispose() {
    splitButtonFlyout.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Button')),
      children: [
        const Text(
          'The Button control provides a Click event to respond to user input from a touch, mouse, keyboard, stylus, or other input device. You can put different kinds of content in a button, such as text or an image, or you can restyle a button to give it a new look.',
        ),
        subtitle(content: const Text('A simple button with text content')),
        description(
          content: const Text('A button that initiates an immediate action.'),
        ),
        CardHighlight(
          child: Row(children: [
            Button(
              child: const Text('Standard Button'),
              onPressed: simpleDisabled ? null : () {},
            ),
            const Spacer(),
            ToggleSwitch(
              checked: simpleDisabled,
              onChanged: (v) {
                setState(() {
                  simpleDisabled = v;
                });
              },
              content: const Text('Disabled'),
            ),
          ]),
          codeSnippet: '''Button(
  child: const Text('Standard Button'),
  onPressed: disabled ? null : () => debugPrint('pressed button'),
)''',
        ),
        subtitle(content: const Text('Accent Style applied to Button')),
        CardHighlight(
          child: Row(children: [
            FilledButton(
              child: const Text('Filled Button'),
              onPressed: filledDisabled ? null : () {},
            ),
            const Spacer(),
            ToggleSwitch(
              checked: filledDisabled,
              onChanged: (v) {
                setState(() {
                  filledDisabled = v;
                });
              },
              content: const Text('Disabled'),
            ),
          ]),
          codeSnippet: '''FilledButton(
  child: const Text('Filled Button'),
  onPressed: disabled ? null : () => debugPrint('pressed button'),
)''',
        ),
        subtitle(
          content: const Text('A Button with graphical content (IconButton)'),
        ),
        CardHighlight(
          child: Row(children: [
            IconButton(
              icon: const Icon(FluentIcons.graph_symbol, size: 24.0),
              onPressed: iconDisabled ? null : () {},
            ),
            const Spacer(),
            ToggleSwitch(
              checked: iconDisabled,
              onChanged: (v) {
                setState(() {
                  iconDisabled = v;
                });
              },
              content: const Text('Disabled'),
            ),
          ]),
          codeSnippet: '''IconButton(
  icon: const Icon(FluentIcons.graph_symbol, size: 24.0),
  onPressed: disabled ? null : () => debugPrint('pressed button'),
)''',
        ),
        subtitle(
            content: const Text('A simple ToggleButton with text content')),
        description(
          content: const Text(
            'A ToggleButton looks like a Button, but works like a CheckBox. It '
            'typically has two states, checked (on) or unchecked (off).',
          ),
        ),
        CardHighlight(
          child: Row(children: [
            ToggleButton(
              child: const Text('Toggle Button'),
              checked: toggleState,
              onChanged: toggleDisabled
                  ? null
                  : (v) {
                      setState(() {
                        toggleState = v;
                      });
                    },
            ),
            const Spacer(),
            ToggleSwitch(
              checked: toggleDisabled,
              onChanged: (v) {
                setState(() {
                  toggleDisabled = v;
                });
              },
              content: const Text('Disabled'),
            ),
          ]),
          codeSnippet: '''bool checked = false;

ToggleButton(
  child: const Text('Toggle Button'),
  checked: checked,
  onPressed: disabled ? null : (v) => setState(() => checked = v),
)''',
        ),
        subtitle(content: const Text('DropDownButton')),
        const Text(
          'A control that drops down a flyout of choices from which one can be chosen',
        ),
        CardHighlight(
          child: Row(children: [
            DropDownButton(
              title: Text('Email'),
              items: [
                MenuFlyoutItem(text: const Text('Send'), onPressed: () {}),
                MenuFlyoutItem(text: const Text('Reply'), onPressed: () {}),
                MenuFlyoutItem(text: const Text('Reply all'), onPressed: () {}),
              ],
            ),
            SizedBox(width: 10.0),
            DropDownButton(
              title: Icon(FluentIcons.mail),
              items: [
                MenuFlyoutItem(
                  leading: Icon(FluentIcons.send),
                  text: const Text('Send'),
                  onPressed: () {},
                ),
                MenuFlyoutItem(
                  leading: Icon(FluentIcons.reply),
                  text: const Text('Reply'),
                  onPressed: () {},
                ),
                MenuFlyoutItem(
                  leading: Icon(FluentIcons.reply_all),
                  text: const Text('Reply all'),
                  onPressed: () {},
                ),
              ],
            ),
          ]),
          codeSnippet: '''DropDownButton(
  title: Text('Email'),
  items: [
    MenuFlyoutItem(text: const Text('Send'), onPressed: () {}),
    MenuFlyoutItem(text: const Text('Reply'), onPressed: () {}),
    MenuFlyoutItem(text: const Text('Reply all'), onPressed: () {}),
  ],
)''',
        ),
        subtitle(content: const Text('SplitButton')),
        description(
          content: const Text(
            'Represents a button with two parts that can be invoked separately. '
            'One part behaves like a standard button and the other part invokes '
            'a flyout.',
          ),
        ),
        CardHighlight(
          child: Row(children: [
            SizedBox(
              height: 40.0,
              child: SplitButtonBar(buttons: [
                Button(
                  style: ButtonStyle(padding: ButtonState.all(EdgeInsets.zero)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: splitButtonDisabled
                          ? splitButtonColor.secondaryBrushFor(
                              FluentTheme.of(context).brightness,
                            )
                          : splitButtonColor,
                      borderRadius: const BorderRadiusDirectional.horizontal(
                        start: Radius.circular(4.0),
                      ),
                    ),
                    height: kSplitButtonHeight,
                    width: kSplitButtonWidth,
                  ),
                  onPressed: splitButtonDisabled ? null : () {},
                ),
                FlyoutTarget(
                  controller: splitButtonFlyout,
                  child: IconButton(
                    icon: const SizedBox(
                      height: kSplitButtonHeight - 13.0,
                      width: kSplitButtonWidth - 13.0,
                      child: Icon(FluentIcons.chevron_down, size: 8.0),
                    ),
                    onPressed: splitButtonDisabled
                        ? null
                        : () async {
                            final color =
                                await splitButtonFlyout.showFlyout<AccentColor>(
                              autoModeConfiguration: FlyoutAutoConfiguration(
                                preferredMode: FlyoutPlacementMode.bottomCenter,
                              ),
                              builder: (context) {
                                return FlyoutContent(
                                  constraints: BoxConstraints(maxWidth: 200.0),
                                  child: Wrap(
                                    runSpacing: 10.0,
                                    spacing: 8.0,
                                    children: Colors.accentColors.map((color) {
                                      return Button(
                                        autofocus: splitButtonColor == color,
                                        style: ButtonStyle(
                                          padding: ButtonState.all(
                                            EdgeInsets.all(4.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(color);
                                        },
                                        child: Container(
                                          height: 40.0,
                                          width: 40.0,
                                          color: color,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                              },
                            );

                            if (color != null) {
                              setState(() => splitButtonColor = color);
                            }
                          },
                  ),
                ),
              ]),
            ),
            const Spacer(),
            ToggleSwitch(
              checked: splitButtonDisabled,
              onChanged: (v) {
                setState(() {
                  splitButtonDisabled = v;
                });
              },
              content: const Text('Disabled'),
            ),
          ]),
          codeSnippet: '''SizedBox(
  height: 40.0,
  child: SplitButtonBar(buttons: [
    Button(
      style: ButtonStyle(padding: ButtonState.all(EdgeInsets.zero)),
      child: Container(
        decoration: BoxDecoration(
          color: splitButtonDisabled
              ? splitButtonColor.secondaryBrushFor(
                  FluentTheme.of(context).brightness,
                )
              : splitButtonColor,
          borderRadius: const BorderRadiusDirectional.horizontal(
            start: Radius.circular(4.0),
          ),
        ),
        height: kSplitButtonHeight,
        width: kSplitButtonWidth,
      ),
      onPressed: splitButtonDisabled ? null : () {},
    ),
    FlyoutTarget(
      controller: splitButtonFlyout,
      child: IconButton(
        icon: const SizedBox(
          height: kSplitButtonHeight - 13.0,
          width: kSplitButtonWidth - 13.0,
          child: Icon(FluentIcons.chevron_down, size: 8.0),
        ),
        onPressed: splitButtonDisabled
            ? null
            : () async {
                final color = await splitButtonFlyout.showFlyout<AccentColor>(
                  autoModeConfiguration: FlyoutAutoConfiguration(
                    preferredMode: FlyoutPlacementMode.bottomCenter,
                  ),
                  builder: (context) {
                    return FlyoutContent(
                      constraints: BoxConstraints(maxWidth: 200.0),
                      child: Wrap(
                        runSpacing: 10.0,
                        spacing: 8.0,
                        children: Colors.accentColors.map((color) {
                          return Button(
                            autofocus: splitButtonColor == color,
                            style: ButtonStyle(
                              padding: ButtonState.all(
                                EdgeInsets.all(4.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(color);
                            },
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              color: color,
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                );

                if (color != null) {
                  setState(() => splitButtonColor = color);
                }
              },
      ),
    ),
  ]),
)''',
        ),
        subtitle(content: const Text('RadioButton')),
        description(
          content: const Text(
            'Radio buttons, also called option buttons, let users select one option '
            'from a collection of two or more mutually exclusive, but related, '
            'options. Radio buttons are always used in groups, and each option is '
            'represented by one radio button in the group.',
          ),
        ),
        CardHighlight(
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                3,
                (index) {
                  return Padding(
                    padding: EdgeInsetsDirectional.only(
                        bottom: index == 2 ? 0.0 : 14.0),
                    child: RadioButton(
                      checked: radioButtonSelected == index,
                      onChanged: radioButtonDisabled
                          ? null
                          : (v) {
                              if (v) {
                                setState(() {
                                  radioButtonSelected = index;
                                });
                              }
                            },
                      content: Text('RadioButton ${index + 1}'),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            ToggleSwitch(
              checked: radioButtonDisabled,
              onChanged: (v) {
                setState(() {
                  radioButtonDisabled = v;
                });
              },
              content: const Text('Disabled'),
            )
          ]),
          codeSnippet: '''int? selected;

Column(
  children: List.generate(3, (index) {
    return RadioButton(
      checked: selected == index,
      onChanged: (checked) {
        if (checked) {
          setState(() => selected = index);
        }
      }
    );
  }),
)''',
        ),
      ],
    );
  }
}

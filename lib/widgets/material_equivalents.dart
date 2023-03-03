import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material_ui;
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class MaterialEquivalents extends StatefulWidget {
  const MaterialEquivalents({Key? key}) : super(key: key);

  @override
  State<MaterialEquivalents> createState() => _MaterialEquivalentsState();
}

class _MaterialEquivalentsState extends State<MaterialEquivalents> {
  bool checkboxChecked = true;
  bool radioChecked = true;
  bool switchChecked = true;

  final List<String> comboboxItems = [
    'Item 1',
    'Item 2',
  ];
  String? comboboxItem;
  String dropdownItem = 'Item 1';
  final popupKey = GlobalKey<material_ui.PopupMenuButtonState>();

  double sliderValue = Random().nextDouble() * 100;

  final fieldController = TextEditingController();
  DateTime time = DateTime.now();

  @override
  void dispose() {
    fieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<List<Widget>> children = [
      [
        const Text('Button'),
        Button(
          child: const Text('Content'),
          onPressed: () {},
        ),
        material_ui.OutlinedButton(
          child: const Text('Content'),
          onPressed: () {},
        ),
      ],
      [
        const Text('TextButton'),
        TextButton(
          child: const Text('Content'),
          onPressed: () {},
        ),
        material_ui.TextButton(
          child: const Text('Content'),
          onPressed: () {},
        ),
      ],
      [
        const Text('FilledButton'),
        FilledButton(
          child: const Text('Content'),
          onPressed: () {},
        ),
        material_ui.ElevatedButton(
          child: const Text('Content'),
          onPressed: () {},
        ),
      ],
      [
        const Text('IconButton'),
        IconButton(
          icon: const Icon(TablerIcons.brand_github),
          onPressed: () {},
        ),
        material_ui.IconButton(
          icon: const Icon(TablerIcons.brand_github),
          onPressed: () {},
        ),
      ],
      [
        const Text('Checkbox'),
        Checkbox(
          checked: checkboxChecked,
          onChanged: (v) =>
              setState(() => checkboxChecked = v ?? checkboxChecked),
        ),
        material_ui.Checkbox(
          value: checkboxChecked,
          onChanged: (v) =>
              setState(() => checkboxChecked = v ?? checkboxChecked),
        ),
      ],
      [
        const Text('RadioButton'),
        RadioButton(
          checked: radioChecked,
          onChanged: (v) => setState(() => radioChecked = v),
        ),
        material_ui.Radio<bool>(
          groupValue: true,
          value: radioChecked,
          onChanged: (v) => setState(() => radioChecked = !radioChecked),
        ),
      ],
      [
        const Text('ToggleSwitch'),
        ToggleSwitch(
          checked: switchChecked,
          onChanged: (v) => setState(() => switchChecked = v),
        ),
        material_ui.Switch(
          value: switchChecked,
          onChanged: (v) => setState(() => switchChecked = v),
        ),
      ],
      [
        const Text('Slider'),
        Slider(
          value: sliderValue,
          max: 100,
          onChanged: (v) => setState(() => sliderValue = v),
        ),
        material_ui.Slider(
          value: sliderValue,
          max: 100,
          onChanged: (v) => setState(() => sliderValue = v),
        ),
      ],
      [
        const Text('ProgressRing'),
        const RepaintBoundary(child: ProgressRing()),
        const RepaintBoundary(child: material_ui.CircularProgressIndicator()),
      ],
      [
        const Text('ProgressBar'),
        const RepaintBoundary(child: ProgressBar()),
        const RepaintBoundary(child: material_ui.LinearProgressIndicator()),
      ],
      [
        const Text('ComboBox'),
        ComboBox<String>(
          items: comboboxItems
              .map((e) => ComboBoxItem(child: Text(e), value: e))
              .toList(),
          value: comboboxItem,
          onChanged: (value) => setState(() => comboboxItem = value),
        ),
        material_ui.DropdownButton<String>(
          items: comboboxItems
              .map(
                  (e) => material_ui.DropdownMenuItem(child: Text(e), value: e))
              .toList(),
          value: comboboxItem,
          onChanged: (value) => setState(() => comboboxItem = value),
        ),
      ],
      [
        const Text('DropDownButton'),
        DropDownButton(
          items: comboboxItems
              .map(
                (e) => MenuFlyoutItem(
                  text: Text(e),
                  onPressed: () => setState(() => dropdownItem = e),
                ),
              )
              .toList(),
          title: Text(dropdownItem),
        ),
        material_ui.PopupMenuButton<String>(
          key: popupKey,
          itemBuilder: (context) {
            return comboboxItems
                .map(
                  (e) => material_ui.PopupMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList();
          },
          onSelected: (e) => setState(() => dropdownItem = e),
          initialValue: dropdownItem,
          position: material_ui.PopupMenuPosition.under,
          child: material_ui.TextButton(
            child: Text(dropdownItem),
            onPressed: () {
              popupKey.currentState?.showButtonMenu();
            },
          ),
        ),
      ],
      [
        const Text('TextBox'),
        TextBox(controller: fieldController),
        material_ui.TextField(controller: fieldController),
      ],
      [
        const Text('TimePicker'),
        TimePicker(
          selected: time,
          onChanged: (value) => setState(() => time),
        ),
        material_ui.TextButton(
          child: const Text('Show Picker'),
          onPressed: () async {
            final newTime = await material_ui.showTimePicker(
              context: context,
              initialTime: material_ui.TimeOfDay(
                hour: time.hour,
                minute: time.minute,
              ),
            );
            if (newTime != null) {
              time = DateTime(
                time.year,
                time.month,
                time.day,
                newTime.hour,
                newTime.minute,
                time.second,
              );
            }
          },
        ),
      ],
      [
        const Text('DatePicker'),
        DatePicker(
          selected: time,
          onChanged: (value) => setState(() => time),
        ),
        material_ui.TextButton(
          child: const Text('Show Picker'),
          onPressed: () async {
            final newTime = await material_ui.showDatePicker(
              context: context,
              initialDate: time,
              firstDate: DateTime(time.year - 100),
              lastDate: DateTime(time.year + 100),
            );
            if (newTime != null) {
              setState(() => time = newTime);
            }
          },
        ),
      ],
      [
        const Text('ListTile'),
        ListTile(
          leading: const Icon(TablerIcons.brand_github),
          title: const Text('Content'),
          onPressed: () {},
        ),
        material_ui.ListTile(
          leading: const Icon(TablerIcons.brand_github),
          title: const Text('Content'),
          onTap: () {},
        ),
      ],
      [
        const Text('Tooltip'),
        const Tooltip(
          message: 'A fluent-styled tooltip',
          child: Text('Hover'),
        ),
        const material_ui.Tooltip(
          message: 'A material-styled tooltip',
          child: Text('Hover'),
        ),
      ],
    ];

    Widget buildColumn(int index) {
      return Column(
        children: children
            .map(
              (children) => Container(
                constraints: const BoxConstraints(minHeight: 50.0),
                alignment: AlignmentDirectional.center,
                child: children[index],
              ),
            )
            .toList(),
      );
    }

    return material_ui.Material(
      type: material_ui.MaterialType.transparency,
      child: Row(children: [
        Expanded(child: buildColumn(0)),
        const material_ui.VerticalDivider(),
        Expanded(child: buildColumn(1)),
        const material_ui.VerticalDivider(),
        Expanded(child: buildColumn(2)),
      ]),
    );
  }
}

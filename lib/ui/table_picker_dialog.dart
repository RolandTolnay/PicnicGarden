import 'dart:collection';

import 'package:flutter/material.dart' hide Table;

import '../model/table.dart';
import 'common/dialog_item.dart';
import 'common/dialog_title.dart';

class TablePickerDialog extends StatelessWidget {
  const TablePickerDialog(this.tables, {this.selectedTable, Key key})
      : super(key: key);

  final UnmodifiableListView<Table> tables;
  final Table selectedTable;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 2,
      title: const DialogTitle(text: 'Choose table', icon: Icons.tab),
      content: Container(
        width: double.maxFinite,
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          children: tables
              .map((table) => DialogItem(
                    table.name,
                    isSelected: table == selectedTable,
                    onTapped: () => Navigator.of(context).pop(table),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

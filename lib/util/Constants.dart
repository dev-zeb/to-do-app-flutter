import 'package:flutter/material.dart';

class Constants {
  static const listOfTasksKey = 'LIST_OF_TASKS_KEY';

  static const List<String> priorityItems = ['Urgent', 'High', 'Medium', 'Low'];
  static List<Color> priorityColors = [
    const Color(0xFFFF0000),
    const Color(0xFF0033FF),
    const Color(0xFF008C06),
    const Color(0xFFFFB700),
  ];

  static const double formItemPadding = 40;

  static const TextStyle dropDownSelectedItemTextStyle = TextStyle(
    color: Colors.deepOrange,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static TextStyle dropDownUnselectedItemTextStyle = TextStyle(
    color: Colors.black.withOpacity(0.6),
    fontSize: 16,
  );
  static TextStyle textFormFieldHintTextStyle = TextStyle(
    color: Colors.black.withOpacity(0.6),
    fontSize: 16,
  );
  static const TextStyle textFormFieldLabelTextStyle = TextStyle(
    color: Colors.deepOrange,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static Color getPriorityColor(String priority) {
    return priorityColors[priorityItems.indexOf(priority)];
  }
}

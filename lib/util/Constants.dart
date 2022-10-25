import 'package:flutter/material.dart';

class Constants {
  static const listOfTasksKey = 'LIST_OF_TASKS_KEY';

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
}

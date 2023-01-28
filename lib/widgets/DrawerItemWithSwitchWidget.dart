import 'package:flutter/material.dart';

class DrawerItemWithSwitchWidget extends StatefulWidget {
  final String optionName;
  bool isSelected = false;

  DrawerItemWithSwitchWidget(
      {Key? key, required this.optionName, isSelected = false})
      : super(key: key);

  @override
  State<DrawerItemWithSwitchWidget> createState() =>
      _DrawerItemWithSwitchWidgetState();
}

class _DrawerItemWithSwitchWidgetState
    extends State<DrawerItemWithSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.optionName,
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: widget.isSelected,
            activeColor: Colors.orange,
            inactiveThumbColor: Colors.black,
            onChanged: (value) {
              setState(() {
                widget.isSelected = value;
              });
            },
          )
        ],
      ),
    );
  }
}

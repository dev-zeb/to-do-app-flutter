
import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/ComingSoonWidget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const ComingSoonWidget();
  }
}

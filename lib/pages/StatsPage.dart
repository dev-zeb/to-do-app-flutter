import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/ComingSoonWidget.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return const ComingSoonWidget();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/DataProvider.dart';
import 'package:to_do_app/widgets/ToDoListItemWidget.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return ListView.builder(
          itemCount: dataProvider.getIncompleteTasks.length,
          itemBuilder: (context, index) {
            return ToDoListItemWidget(dataProvider: dataProvider, index: index, task: dataProvider.getIncompleteTasks[index]);
          },
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 20,
          ),
        );
      },
    );
  }
}


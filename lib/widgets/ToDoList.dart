import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/Task.dart';
import 'package:to_do_app/providers/DataProvider.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return ListView.builder(
          itemCount: dataProvider.tasks.length,
          itemBuilder: (context, index) {
            return ToDoListItem(
              index: index,
              task: dataProvider.tasks[index],
            );
          },
        );
      },
    );
  }
}

class ToDoListItem extends StatelessWidget {
  final int index;
  final Task task;

  const ToDoListItem({Key? key, required this.index, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// context.read<DataProvider>().removeTask(index);
      },
      child: Column(
        children: [
          Text(
            context.read<DataProvider>().tasks[index].title,
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            context.read<DataProvider>().tasks[index].description,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

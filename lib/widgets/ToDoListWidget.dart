import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/Task.dart';
import 'package:to_do_app/pages/AddOrEditTasksPage.dart';
import 'package:to_do_app/providers/DataProvider.dart';
import 'package:to_do_app/util/Constants.dart';

class ToDoListWidget extends StatefulWidget {
  const ToDoListWidget({Key? key}) : super(key: key);

  @override
  State<ToDoListWidget> createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return ListView.builder(
          itemCount: dataProvider.getIncompleteTasks.length,
          itemBuilder: (context, index) {
            return _getToDoItem(dataProvider, index, dataProvider.getIncompleteTasks[index]);
          },
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 20,
          ),
        );
      },
    );
  }

  //TODO: Convert this to a separate Stateless widget
  Widget _getToDoItem(DataProvider dataProvider, int index, Task task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        clipBehavior: Clip.hardEdge,
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.grey,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddOrEditTasksPage(
                  isNewTask: false,
                  task: dataProvider.getIncompleteTasks[index],
                ),
              ),
            );
          },
          highlightColor: Colors.transparent, // Constants.getPriorityColor(task.priority).withOpacity(0.15),
          splashColor: Constants.getPriorityColor(task.priority).withOpacity(0.15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: ListTile(
              leading: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  focusColor: Constants.getPriorityColor(task.priority),
                  side: BorderSide(
                    color: DataProvider.of(context)
                        .getPriorityColor(task.priority),
                    width: 0.75,
                  ),
                  shape: const CircleBorder(),
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    if (kDebugMode) {
                      print("Value -> $value");
                    }
                    if (value!) {
                      _showTaskCompletionConfirmationDialog(task);
                    }
                  },
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.85),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          blurRadius: 0.01,
                          color: DataProvider.of(context)
                              .getPriorityColor(task.priority)
                              .withOpacity(0.175),
                          offset: const Offset(0, 1.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Category: ${task.category}",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Due on: ${task.dueDate}",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.flag,
                    size: 24,
                    color: DataProvider.of(context)
                        .getPriorityColor(task.priority),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //TODO: Convert this to a separate Stateless widget
  void _showTaskCompletionConfirmationDialog(Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Container(
            height: 240,
            width: 312,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: const Text(
                        "Mark as Complete?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: const Text(
                        "This means you have completed this task!",
                        style: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.7,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 0.2,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            splashColor: Colors.blue.withOpacity(0.45),
                            child: Ink(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Color(0xFF757575),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.35),
                        height: 32,
                        width: 1,
                      ),
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              DataProvider.of(context)
                                  .completeTaskById(task.taskId);
                            },
                            splashColor: Colors.blue.withOpacity(0.45),
                            child: Ink(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                              ),
                              child: const Text(
                                "Okay",
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


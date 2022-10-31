import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/Task.dart';
import 'package:to_do_app/pages/AddOrEditTasks.dart';
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
          itemCount: dataProvider.getIncompleteTasks.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: ToDoListItem(
                index: index,
                task: dataProvider.getIncompleteTasks[index],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddOrEditTask(
                      isNewTask: false,
                      task: dataProvider.getIncompleteTasks[index],
                    ),
                  ),
                );
              },
            );
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

class ToDoListItem extends StatefulWidget {
  final int index;
  final Task task;

  const ToDoListItem({Key? key, required this.index, required this.task})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ToDoListItemState();
}

class _ToDoListItemState extends State<ToDoListItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            blurRadius: 0.01,
            color: DataProvider.of(context)
                .getPriorityColor(widget.task.priority)
                .withOpacity(0.175),
            offset: const Offset(0, 2.5),
            spreadRadius: 0.01,
          )
        ],
        color: Colors.white,
      ),
      child: ListTile(
        leading: Transform.scale(
          scale: 1.5,
          child: Checkbox(
            side: BorderSide(
              color: DataProvider.of(context)
                  .getPriorityColor(widget.task.priority),
              width: 0.75,
            ),
            shape: const CircleBorder(),
            value: widget.task.isCompleted,
            onChanged: (bool? value) {
              if (kDebugMode) {
                print("Value -> $value");
              }
              if (value!) {
                _showTaskCompletionConfirmationDialog();
              }
            },
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title,
              style: TextStyle(
                color: Colors.black.withOpacity(0.85),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    blurRadius: 0.01,
                    color: DataProvider.of(context)
                        .getPriorityColor(widget.task.priority)
                        .withOpacity(0.175),
                    offset: const Offset(0, 2.5),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Category: ${widget.task.category}",
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
              "Due on: ${widget.task.dueDate}",
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
                  .getPriorityColor(widget.task.priority),
            ),
          ],
        ),
      ),
    );
  }

  void _showTaskCompletionConfirmationDialog() {
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
                                  .completeTaskById(widget.task.taskId);
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

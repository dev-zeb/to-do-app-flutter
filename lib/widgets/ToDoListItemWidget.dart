import 'package:flutter/material.dart';
import 'package:to_do_app/models/Task.dart';
import 'package:to_do_app/pages/AddOrEditTasksPage.dart';
import 'package:to_do_app/providers/DataProvider.dart';
import 'package:to_do_app/util/Constants.dart';
import 'package:to_do_app/widgets/ConfirmationDialog.dart';

class ToDoListItemWidget extends StatelessWidget {
  final DataProvider dataProvider;
  final int index;
  final Task task;

  const ToDoListItemWidget({
    Key? key,
    required this.dataProvider,
    required this.index,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          highlightColor: Colors.transparent,
          splashColor:
              Constants.getPriorityColor(task.priority).withOpacity(0.15),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
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
                    if (value!) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmationDialog(
                            dialogTitle: "Mark as Complete?",
                            dialogDescription:
                                "This means you have completed this task!",
                            yesButtonText: "Okay",
                            yesButtonFunction: () {
                              Navigator.pop(context);
                              DataProvider.of(context)
                                  .completeTaskById(task.taskId);
                            },
                            noButtonText: "Cancel",
                            noButtonFunction: () async {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
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
}

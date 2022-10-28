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
          itemCount: dataProvider.tasks.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: ToDoListItem(
                index: index,
                task: dataProvider.tasks[index],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddOrEditTask(
                      isNewTask: false,
                      task: dataProvider.tasks[index],
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
  bool _selectedValue = false;

  ToDoListItem({Key? key, required this.index, required this.task})
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
                .withOpacity(0.15),
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
              color: Colors.black.withOpacity(0.75),
              width: 0.75,
            ),
            shape: const CircleBorder(),
            value: widget._selectedValue,
            onChanged: (bool? value) {
              if (kDebugMode) {
                print("Value -> $value");
              }
              if (value!) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 300,
                      width: 240,
                      child: AlertDialog(
                        actions: [
                          InkWell(
                            child: const Text("Yes"),
                            onTap: () {
                              setState(() {
                                widget._selectedValue = !widget._selectedValue;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          InkWell(
                            child: const Text("No"),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                        title: const Text("Finish Task?"),
                      ),
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
              widget.task.title,
              style: TextStyle(
                color: Colors.black.withOpacity(0.85),

                /// color: DataProvider.of(context).getPriorityColor(widget.task.priority),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Category: ${widget.task.category}",
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),

                /// color: DataProvider.of(context).getPriorityColor(widget.task.priority),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.task.dueDate,
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),

                /// color: DataProvider.of(context).getPriorityColor(widget.task.priority),
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
            InkWell(
              customBorder: const CircleBorder(),
              highlightColor: Colors.lightGreenAccent,
              splashColor: Colors.lightGreenAccent,
              onTap: () {},
              child: Icon(
                Icons.flag,
                size: 24,
                color: DataProvider.of(context)
                    .getPriorityColor(widget.task.priority),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

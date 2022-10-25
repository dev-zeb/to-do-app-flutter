import 'package:flutter/foundation.dart';
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
        // border: Border.all(color: Colors.black, width: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            blurRadius: 0.25,
            color: Colors.grey.shade300,
            offset: const Offset(0, 2.5),
            spreadRadius: 0.75,
          )
        ],
        color: Colors.white,
      ),
      child: ListTile(
        leading: Transform.scale(
          scale: 1.5,
          child: Checkbox(
            side: const BorderSide(
              color: Colors.deepOrange,
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
              style: const TextStyle(
                color: Colors.deepOrange,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Category: ${widget.task.category}",
              style: const TextStyle(
                color: Colors.deepOrange,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.task.dueDate,
              style: const TextStyle(
                color: Colors.deepOrange,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              customBorder: const CircleBorder(),
              highlightColor: Colors.lightGreenAccent,
              splashColor: Colors.lightGreenAccent,
              onTap: () {},
              child: const Icon(
                Icons.flag,
                size: 32,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/Task.dart';
import 'package:to_do_app/providers/DataProvider.dart';

class AddOrEditTask extends StatefulWidget {
  final bool isNewTask;
  final Task? task;

  const AddOrEditTask({Key? key, required this.isNewTask, required this.task})
      : super(key: key);

  @override
  State<AddOrEditTask> createState() => _AddOrEditTaskState();
}

class _AddOrEditTaskState extends State<AddOrEditTask> {
  var _screenWidth = 0.0;
  var _selectedCategory = "Default";
  var _selectedPriority = "Default";

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: Text(widget.task == null ? "Create New Task" : "Edit Task"),
      ),
      body: _createOrEditTaskForm(),
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0.0
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.redAccent,
                      splashColor: Colors.redAccent.shade200,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Ink(
                        height: 42,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 0.1,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                          color: Colors.red,
                        ),
                        child: const Center(
                          child: Text(
                            "CANCEL",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.lightGreen,
                      splashColor: Colors.greenAccent,
                      onTap: () {
                        //TODO: Complete coding for Creating New Task and save it to the Provider
                      },
                      child: Ink(
                        height: 42,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 0.1,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                          color: Colors.green,
                        ),
                        child: const Center(
                          child: Text(
                            "CREATE TASK",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _createOrEditTaskForm() {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, _) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: _screenWidth * (20 / 360),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        hintText: "Enter Task Title",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _getTextFormWithDropdownButton(
                      dataProvider.categoryItems,
                      "Select Task Category",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _getTextFormWithDropdownButton(
                      dataProvider.priorityItems,
                      "Set Task Priority",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050),
                        );
                      },
                      child: Ink(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 56,
                        width: _screenWidth * 320 / 360,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 0.35,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Set Due Date",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 16,
                              ),
                            ),
                            Icon(
                              Icons.calendar_month,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        hintText: "Select Task Category",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _getTextFormWithDropdownButton(
    List<String> receivedItems,
    String fieldTitle,
  ) {
    return Container(
      width: _screenWidth * 320 / 360,
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.35,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Center(
        child: DropdownButton(
          icon: const Padding(
            padding: EdgeInsets.only(right: 4),
            child: Icon(
              Icons.arrow_drop_down,
              size: 36,
            ),
          ),
          isExpanded: true,
          onChanged: (String? newValue) {
            setState(() {
              _selectedCategory = newValue!;
            });
          },
          // value: dropdownValue,
          underline: const SizedBox(),
          hint: Row(
            children: [
              const SizedBox(
                width: 12,
              ),
              Text(
                fieldTitle,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          items:
              receivedItems.map<DropdownMenuItem<String>>((String itemValue) {
            return DropdownMenuItem<String>(
              value: itemValue,
              child: Text(
                itemValue,
                style: const TextStyle(fontSize: 20),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

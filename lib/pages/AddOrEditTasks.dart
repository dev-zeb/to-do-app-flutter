import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/Task.dart';
import 'package:to_do_app/providers/DataProvider.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/util/Constants.dart';

class AddOrEditTask extends StatefulWidget {
  final bool isNewTask;
  final Task? task;

  const AddOrEditTask({Key? key, required this.isNewTask, required this.task})
      : super(key: key);

  @override
  State<AddOrEditTask> createState() => _AddOrEditTaskState();
}

class _AddOrEditTaskState extends State<AddOrEditTask> {
  double _screenWidth = 0.0;
  bool? _isLandscape;
  String? _selectedCategory;
  String? _selectedPriority;
  DateTime? _selectedDueDate;

  late final TextEditingController _textTitleFieldController;

  @override
  void initState() {
    super.initState();

    _textTitleFieldController = TextEditingController(text: widget.task?.title);
    _selectedCategory = widget.task?.category;
    _selectedPriority = widget.task?.priority;
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: Text(
          widget.task == null ? "Create New Task" : "Edit Task",
        ),
      ),
      body: _createOrEditTaskForm(),
      floatingActionButton:
          MediaQuery.of(context).viewInsets.bottom == 0.0 && !_isLandscape!
              ? _getConfirmationButtons()
              : const SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _createOrEditTaskForm() {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, _) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: _screenWidth * (320 / 360),
                  child: TextFormField(
                    controller: _textTitleFieldController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      hintText: "Enter Task Title",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 16,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: const Text("Title"),
                      labelStyle: Constants.textFormFieldLabelTextStyle,
                    ),
                    style: _textTitleFieldController.text != ""
                        ? Constants.dropDownSelectedItemTextStyle
                        : Constants.textFormFieldHintTextStyle,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  height: Constants.formItemPadding,
                ),
                SizedBox(
                  width: _screenWidth * (320 / 360),
                  child: DropdownButtonFormField(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: Colors.deepOrange,
                    ),
                    isExpanded: true,
                    value: _selectedCategory,
                    selectedItemBuilder: (context) {
                      return dataProvider.categoryItems.map((itemValue) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              itemValue,
                              style: Constants.dropDownSelectedItemTextStyle,
                            ),
                          ],
                        );
                      }).toList();
                    },
                    hint: Text(
                      "Select Task Category",
                      style: Constants.textFormFieldHintTextStyle,
                    ),
                    items: dataProvider.categoryItems
                        .map<DropdownMenuItem<String>>((String itemValue) {
                      return DropdownMenuItem<String>(
                        value: itemValue,
                        child: itemValue != "Other"
                            ? Text(
                                itemValue,
                                style: itemValue == _selectedCategory
                                    ? Constants.dropDownSelectedItemTextStyle
                                    : Constants.dropDownUnselectedItemTextStyle,
                              )
                            : Row(
                                children: const [
                                  Icon(
                                    Icons.add,
                                    size: 16,
                                  ),
                                  Text(
                                    "Create New Category",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                      );
                    }).toList(),
                    onChanged: (Object? categoryValue) {
                      setState(() {
                        _selectedCategory = categoryValue.toString();
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: Text("Category"),
                      labelStyle: Constants.textFormFieldLabelTextStyle,
                    ),
                  ),
                ),
                const SizedBox(
                  height: Constants.formItemPadding,
                ),
                SizedBox(
                  width: _screenWidth * (320 / 360),
                  child: DropdownButtonFormField(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: Colors.deepOrange,
                    ),
                    isExpanded: true,
                    value: _selectedPriority,
                    selectedItemBuilder: (context) {
                      return dataProvider.priorityItems.map((itemValue) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              itemValue,
                              style: Constants.dropDownSelectedItemTextStyle,
                            ),
                          ],
                        );
                      }).toList();
                    },
                    hint: Text(
                      "Set Task Priority",
                      style: Constants.textFormFieldHintTextStyle,
                    ),
                    items: dataProvider.priorityItems
                        .map<DropdownMenuItem<String>>((String itemValue) {
                      return DropdownMenuItem<String>(
                        value: itemValue,
                        child: Text(
                          itemValue,
                          style: itemValue == _selectedPriority
                              ? Constants.dropDownSelectedItemTextStyle
                              : Constants.dropDownUnselectedItemTextStyle,
                        ),
                      );
                    }).toList(),
                    onChanged: (Object? priorityValue) {
                      setState(() {
                        _selectedPriority = priorityValue.toString();
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: Text("Priority"),
                      labelStyle: Constants.textFormFieldLabelTextStyle,
                    ),
                  ),
                ),
                const SizedBox(
                  height: Constants.formItemPadding,
                ),
                SizedBox(
                  width: _screenWidth * (320 / 360),
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.deepOrange,
                        size: 32,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle:
                          (_selectedDueDate == null && widget.task == null)
                              ? Constants.textFormFieldHintTextStyle
                              : Constants.dropDownSelectedItemTextStyle,
                      hintText: widget.task != null
                          ? widget.task?.dueDate
                          : _selectedDueDate == null
                              ? "Set Due Date"
                              : DateFormat('d/M/yyyy, EEEE')
                                  .format(_selectedDueDate!),
                      label: const Text("Due Date"),
                      labelStyle: Constants.textFormFieldLabelTextStyle,
                    ),
                    onTap: () {
                      // Below line stops keyboard from appearing
                      FocusScope.of(context).requestFocus(FocusNode());

                      showDatePicker(
                        context: context,
                        currentDate: DateTime(1996),
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                      ).then((dateSelected) {
                        if (dateSelected == null) {
                          return;
                        }
                        setState(() {
                          _selectedDueDate = dateSelected;
                          widget.task?.dueDate = DateFormat('d/M/yyyy, EEEE').format(dateSelected);
                        });
                      });
                    },
                    style: _textTitleFieldController.text != ""
                        ? Constants.dropDownSelectedItemTextStyle
                        : Constants.dropDownUnselectedItemTextStyle,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  height: Constants.formItemPadding,
                ),
                _isLandscape! ? _getConfirmationButtons() : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }

  _getConfirmationButtons() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            highlightColor: Colors.grey.withOpacity(0.45),
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Ink(
              height: 56,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black.withOpacity(0.45),
                    width: 0.25,
                  ),
                ),
              ),
              child: const Center(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.25),
          height: 24,
          width: 1.5,
        ),
        Expanded(
          child: InkWell(
            highlightColor: Colors.grey.withOpacity(0.45),
            splashColor: Colors.transparent,
            onTap: () {
              if (widget.task != null) {
                bool result = DataProvider.of(context).updateTask(
                  taskId: widget.task?.taskId,
                  newTaskTitle: _textTitleFieldController.text,
                  newTaskCategory: _selectedCategory!,
                  newTaskPriority: _selectedPriority!,
                  newTaskDueDate: widget.task?.dueDate,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result
                        ? "Task successfully updated!"
                        : "Could not update the task!"),
                  ),
                );
              } else {
                DataProvider.of(context).addNewTask(
                  taskTitle: _textTitleFieldController.text,
                  taskCategory: _selectedCategory!,
                  taskPriority: _selectedPriority!,
                  taskDueDate:
                      DateFormat('d/M/yyyy, EEEE').format(_selectedDueDate!),
                );
              }
              Navigator.pop(context);
            },
            child: Ink(
              height: 56,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black.withOpacity(0.25),
                    width: 0.25,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  widget.task != null ? "Save Changes" : "Create Task",
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

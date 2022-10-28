import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/models/Task.dart';
import 'package:to_do_app/util/Constants.dart';
import 'package:uuid/uuid.dart';

class DataProvider extends ChangeNotifier {
  Uuid uuid = const Uuid();
  List<Task> _listOfTasks = [];
  final List<String> categoryItems = [
    'Home',
    'Office',
    'Study',
    'Gym',
    'Other'
  ];
  final List<String> priorityItems = ['Urgent', 'High', 'Medium', 'Low'];
  final List<Color> priorityColors = [
    Color(0xFFFF0000),
    Color(0xFF0033FF),
    Color(0xFF008C06),
    Color(0xFFFFB700)
  ];

  // final List<Color> priorityColors = [Colors.red, Colors.blue.shade700, Colors.green, Colors.limeAccent];
  SharedPreferences? pref;

  get tasks => _listOfTasks;

  DataProvider() {
    _loadData();
  }

  void _loadData() async {
    pref ??= await SharedPreferences.getInstance();
    String? data = pref?.getString(Constants.listOfTasksKey);

    var jsonDecoded = await jsonDecode(data!);
    _listOfTasks = jsonDecoded.map<Task>((element) {
      var task = Task.fromJson(element);
      return task;
    }).toList();

    notifyListeners();
  }

  saveData() {
    String tasksJson = jsonEncode(tasks);
    pref?.setString(Constants.listOfTasksKey, tasksJson);
  }

  static DataProvider of(BuildContext context, {bool listen = false}) {
    return Provider.of<DataProvider>(context, listen: listen);
  }

  void addNewTask({
    required String taskTitle,
    required String taskCategory,
    required String taskPriority,
    required String taskDueDate,
    String? taskDescription,
    int? taskRepetition,
  }) {
    Task newTask = Task(
      taskId: uuid.v4(),
      title: taskTitle,
      category: taskCategory,
      priority: taskPriority,
      dueDate: taskDueDate,
      description: taskDescription,
      repeatFrequency: taskRepetition,
    );

    _listOfTasks.add(newTask);
    saveData();
    notifyListeners();
  }

  void removeTask(int position) {
    _listOfTasks.removeAt(position);

    notifyListeners();
  }

  getPriorityColor(String priority) {
    Color colorOfPriority = priorityColors[priorityItems.indexOf(priority)];
    return colorOfPriority;
  }

  bool updateTask({
    required String? taskId,
    required String taskTitle,
    required String taskCategory,
    required String taskPriority,
    required String? taskDueDate,
  }) {
    for(Task task in tasks) {
      if(task.taskId == taskId) {
        task.title = taskTitle;
        task.category = taskCategory;
        task.priority = taskPriority;
        task.dueDate = taskDueDate!;

        notifyListeners();
        return true;
      }
    }
    return false;
  }
}

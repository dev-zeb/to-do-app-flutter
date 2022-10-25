
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
  final List<String> categoryItems = ['Home', 'Office', 'Study', 'Gym', 'Other'];
  final List<String> priorityItems = ['Urgent', 'High', 'Medium', 'Low'];
  final List<int> priorityColors = [0xFF110000, 0xFF001100, 0xFF000011, 0xFF001111];
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
}

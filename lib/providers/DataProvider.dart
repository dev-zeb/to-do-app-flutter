import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/models/Task.dart';
import 'package:to_do_app/util/Constants.dart';
import 'package:uuid/uuid.dart';

class DataProvider extends ChangeNotifier {
  Uuid uuid = const Uuid();
  List<Task> _listOfAllTasks = [];
  final List<Task> _listOfIncompleteTasks = [];
  final List<Task> _listOfCompletedTasks = [];

  final List<String> categoryItems = [
    'Home',
    'Office',
    'Study',
    'Gym',
    'Other'
  ];
  final List<String> priorityItems = ['Urgent', 'High', 'Medium', 'Low'];
  final List<Color> priorityColors = [
    const Color(0xFFFF0000),
    const Color(0xFF0033FF),
    const Color(0xFF008C06),
    const Color(0xFFFFB700)
  ];

  SharedPreferences? pref;

  get getAllTasks => _listOfAllTasks;

  get getIncompleteTasks => _listOfIncompleteTasks;

  DataProvider() {
    _loadData();
  }

  void _loadData() async {
    pref ??= await SharedPreferences.getInstance();
    String? data = pref?.getString(Constants.listOfTasksKey);

    var jsonDecoded = await jsonDecode(data!);
    _listOfAllTasks = jsonDecoded.map<Task>((element) {
      var task = Task.fromJson(element);
      if(task.isCompleted) {
        _listOfCompletedTasks.add(task);
      } else {
        _listOfIncompleteTasks.add(task);
      }
      return task;
    }).toList();



    notifyListeners();
  }

  saveData() {
    String tasksJson = jsonEncode(getAllTasks);
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

    _listOfAllTasks.add(newTask);
    saveData();
    notifyListeners();
  }

  void removeTask(int position) {
    _listOfAllTasks.removeAt(position);

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
    for(Task task in getAllTasks) {
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

  void completeTaskById(String taskId) {
    for (int i = 0; i < _listOfIncompleteTasks.length; i++) {
      if(_listOfIncompleteTasks[i].taskId == taskId){
        _listOfIncompleteTasks[i].isCompleted = true;
        _listOfAllTasks[i].isCompleted = true;

        _listOfCompletedTasks.add(_listOfIncompleteTasks[i]);

        _listOfIncompleteTasks.removeAt(i);
        break;
      }
    }
    notifyListeners();
  }
}

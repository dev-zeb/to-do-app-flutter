import 'package:flutter/foundation.dart';
import 'package:to_do_app/models/Task.dart';
import 'package:uuid/uuid.dart';

class DataProvider extends ChangeNotifier {
  Uuid uuid = const Uuid();
  final List<Task> _listOfTasks = [];
  final List<String> categoryItems = ['Home', 'Office', 'Study', 'Gym', 'Other'];
  final List<String> priorityItems = ['Urgent', 'High', 'Medium', 'Low'];
  final List<int> priorityColors = [0xFF110000, 0xFF001100, 0xFF000011, 0xFF001111];

  get tasks => _listOfTasks;

  void addNewTask(
    String taskTitle,
    int taskCategory,
    int taskPriority,
    String taskDueDate,
    String? taskDescription,
    int? taskRepetition,
  ) {
    Task newTask = Task(
      taskId: uuid.v4(),
      title: taskTitle,
      categoryId: taskCategory,
      priority: taskPriority,
      dueDate: taskDueDate,
      description: taskDescription,
      repeatFrequency: taskRepetition,
    );
    if (kDebugMode) {
      print("Added task -> $newTask");
    }
    _listOfTasks.add(newTask);

    notifyListeners();
  }

  void removeTask(int position) {
    _listOfTasks.removeAt(position);

    notifyListeners();
  }
}

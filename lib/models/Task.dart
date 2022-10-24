class Task {
  String taskId;
  String title;
  String category;
  String priority;
  String dueDate;
  bool isCompleted;
  String? description;
  int? repeatFrequency;

  Task({
    required this.taskId,
    required this.title,
    required this.category,
    required this.priority,
    required this.dueDate,
    this.isCompleted = false,
    this.description,
    this.repeatFrequency,
  });
}

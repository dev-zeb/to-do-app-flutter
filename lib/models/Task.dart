class Task {
  String taskId;
  String title;
  int categoryId;
  int priority;
  String dueDate;
  String? description;
  int? repeatFrequency;

  Task({
    required this.taskId,
    required this.title,
    required this.categoryId,
    required this.priority,
    required this.dueDate,
    this.description,
    this.repeatFrequency,
  });
}

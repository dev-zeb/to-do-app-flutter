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

  Task.fromJson(Map<String, dynamic> json) : taskId = json["taskId"], title = json["title"], category = json["category"],
  priority = json["priority"], dueDate = json["dueDate"], isCompleted = json["isCompleted"],
  description = json["description"], repeatFrequency = json["repeatFrequency"];

  Map<String, dynamic> toJson () => {
    'taskId': taskId,
    'title': title,
    'category': category,
    'priority': priority,
    'dueDate': dueDate,
    'isCompleted': isCompleted,
    'description': description,
    'repeatFrequency': repeatFrequency,
  };

}

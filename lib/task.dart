class Task {
  final String id;
  final String title;
  bool isCompleted;

  Task({required this.id, required this.title, this.isCompleted = false});

  // Convert a Map<String, dynamic> object to a Task object
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  // Convert the Task object to a Map<String, dynamic> object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}

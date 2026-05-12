class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime date;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.date,
  });
}
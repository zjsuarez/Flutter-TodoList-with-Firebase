class User {
  final String name;
  final String username;
  final bool notificationsEnabled;

  User({
    required this.name,
    required this.username,
    this.notificationsEnabled = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'notificationsEnabled': notificationsEnabled,
    };
  }
}

class User {
  final String name;
  final String username;


  User({
    required this.name,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
    };
  }
}

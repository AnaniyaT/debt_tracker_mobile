class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final String? profilePicture;
  final String? bio;
  final int amountOwed;
  final int amountOwing;
  final List<String> debts;
  final List<String> history;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.profilePicture,
    this.bio,
    required this.amountOwed,
    required this.amountOwing,
    required this.debts,
    required this.history,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      bio: json['bio'],
      amountOwed: json['amountOwed'],
      amountOwing: json['amountOwing'],
      debts: json['debts'].cast<String>(),
      history: json['history'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'username': username,
      'email': email,
      'profilePicture': profilePicture,
      'bio': bio,
      'amountOwed': amountOwed,
      'amountOwing': amountOwing,
      'debts': debts,
      'history': history,
    };
  }
}
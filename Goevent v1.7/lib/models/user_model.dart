class User {
  final String? id;
  final String? userId;
  final String name;
  final String email;
  final String? phone;

  User({
    this.id,
    this.userId,
    required this.name,
    required this.email,
    this.phone,
  });

  // Factory constructor for creating a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
    );
  }

  // Method to convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  // CopyWith method for immutability
  User copyWith({
    String? id,
    String? userId,
    String? name,
    String? email,
    String? phone,
  }) {
    return User(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, userId: $userId, name: $name, email: $email, phone: $phone)';
  }
}

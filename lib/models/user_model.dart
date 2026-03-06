class UserModel {
  final int id;
  final String nim;
  final String password;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.nim,
    required this.password,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      nim: json['nim'] as String,
      password: json['password'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nim': nim,
      'password': password,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}

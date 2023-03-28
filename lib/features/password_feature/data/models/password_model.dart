import '../../domain/entities/password_entity.dart';

class PasswordModel extends PasswordEntity {
  PasswordModel({
    required String role,
    required String password,
  }) : super(
          role: role,
          password: password,
        );

  factory PasswordModel.fromJson(Map<String, dynamic> json) {
    return PasswordModel(
      role: json['choices'][0]['password']['role'] ?? 'role',
      password: json['choices'][0]['password']['content'] ?? 'password',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': password
    };
  }
}

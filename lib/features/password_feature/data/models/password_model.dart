import '../../domain/entities/password_entity.dart';

class PasswordModel extends PasswordEntity {
  PasswordModel({
    required String website,
    required String password,
  }) : super(
          website: website,
          password: password,
        );

  factory PasswordModel.fromJson(Map<String, dynamic> json) {
    return PasswordModel(
      website: json['choices'][0]['password']['role'] ?? 'role',
      password: json['choices'][0]['password']['content'] ?? 'password',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': website,
      'content': password
    };
  }
}

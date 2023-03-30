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
      website: json['website'] ?? 'website',
      password: json['password'] ?? 'password',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': website,
      'content': password
    };
  }
}

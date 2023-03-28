import 'package:equatable/equatable.dart';

class PasswordEntity extends Equatable {
  String role;
  String password;

  PasswordEntity({
    required this.role,
    required this.password,
  });

  @override
  List<Object?> get props => [
        role,
        password,
      ];
}

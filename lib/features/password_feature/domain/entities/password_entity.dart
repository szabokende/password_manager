import 'package:equatable/equatable.dart';

class PasswordEntity extends Equatable {
  String website;
  String password;

  PasswordEntity({
    required this.website,
    required this.password,
  });

  @override
  List<Object?> get props => [
        website,
        password,
      ];
}



import 'package:equatable/equatable.dart';

import '../../domain/entities/password_entity.dart';


abstract class PasswordState  extends Equatable{

}
class EmptyPassword extends PasswordState {
  @override
  List<Object> get props => [];
}

class LoadingPassword  extends PasswordState {

  @override
  List<Object> get props => [];
}

class LoadedPasswordList  extends PasswordState {

  final List<PasswordEntity> passwordList;

  LoadedPasswordList ({required this.passwordList});

  @override
  List<Object> get props => [passwordList];
}
class LoadedPassword extends PasswordState {

  final PasswordEntity password;

  LoadedPassword ({required this.password});

  @override
  List<Object> get props => [password];
}


class ErrorPassword  extends PasswordState {
  final String message;

  ErrorPassword ({required this.message});

  @override
  List<Object> get props => [message];
}

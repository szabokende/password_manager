import 'package:equatable/equatable.dart';

import '../../domain/entities/password_entity.dart';


abstract class PasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreatePasswordEvent extends PasswordEvent {
  final PasswordEntity passwordEntity;

  CreatePasswordEvent({required this.passwordEntity});

  @override
  List<Object> get props => [passwordEntity];
}

class EditPasswordEvent extends PasswordEvent {
  final PasswordEntity passwordEntity;

  EditPasswordEvent({required this.passwordEntity});

  @override
  List<Object> get props => [passwordEntity];
}

class GetAllPasswordsEvent extends PasswordEvent {

}

class SendPasswordEvent extends PasswordEvent {
  final List<PasswordEntity> password;

  SendPasswordEvent({required this.password});

  @override
  List<Object> get props => [password];
}

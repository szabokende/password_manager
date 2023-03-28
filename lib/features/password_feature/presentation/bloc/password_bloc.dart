import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../utils/failure_messages.dart';
import '../../domain/entities/password_entity.dart';
import '../../domain/usecases/create_password.dart';
import '../../domain/usecases/edit_message.dart';
import '../../domain/usecases/get_all_password.dart';
import '../../domain/usecases/get_password.dart';
import 'password_event.dart';
import 'password_state.dart';



class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  late CreatePassword createPassword;
  late EditPassword editPassword;
  late GetAllPasswords getAllPasswords;
  late SendChatPassword getPasswordById;

  PasswordBloc({
    required CreatePassword createPassword,
    required EditPassword editPassword,
    required GetAllPasswords getAllPasswords,
    required SendChatPassword getPasswordById,
  })  : createPassword = createPassword,
        editPassword = editPassword,
        getAllPasswords = getAllPasswords,
        getPasswordById = getPasswordById,
        super(EmptyPassword()) {
    on<CreatePasswordEvent>(_onCreatePassword);
    on<EditPasswordEvent>(_onEditSpecificTaskEvent);
    on<GetAllPasswordsEvent>(_onGetAllPasswordsEvent);
    on<SendPasswordEvent>(_onGetPasswordByIdEvent);
  }

  void _onCreatePassword(
    CreatePasswordEvent event,
    Emitter<PasswordState> emit,
  ) async {
    switch (event.runtimeType) {
      case CreatePasswordEvent:
        emit(LoadingPassword());
        Either<Failure, void> response = await createPassword
            .call(CreatePasswordParams(vendorEntity: event.passwordEntity));
        return emit(
          await response.fold(
            (failure) => ErrorPassword(password: mapFailureToPassword(failure)),
            (password) => EmptyPassword(),
          ),
        );
      default:
        return emit(EmptyPassword());
    }
  }

  void _onEditSpecificTaskEvent(
    EditPasswordEvent event,
    Emitter<PasswordState> emit,
  ) async {
    switch (event.runtimeType) {
      case EditPasswordEvent:
        emit(LoadingPassword());
        Either<Failure, void> response = await editPassword
            .call(EditPasswordParams(passwordEntity: event.passwordEntity));
        return emit(
          await response.fold(
                (failure) => ErrorPassword(password: mapFailureToPassword(failure)),
                (password) => EmptyPassword(),
          ),
        );
      default:
        return emit(EmptyPassword());
    }
  }

  void _onGetAllPasswordsEvent(
    GetAllPasswordsEvent event,
    Emitter<PasswordState> emit,
  ) async {
    switch (event.runtimeType) {
      case GetAllPasswordsEvent:
        emit(LoadingPassword());
        Either<Failure, List<PasswordEntity>> response =
            await getAllPasswords.call(NoParams());
        return emit(
          await response.fold(
            (failure) => ErrorPassword(password: mapFailureToPassword(failure)),
            (passwordList) => LoadedPasswordList(passwordList: passwordList),
          ),
        );
      default:
        return emit(EmptyPassword());
    }
  }
  void _onGetPasswordByIdEvent(
      SendPasswordEvent event,
      Emitter<PasswordState> emit,
      ) async {
    switch (event.runtimeType) {
      case SendPasswordEvent:
        emit(LoadingPassword());
        Either<Failure, PasswordEntity> response =
        await getPasswordById.call(GetPasswordParam(passwordList:event.password));
        return emit(
          await response.fold(
                (failure) => ErrorPassword(password: mapFailureToPassword(failure)),
                (password) => LoadedPassword(password: password),
          ),
        );
      default:
        return emit(EmptyPassword());
    }
  }

}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/password_entity.dart';
import '../repositories/password_repository.dart';


class SendChatPassword implements UseCase<PasswordEntity, GetPasswordParam> {
  late final PasswordRepository repository;

  SendChatPassword(this.repository);

  @override
  Future<Either<Failure, PasswordEntity>> call(GetPasswordParam params) async {
    return await repository.getPasswordById(params.passwordList);
  }
}

class GetPasswordParam extends Equatable {
  late final List<PasswordEntity> passwordList;

  GetPasswordParam({required this.passwordList});

  @override
  List<Object> get props => [passwordList];
}

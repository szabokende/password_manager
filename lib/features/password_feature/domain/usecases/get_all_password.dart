import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/password_entity.dart';
import '../repositories/password_repository.dart';


class GetAllPasswords implements UseCase<List<PasswordEntity>, NoParams> {
  final PasswordRepository repository;

  GetAllPasswords(this.repository);

  @override
  Future<Either<Failure, List<PasswordEntity>>> call(NoParams params) async {
    print('get all passwords called');
    return await repository.getAllPasswords();
  }
}

//TODO getPasswordByUid use case


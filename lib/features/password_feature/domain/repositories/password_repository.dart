import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/password_entity.dart';


abstract class PasswordRepository {
  Future<Either<Failure, void>> createPassword(PasswordEntity password);

  Future<Either<Failure, void>> editPassword(PasswordEntity password);
  Future<Either<Failure, List<PasswordEntity>>> getAllPasswords();
  Future<Either<Failure, PasswordEntity>> getPasswordById(List<PasswordEntity> passwordList);
}

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/password_entity.dart';
import '../../domain/repositories/password_repository.dart';
import '../datasources/password_local_data_source.dart';
import '../datasources/password_remote_data_source.dart';


class PasswordRepositoryImpl implements PasswordRepository {
  PasswordRepositoryImpl({
    required this.passwordRemoteDataSource,
    required this.passwordLocalDataSource,
  });

  final PasswordRemoteDataSource passwordRemoteDataSource;
  final PasswordLocalDataSource passwordLocalDataSource;

  @override
  Future<Either<Failure, void>> createPassword(PasswordEntity password) async {
    try {
      await passwordLocalDataSource.createPassword(password);
      return Right(Future.value());
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> editPassword(PasswordEntity password) async {
    try {
      await passwordRemoteDataSource.editPassword(password);
      return Right(Future.value());
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    }
  }

  // TODO return all kinds of failures for all kinds of exceptions
  @override
  Future<Either<Failure, List<PasswordEntity>>> getAllPasswords() async {
    print('get all passwords called in repo impl');
    try {
      List<PasswordEntity> passwords = await passwordLocalDataSource.getAllPasswords();
      return Right(passwords);
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    }

  }

  @override
  Future<Either<Failure, PasswordEntity>> getPasswordById(List<PasswordEntity> passwordList) async {
    try {
      PasswordEntity passwords = await passwordRemoteDataSource.getPasswordById(passwordList);
      return Right(passwords);
    } on ServerException {
      return Left(ServerFailure());
    } on AccessDeniedException {
      return Left(AccessDeniedFailure());
    }
  }
}

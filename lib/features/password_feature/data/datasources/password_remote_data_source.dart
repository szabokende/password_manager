


import '../../domain/entities/password_entity.dart';

abstract class PasswordRemoteDataSource {
  /// Calls the https://api.morgen.so/tasks/create endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> createPassword(PasswordEntity passwordEntity);

  /// Calls the https://api.morgen.so/tasks/update endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> editPassword(PasswordEntity passwordEntity);

  Future<List<PasswordEntity>> getAllPasswords();
  Future<PasswordEntity> getPasswordById(List<PasswordEntity> passwordList);


}
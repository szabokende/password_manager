
import '../../domain/entities/password_entity.dart';

abstract class PasswordLocalDataSource {

  Future<void> createPassword(PasswordEntity passwordEntity);
  Future<void> editPassword(PasswordEntity passwordEntity);
  Future<List<PasswordEntity>> getAllPasswords();
  Future<PasswordEntity> getPasswordById(List<PasswordEntity> passwordList);


}
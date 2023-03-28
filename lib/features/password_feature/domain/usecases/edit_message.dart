import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/password_entity.dart';
import '../repositories/password_repository.dart';


class EditPassword implements UseCase<void, EditPasswordParams> {
  final PasswordRepository repository;

  EditPassword(this.repository);

  @override
  Future<Either<Failure, void>> call(EditPasswordParams params) async {
    return await repository.editPassword(params.passwordEntity);
  }
}

class EditPasswordParams extends Equatable {
  final PasswordEntity passwordEntity;

  EditPasswordParams({required this.passwordEntity});

  @override
  List<Object> get props => [passwordEntity];
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/password_entity.dart';
import '../repositories/password_repository.dart';


class CreatePassword implements UseCase<void, CreatePasswordParams> {
  final PasswordRepository repository;

  CreatePassword(this.repository);

  @override
  Future<Either<Failure, void>> call(CreatePasswordParams params) async {
    print('create passwords called');
    return await repository.createPassword(params.vendorEntity);
  }
}

class CreatePasswordParams extends Equatable {
  final PasswordEntity vendorEntity;

  CreatePasswordParams({required this.vendorEntity});

  @override
  List<Object> get props => [vendorEntity];
}

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';

import 'features/password_feature/data/datasources/password_remote_data_source.dart';
import 'features/password_feature/data/datasources/password_remote_data_source_impl.dart';

import 'features/password_feature/data/repositories/password_repository_impl.dart';

import 'features/password_feature/domain/repositories/password_repository.dart';

import 'features/password_feature/domain/usecases/create_password.dart';



import 'features/password_feature/domain/usecases/edit_message.dart';
import 'features/password_feature/domain/usecases/get_all_password.dart';

import 'features/password_feature/domain/usecases/get_password.dart';

import 'features/password_feature/presentation/bloc/password_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {


  //! Features - Vendor Item Feature //////////// ////////// ////////// //////////// ////////// ////////// //////////// ////////// //////////
  // Bloc
  sl.registerFactory(() => PasswordBloc(
        createPassword: sl(),
        editPassword: sl(),
        getAllPasswords: sl(),
        getPasswordById: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => CreatePassword(sl()));
  sl.registerLazySingleton(() => EditPassword(sl()));
  sl.registerLazySingleton(() => GetAllPasswords(sl()));
  sl.registerLazySingleton(() => SendChatPassword(sl()));

  // Repositories
  sl.registerLazySingleton<PasswordRepository>(
    () => PasswordRepositoryImpl(passwordRemoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<PasswordRemoteDataSource>(
    () => PasswordRemoteDataSourceImpl(client: sl()),
  );



  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  sl.registerLazySingleton(() => http.Client());
}

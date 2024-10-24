part of '../config.dart';

Future<void> get loginDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => LoginBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ForgotPasswordBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => LoginUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => ForgotPasswordUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      network: sl(),
      auth: sl(),
      remote: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(
      client: sl(),
    ),
  );
}

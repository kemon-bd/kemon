part of '../config.dart';

Future<void> get registrationDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => RegistrationBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => CreateRegistrationUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<RegistrationRepository>(
    () => RegistrationRepositoryImpl(
      network: sl(),
      remote: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<RegistrationRemoteDataSource>(
    () => RegistrationRemoteDataSourceImpl(
      client: sl(),
    ),
  );
}

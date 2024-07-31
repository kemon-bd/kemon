part of '../config.dart';

Future<void> get registrationDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => RegistrationBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => OtpBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => CreateRegistrationUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => OtpUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<RegistrationRepository>(
    () => RegistrationRepositoryImpl(
      network: sl(),
      profile: sl(),
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

part of '../config.dart';

Future<void> get profileDependencies async {
  //! ----------------- Bloc -----------------

  sl.registerFactory(
    () => FindProfileBloc(
      useCase: sl(),
    ),
  );

  sl.registerFactory(
    () => UpdateProfileBloc(
      useCase: sl(),
    ),
  );

  sl.registerFactory(
    () => DeleteProfileBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------

  sl.registerFactory(
    () => FindProfileUseCase(
      repository: sl(),
    ),
  );

  sl.registerFactory(
    () => UpdateProfileUseCase(
      repository: sl(),
    ),
  );

  sl.registerFactory(
    () => DeleteProfileUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      network: sl(),
      auth: sl(),
      local: sl(),
      remote: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(),
  );
}

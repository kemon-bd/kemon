part of '../config.dart';

Future<void> get lookupDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => FindLookupBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => FindLookupUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<LookupRepository>(
    () => LookupRepositoryImpl(
      network: sl(),
      remote: sl(),
      local: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<LookupRemoteDataSource>(
    () => LookupRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<LookupLocalDataSource>(
    () => LookupLocalDataSourceImpl(),
  );
}

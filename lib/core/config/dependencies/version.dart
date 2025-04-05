part of '../config.dart';

Future<void> get versionDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => FindVersionBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => FindVersionUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<VersionRepository>(
    () => VersionRepositoryImpl(
      network: sl(),
      remote: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<VersionRemoteDataSource>(
    () => VersionRemoteDataSourceImpl(
      config: sl(),
    ),
  );
}

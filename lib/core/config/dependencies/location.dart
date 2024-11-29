part of '../config.dart';

Future<void> get locationDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => FeaturedLocationsBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FindLocationBloc(find: sl(), refresh: sl()),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => FeaturedLocationsUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindLocationUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => RefreshLocationUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(
      network: sl(),
      remote: sl(),
      local: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<LocationLocalDataSource>(
    () => LocationLocalDataSourceImpl(),
  );
}

part of '../config.dart';

Future<void> get locationDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => FeaturedLocationsBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => LocationDeeplinkBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FindAllLocationsBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => LocationListingsFilterBloc(analytics: sl()),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => FeaturedLocationsUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindAllLocationsUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindLocationDeeplinkUseCase(
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

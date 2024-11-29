part of '../config.dart';

Future<void> get analyticsDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => SyncAnalyticsBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => SyncAnalyticsUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<AnalyticsRepository>(
    () => AnalyticsRepositoryImpl(
      network: sl(),
      auth: sl(),
      remote: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<AnalyticsRemoteDataSource>(
    () => AnalyticsRemoteDataSourceImpl(
      client: sl(),
    ),
  );
}

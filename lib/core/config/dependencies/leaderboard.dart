part of '../config.dart';

Future<void> get leaderboardDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => FindLeaderboardBloc(
      find: sl(),
      refresh: sl(),
    ),
  );
  sl.registerLazySingleton(() => LeaderboardFilterBloc());

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => FindLeaderboardUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => RefreshLeaderboardUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<LeaderboardRepository>(
    () => LeaderboardRepositoryImpl(
      network: sl(),
      filter: sl(),
      remote: sl(),
      local: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<LeaderboardRemoteDataSource>(
    () => LeaderboardRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<LeaderboardLocalDataSource>(
    () => LeaderboardLocalDataSourceImpl(),
  );
}

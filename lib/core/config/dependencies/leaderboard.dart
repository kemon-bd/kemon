part of '../config.dart';

Future<void> get leaderboardDependencies async {
  //! ----------------- Bloc -----------------

  sl.registerFactory(
    () => FindLeaderboardBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------

  sl.registerFactory(
    () => FindLeaderboardUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<LeaderboardRepository>(
    () => LeaderboardRepositoryImpl(
      network: sl(),
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

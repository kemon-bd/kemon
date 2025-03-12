part of '../config.dart';

Future<void> get industryDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => FindIndustryBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FindIndustriesBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FindIndustriesByLocationBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => FindIndustryUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindIndustriesUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindIndustriesByLocationUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<IndustryRepository>(
    () => IndustryRepositoryImpl(
      network: sl(),
      remote: sl(),
      local: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<IndustryRemoteDataSource>(
    () => IndustryRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<IndustryLocalDataSource>(
    () => IndustryLocalDataSourceImpl(),
  );
}

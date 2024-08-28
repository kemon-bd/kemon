part of '../config.dart';

Future<void> get businessDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => FindBusinessBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FindBusinessesByCategoryBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => FindBusinessUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => BusinessesByCategoryUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<BusinessRepository>(
    () => BusinessRepositoryImpl(
      network: sl(),
      remote: sl(),
      local: sl(),
      subCategory: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<BusinessRemoteDataSource>(
    () => BusinessRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<BusinessLocalDataSource>(
    () => BusinessLocalDataSourceImpl(),
  );
}

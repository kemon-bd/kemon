part of '../config.dart';

Future<void> get reviewDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => CreateReviewBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => DeleteReviewBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FindUserReviewsBloc(
      find: sl(),
    ),
  );
  sl.registerFactory(
    () => FindReviewReactionsBloc(
      find: sl(),
    ),
  );
  sl.registerFactory(
    () => FindReviewDetailsBloc(
      find: sl(),
      refresh: sl(),
    ),
  );
  sl.registerFactory(
    () => UpdateReviewBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ReactOnReviewBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FlagBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => CreateReviewUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindReviewReactionsUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FlagAReviewUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => UpdateReviewUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => DeleteReviewUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindUserReviewsUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindReviewDetailsUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => RefreshReviewDetailsUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => ReactOnReviewUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImpl(
      network: sl(),
      auth: sl(),
      remote: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<ReviewRemoteDataSource>(
    () => ReviewRemoteDataSourceImpl(
      client: sl(),
    ),
  );
}

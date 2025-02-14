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
    () => FindListingReviewsBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FindRatingBloc(
      find: sl(),
    ),
  );
  sl.registerFactory(
    () => UpdateReviewBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => RecentReviewsBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ReactionBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ReactOnReviewBloc(
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
    () => FindListingReviewUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindRatingUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => RecentReviewsUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindReviewReactionsUseCase(
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
      local: sl(),
      remote: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<ReviewRemoteDataSource>(
    () => ReviewRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<ReviewLocalDataSource>(
    () => ReviewLocalDataSourceImpl(),
  );
}

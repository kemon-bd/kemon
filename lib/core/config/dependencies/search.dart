part of '../config.dart';

Future<void> get searchDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => SearchResultBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => SearchSuggestionBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => SearchResultUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => SearchSuggestionsUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      network: sl(),
      location: sl(),
      industry: sl(),
      category: sl(),
      subCategory: sl(),
      remote: sl(),
      local: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<SearchLocalDataSource>(
    () => SearchLocalDataSourceImpl(),
  );
}

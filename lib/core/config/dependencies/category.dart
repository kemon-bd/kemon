part of '../config.dart';

Future<void> get categoryDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => FindCategoryBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FindCategoriesByIndustryBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FeaturedCategoriesBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FindAllCategoriesBloc(
      find: sl(),
      refresh: sl(),
    ),
  );
  sl.registerFactory(
    () => CategoryListingsFilterBloc(
      analytics: sl(),
    ),
  );
  sl.registerFactory(
    () => FindLocationsByCategoryBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => FindCategoryUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindLocationsByCategoriesUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindCategoriesByIndustryUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FeaturedCategoriesUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindAllCategoryUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => RefreshAllCategoryUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      network: sl(),
      remote: sl(),
      local: sl(),
      industryCache: sl(),
      subCategoryCache: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(),
  );
}

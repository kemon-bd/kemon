part of '../config.dart';

Future<void> get subCategoryDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => FindSubCategoryBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => SubCategoriesByCategoryBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => FindSubCategoryUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => SubCategoriesByCategoryUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<SubCategoryRepository>(
    () => SubCategoryRepositoryImpl(
      network: sl(),
      remote: sl(),
      local: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<SubCategoryRemoteDataSource>(
    () => SubCategoryRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<SubCategoryLocalDataSource>(
    () => SubCategoryLocalDataSourceImpl(),
  );
}

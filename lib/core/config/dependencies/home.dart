part of '../config.dart';

Future<void> get homeDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(() => OverviewBloc(usecase: sl()));
  sl.registerFactory(() => HomeOverviewUsecase(repository: sl()));
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      auth: sl(),
      category: sl(),
      location: sl(),
      network: sl(),
      remote: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(client: sl()),
  );
}

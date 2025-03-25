part of '../config.dart';

Future<void> get loginDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => LoginBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FacebookLoginBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => GoogleSignInBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => AppleLoginBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ForgotPasswordBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => LoginUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FacebookLoginUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => GoogleSignInUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => AppleSignInUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => ForgotPasswordUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      network: sl(),
      auth: sl(),
      remote: sl(),
      google: sl(),
      facebook: sl(),
      registration: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<FacebookDataSource>(
    () => FacebookDataSourceImpl(
      facebook: sl(),
    ),
  );
  sl.registerLazySingleton<GoogleDataSource>(
    () => GoogleDataSourceImpl(
      google: sl(),
    ),
  );
}

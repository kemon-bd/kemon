part of '../config.dart';

Future<void> get profileDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => FindProfileBloc(
      find: sl(),
      refresh: sl(),
    ),
  );
  sl.registerFactory(
    () => CheckProfileBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => UpdateProfileBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => DeleteProfileBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => DeactivateAccountBloc(
      generate: sl(),
      deactivate: sl(),
    ),
  );
  sl.registerFactory(
    () => RequestOtpForPasswordChangeBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ResetPasswordBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => BlockListBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => BlockBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => UnblockBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => BlockListUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => BlockSomeoneUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => UnblockSomeoneUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindProfileUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => RefreshProfileUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => CheckProfileUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => UpdateProfileUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => DeleteProfileUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => DeactivateAccountUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => GenerateOtpForAccountDeactivationUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => RequestOtpForPasswordChangeUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => ResetPasswordUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      network: sl(),
      auth: sl(),
      local: sl(),
      remote: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(),
  );
}

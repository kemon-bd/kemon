part of 'deactivate_bloc.dart';

sealed class DeactivateAccountState extends Equatable {
  const DeactivateAccountState();

  @override
  List<Object> get props => [];
}

final class DeactivateAccountInitial extends DeactivateAccountState {}

final class DeactivateAccountError extends DeactivateAccountState {
  final Failure failure;

  const DeactivateAccountError({
    required this.failure,
  });
}

final class DeactivateAccountLoading extends DeactivateAccountState {
  const DeactivateAccountLoading();
}

final class DeactivateAccountOtp extends DeactivateAccountState {
  final String otp;

  const DeactivateAccountOtp({
    required this.otp,
  });
}

final class DeactivateAccountDone extends DeactivateAccountState {
  const DeactivateAccountDone();
}

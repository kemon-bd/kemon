part of 'deactivate_bloc.dart';

sealed class DeactivateAccountEvent extends Equatable {
  const DeactivateAccountEvent();

  @override
  List<Object> get props => [];
}

final class GenerateOtpForAccountDeactivation extends DeactivateAccountEvent {}

final class DeactivateAccount extends DeactivateAccountEvent {
  final String otp;

  const DeactivateAccount({
    required this.otp,
  });
}

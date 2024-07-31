part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationError extends RegistrationState {
  final Failure failure;

  const RegistrationError({required this.failure});
  @override
  List<Object> get props => [failure];
}

final class RegistrationLoading extends RegistrationState {
  const RegistrationLoading();
}

final class RegistrationDone extends RegistrationState {
  const RegistrationDone();
}

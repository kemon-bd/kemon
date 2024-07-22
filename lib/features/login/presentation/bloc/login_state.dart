part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginError extends LoginState {
  final Failure failure;

  const LoginError({required this.failure});
  @override
  List<Object> get props => [failure];
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginDone extends LoginState {
  const LoginDone();
}

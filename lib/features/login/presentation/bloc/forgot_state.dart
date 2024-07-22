part of 'forgot_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordError extends ForgotPasswordState {
  final Failure failure;

  const ForgotPasswordError({required this.failure});
  @override
  List<Object> get props => [failure];
}

final class ForgotPasswordLoading extends ForgotPasswordState {
  const ForgotPasswordLoading();
}

final class ForgotPasswordDone extends ForgotPasswordState {
  const ForgotPasswordDone();
}

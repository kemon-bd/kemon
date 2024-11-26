part of 'reset_password_bloc.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

final class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial();
  @override
  List<Object> get props => [];
}

final class ResetPasswordError extends ResetPasswordState {
  final Failure failure;

  const ResetPasswordError({
    required this.failure,
  });
  @override
  List<Object> get props => [failure];
}

final class ResetPasswordLoading extends ResetPasswordState {
  const ResetPasswordLoading();
  @override
  List<Object> get props => [];
}

final class ResetPasswordDone extends ResetPasswordState {
  const ResetPasswordDone();
  @override
  List<Object> get props => [];
}

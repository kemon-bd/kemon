part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

final class ResetPassword extends ResetPasswordEvent {
  final String username;
  final String password;

  const ResetPassword({
    required this.username,
    required this.password,
  });
  @override
  List<Object> get props => [username, password];
}

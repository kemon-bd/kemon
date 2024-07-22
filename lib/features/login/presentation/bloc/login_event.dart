part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  final String username;
  final String password;
  final bool remember;

  const Login({
    required this.username,
    required this.password,
    required this.remember,
  });

  @override
  List<Object> get props => [username, password, remember];
}

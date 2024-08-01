part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthorizeAuthentication extends AuthenticationEvent {
  final String username;
  final String password;
  final bool remember;
  final TokenModel token;
  final ProfileModel profile;

  const AuthorizeAuthentication({
    required this.username,
    required this.password,
    required this.remember,
    required this.token,
    required this.profile,
  });

  @override
  List<Object> get props => [profile, token, username, password, remember];
}

class UpdateAuthorizedProfile extends AuthenticationEvent {
  final ProfileModel profile;

  const UpdateAuthorizedProfile({
    required this.profile,
  });

  @override
  List<Object> get props => [profile];
}

class AuthenticationLogout extends AuthenticationEvent {
  const AuthenticationLogout();

  @override
  List<Object> get props => [];
}

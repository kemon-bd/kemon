part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final String username;
  final String password;
  final bool remember;
  final ProfileModel? profile;
  final TokenModel? token;

  const AuthenticationState({
    required this.username,
    required this.password,
    required this.remember,
    this.token,
    this.profile,
  });

  factory AuthenticationState.parse({
    required Map<String, dynamic> map,
  }) {
    return AuthenticationState(
      username: map["username"],
      password: map["password"],
      remember: map["remember"],
      token: map["token"] != null ? TokenModel.parse(map: map["token"]) : null,
      profile: map["profile"] != null
          ? ProfileModel.parse(map: map["profile"])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        remember,
        token,
        profile,
      ];
}

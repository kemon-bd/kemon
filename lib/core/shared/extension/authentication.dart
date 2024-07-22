import '../shared.dart';

import '../../../features/authentication/authentication.dart';
import '../../../features/login/login.dart';
import '../../../features/profile/profile.dart';

extension AuthenticationStateExtension on AuthenticationState {
  AuthenticationState copyWith({
    TokenModel? token,
    ProfileModel? profile,
    String? username,
    String? password,
    bool? remember,
  }) {
    return AuthenticationState(
      username: username ?? this.username,
      password: password ?? this.password,
      remember: remember ?? this.remember,
      token: token ?? this.token,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> get toMap {
    return {
      "username": username,
      "password": password,
      "remember": remember,
      "token": token?.toMap,
    };
  }
}

extension AuthenticationBlocExtension on AuthenticationBloc {
  bool get authenticated =>
      state.token != null &&
      state.token!.accessToken.isNotEmpty &&
      !state.token!.expired;

  String? get token => state.token?.accessToken;
  String? get name => state.profile?.name.full;
  String? get userGuid => state.profile?.identity.guid;
  Identity? get userIdentity => state.profile?.identity;
  String? get username => state.username;
  String? get password => state.password;
  bool? get remember => state.remember;
}

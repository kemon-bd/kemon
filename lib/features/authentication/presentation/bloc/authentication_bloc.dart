import '../../../../core/shared/shared.dart';
import '../../../login/login.dart';
import '../../../profile/profile.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(
          const AuthenticationState(
            password: '',
            username: '',
            remember: false,
            token: null,
          ),
        ) {
    on<AuthorizeAuthentication>((event, emit) {
      emit(
        AuthenticationState(
          username: event.username,
          password: event.password,
          remember: event.remember,
          token: event.token,
          profile: event.profile,
        ),
      );
    });
    on<UpdateAuthorizedProfile>((event, emit) {
      emit(state.copyWith(profile: event.profile));
    });

    on<AuthenticationLogout>((event, emit) async {
      emit(
        AuthenticationState(
          username: state.username,
          password: state.password,
          remember: state.remember,
          token: null,
          profile: null,
        ),
      );
    });
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return null;
    } else {
      final remember = json['remember'] ?? false;
      if (remember) {
        return AuthenticationState.parse(map: json);
      }
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState? state) {
    return state?.toMap;
  }
}

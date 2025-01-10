import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../login.dart';

part 'fb_login_event.dart';
part 'fb_login_state.dart';

class FacebookLoginBloc extends Bloc<FacebookLoginEvent, FacebookLoginState> {
  final FacebookLoginUseCase useCase;
  FacebookLoginBloc({
    required this.useCase,
  }) : super(FacebookLoginInitial()) {
    on<LoginWithFacebook>((event, emit) async {
      emit(FacebookLoginLoading());

      final result = await useCase();

      result.fold(
        (failure) => emit(FacebookLoginError(failure: failure)),
        (profile) => emit(FacebookLoginDone(profile: profile)),
      );
    });
  }
}

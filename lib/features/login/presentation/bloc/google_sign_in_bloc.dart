import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../login.dart';

part 'google_sign_in_event.dart';
part 'google_sign_in_state.dart';

class GoogleSignInBloc extends Bloc<GoogleSignInEvent, GoogleSignInState> {
  final GoogleSignInUseCase useCase;
  GoogleSignInBloc({
    required this.useCase,
  }) : super(GoogleSignInInitial()) {
    on<SignInWithGoogle>((event, emit) async {
      emit(GoogleSignInLoading());

      final result = await useCase();

      result.fold(
        (failure) => emit(GoogleSignInError(failure: failure)),
        (profile) => emit(GoogleSignInDone(profile: profile)),
      );
    });
  }
}

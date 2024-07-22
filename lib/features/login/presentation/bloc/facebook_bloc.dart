import '../../../../core/shared/shared.dart';
import '../../login.dart';

part 'facebook_event.dart';
part 'facebook_state.dart';

class SignInWithFacebookBloc
    extends Bloc<SignInWithFacebookEvent, SignInWithFacebookState> {
  final FacebookSignInUseCase useCase;
  SignInWithFacebookBloc({
    required this.useCase,
  }) : super(SignInWithFacebookInitial()) {
    on<SignInWithFacebook>((event, emit) async {
      emit(const SignInWithFacebookLoading());

      final result = await useCase();

      result.fold(
        (failure) => emit(SignInWithFacebookError(failure: failure)),
        (_) => emit(const SignInWithFacebookDone()),
      );
    });
  }
}

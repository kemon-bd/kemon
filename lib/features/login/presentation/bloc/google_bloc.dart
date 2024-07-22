import '../../../../core/shared/shared.dart';
import '../../login.dart';

part 'google_event.dart';
part 'google_state.dart';

class SignInWithGoogleBloc extends Bloc<SignInWithGoogleEvent, SignInWithGoogleState> {
  final GoogleSignInUseCase useCase;
  SignInWithGoogleBloc({
    required this.useCase,
  }) : super(SignInWithGoogleInitial()) {
    on<SignInWithGoogle>((event, emit) async {
      emit(const SignInWithGoogleLoading());

      final result = await useCase();

      result.fold(
        (failure) => emit(SignInWithGoogleError(failure: failure)),
        (_) => emit(const SignInWithGoogleDone()),
      );
    });
  }
}

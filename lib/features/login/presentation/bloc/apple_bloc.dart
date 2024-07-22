import '../../../../core/shared/shared.dart';
import '../../login.dart';

part 'apple_event.dart';
part 'apple_state.dart';

class SignInWithAppleBloc extends Bloc<SignInWithAppleEvent, SignInWithAppleState> {
  final AppleSignInUseCase useCase;
  SignInWithAppleBloc({
    required this.useCase,
  }) : super(SignInWithAppleInitial()) {
    on<SignInWithApple>((event, emit) async {
      emit(const SignInWithAppleLoading());

      final result = await useCase();

      result.fold(
        (failure) => emit(SignInWithAppleError(failure: failure)),
        (_) => emit(const SignInWithAppleDone()),
      );
    });
  }
}

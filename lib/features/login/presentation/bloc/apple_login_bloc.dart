import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../login.dart';

part 'apple_login_event.dart';
part 'apple_login_state.dart';

class AppleLoginBloc extends Bloc<AppleLoginEvent, AppleLoginState> {
  final AppleSignInUseCase useCase;
  AppleLoginBloc({
    required this.useCase,
  }) : super(AppleLoginInitial()) {
    on<LoginWithApple>((event, emit) async {
      emit(AppleLoginLoading());

      final result = await useCase();

      result.fold(
        (failure) => emit(AppleLoginError(failure: failure)),
        (profile) => emit(AppleLoginDone(profile: profile)),
      );
    });
  }
}

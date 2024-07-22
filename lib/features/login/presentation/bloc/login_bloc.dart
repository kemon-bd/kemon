import '../../../../core/shared/shared.dart';
import '../../login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase useCase;
  LoginBloc({
    required this.useCase,
  }) : super(LoginInitial()) {
    on<Login>((event, emit) async {
      emit(const LoginLoading());

      final result = await useCase(
        username: event.username,
        password: event.password,
        remember: event.remember,
      );

      result.fold(
        (failure) => emit(LoginError(failure: failure)),
        (_) => emit(const LoginDone()),
      );
    });
  }
}

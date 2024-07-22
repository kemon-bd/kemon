import '../../../../core/shared/shared.dart';
import '../../login.dart';

part 'forgot_event.dart';
part 'forgot_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase useCase;
  ForgotPasswordBloc({
    required this.useCase,
  }) : super(ForgotPasswordInitial()) {
    on<ForgotPassword>((event, emit) async {
      emit(const ForgotPasswordLoading());

      final result = await useCase(username: event.username);

      result.fold(
        (failure) => emit(ForgotPasswordError(failure: failure)),
        (_) => emit(const ForgotPasswordDone()),
      );
    });
  }
}

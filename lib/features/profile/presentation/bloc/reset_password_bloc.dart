import '../../../../core/shared/shared.dart';
import '../../profile.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUseCase useCase;

  ResetPasswordBloc({
    required this.useCase,
  }) : super(ResetPasswordInitial()) {
    on<ResetPassword>((event, emit) async {
      emit(ResetPasswordLoading());
      final result = await useCase(username: event.username, password: event.password);
      result.fold(
        (failure) => emit(ResetPasswordError(failure: failure)),
        (r) => emit(ResetPasswordDone()),
      );
    });
  }
}

import '../../../../core/shared/shared.dart';
import '../../profile.dart';

part 'request_password_change_event.dart';
part 'request_password_change_state.dart';

class RequestOtpForPasswordChangeBloc extends Bloc<RequestOtpForPasswordChangeEvent, RequestOtpForPasswordChangeState> {
  final RequestOtpForPasswordChangeUseCase useCase;

  RequestOtpForPasswordChangeBloc({
    required this.useCase,
  }) : super(RequestOtpForPasswordChangeInitial()) {
    on<RequestOtpForPasswordChange>((event, emit) async {
      emit(RequestOtpForPasswordChangeLoading());
      final result = await useCase(username: event.username, verificationOnly: false);
      result.fold(
        (failure) => emit(RequestOtpForPasswordChangeError(failure: failure)),
        (otp) => emit(RequestOtpForPasswordChangeDone(otp: otp)),
      );
    });
    on<RequestOtpForPhoneOrEmailVerification>((event, emit) async {
      emit(RequestOtpForPasswordChangeLoading());
      final result = await useCase(username: event.username, verificationOnly: true);
      result.fold(
        (failure) => emit(RequestOtpForPasswordChangeError(failure: failure)),
        (otp) => emit(RequestOtpForPasswordChangeDone(otp: otp)),
      );
    });
  }
}

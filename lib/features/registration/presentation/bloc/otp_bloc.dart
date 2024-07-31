import '../../../../core/shared/shared.dart';
import '../../registration.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpUseCase useCase;
  OtpBloc({
    required this.useCase,
  }) : super(const OtpInitial()) {
    on<ResendOtp>((event, emit) async {
      emit(const OtpLoading());

      final result = await useCase(username: event.username);
      result.fold(
        (failure) => emit(OtpError(failure: failure)),
        (code) => emit(OtpDone(code: code)),
      );
    });
  }
}

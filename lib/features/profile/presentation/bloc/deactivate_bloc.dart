import 'package:kemon/features/profile/profile.dart';

import '../../../../core/shared/shared.dart';

part 'deactivate_event.dart';
part 'deactivate_state.dart';

class DeactivateAccountBloc extends Bloc<DeactivateAccountEvent, DeactivateAccountState> {
  final GenerateOtpForAccountDeactivationUseCase generate;
  final DeactivateAccountUseCase deactivate;
  DeactivateAccountBloc({
    required this.generate,
    required this.deactivate,
  }) : super(DeactivateAccountInitial()) {
    on<GenerateOtpForAccountDeactivation>((event, emit) async {
      emit(const DeactivateAccountLoading());

      final result = await generate();

      result.fold(
        (failure) => emit(DeactivateAccountError(failure: failure)),
        (otp) => emit(DeactivateAccountOtp(otp: otp)),
      );
    });

    on<DeactivateAccount>((event, emit) async {
      emit(const DeactivateAccountLoading());

      final result = await deactivate(otp: event.otp);

      result.fold(
        (failure) => emit(DeactivateAccountError(failure: failure)),
        (otp) => emit(const DeactivateAccountDone()),
      );
    });
  }
}

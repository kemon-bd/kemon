import '../../../../core/shared/shared.dart';
import '../../profile.dart';

part 'check_event.dart';
part 'check_state.dart';

class CheckProfileBloc extends Bloc<CheckProfileEvent, CheckProfileState> {
  final CheckProfileUseCase useCase;
  CheckProfileBloc({required this.useCase})
      : super(const CheckProfileInitial()) {
    on<CheckProfile>((event, emit) async {
      emit(const CheckProfileLoading());
      final result = await useCase(username: event.username);
      result.fold(
        (failure) => emit(CheckProfileError(failure: failure)),
        (response) => response.fold(
          (otp) => emit(CheckProfileNewUser(otp: otp)),
          (profile) => emit(CheckProfileExistingUser(profile: profile)),
        ),
      );
    });
  }
}

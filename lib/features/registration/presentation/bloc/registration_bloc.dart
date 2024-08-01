import '../../../../core/shared/shared.dart';
import '../../registration.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final CreateRegistrationUseCase useCase;
  RegistrationBloc({
    required this.useCase,
  }) : super(RegistrationInitial()) {
    on<CreateAccount>((event, emit) async {
      emit(const RegistrationLoading());

      final result = await useCase(
        username: event.username,
        password: event.password,
        refference: event.refference,
        name: Name(first: event.firstName, last: event.lastName),
        contact: Contact(phone: event.phone, email: event.email),
        dob: event.dob,
        gender: event.gender,
      );

      result.fold(
        (failure) => emit(RegistrationError(failure: failure)),
        (identity) => emit(RegistrationDone(identity: identity)),
      );
    });
  }
}

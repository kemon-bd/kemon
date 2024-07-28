import '../../../../core/shared/shared.dart';
import '../../profile.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileUseCase useCase;
  UpdateProfileBloc({required this.useCase}) : super(const UpdateProfileInitial()) {
    on<UpdateProfile>((event, emit) async {
      emit(const UpdateProfileLoading());
      final result = await useCase(profile: event.profile, avatar: event.avatar);
      result.fold(
        (failure) => emit(UpdateProfileError(failure: failure)),
        (_) => emit(const UpdateProfileDone()),
      );
    });
  }
}

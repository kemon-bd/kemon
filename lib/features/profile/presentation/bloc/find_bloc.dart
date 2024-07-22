import '../../../../core/shared/shared.dart';
import '../../profile.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindProfileBloc extends Bloc<FindProfileEvent, FindProfileState> {
  final FindProfileUseCase useCase;
  FindProfileBloc({required this.useCase}) : super(const FindProfileInitial()) {
    on<FindProfile>((event, emit) async {
      emit(const FindProfileLoading());
      final result = await useCase(identity: event.identity);
      result.fold(
        (failure) => emit(FindProfileError(failure: failure)),
        (profile) => emit(FindProfileDone(profile: profile)),
      );
    });
  }
}

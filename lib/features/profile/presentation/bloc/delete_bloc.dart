import '../../../../core/shared/shared.dart';
import '../../profile.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteProfileBloc extends Bloc<DeleteProfileEvent, DeleteProfileState> {
  final DeleteProfileUseCase useCase;
  DeleteProfileBloc({required this.useCase}) : super(const DeleteProfileInitial()) {
    on<DeleteProfile>((event, emit) async {
      emit(const DeleteProfileLoading());
      final result = await useCase(identity: event.identity);
      result.fold(
        (failure) => emit(DeleteProfileError(failure: failure)),
        (_) => emit(const DeleteProfileDone()),
      );
    });
  }
}

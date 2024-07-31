import '../../../../core/shared/shared.dart';
import '../../industry.dart';

part 'finds_event.dart';
part 'finds_state.dart';

class FindIndustriesBloc
    extends Bloc<FindIndustriesEvent, FindIndustriesState> {
  final FindIndustriesUseCase useCase;
  FindIndustriesBloc({required this.useCase})
      : super(const FindIndustriesInitial()) {
    on<FindIndustries>((event, emit) async {
      emit(const FindIndustriesLoading());
      final result = await useCase();
      result.fold(
        (failure) => emit(FindIndustriesError(failure: failure)),
        (industries) => emit(FindIndustriesDone(industries: industries)),
      );
    });
  }
}

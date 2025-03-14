import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindLookupBloc extends Bloc<FindLookupEvent, FindLookupState> {
  final FindLookupUseCase find;
  final SearchLookupUseCase search;
  FindLookupBloc({
    required this.find,
    required this.search,
  }) : super(const FindLookupInitial()) {
    on<FindLookup>((event, emit) async {
      emit(const FindLookupLoading());
      final result = await find(
        key: (key: event.lookup, parent: null),
      );
      result.fold(
        (failure) => emit(FindLookupError(failure: failure)),
        (lookups) => emit(FindLookupDone(lookups: lookups)),
      );
    });

    on<FindLookupWithParent>((event, emit) async {
      emit(const FindLookupLoading());
      final result = await find(key: (key: event.lookup, parent: event.parent));
      result.fold(
        (failure) => emit(FindLookupError(failure: failure)),
        (lookups) => emit(FindLookupDone(lookups: lookups)),
      );
    });

    on<SearchLookup>((event, emit) async {
      emit(const FindLookupLoading());
      final result = await search(
        query: event.query,
        key: (key: event.lookup, parent: null),
      );
      result.fold(
        (failure) => emit(FindLookupError(failure: failure)),
        (lookups) => emit(FindLookupDone(lookups: lookups)),
      );
    });

    on<SearchLookupWithParent>((event, emit) async {
      emit(const FindLookupLoading());
      final result = await search(
        query: event.query,
        key: (key: event.lookup, parent: event.parent),
      );
      result.fold(
        (failure) => emit(FindLookupError(failure: failure)),
        (lookups) => emit(FindLookupDone(lookups: lookups)),
      );
    });
  }
}

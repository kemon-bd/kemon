import '../shared.dart' hide TokenModelExtension;

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ToggleTheme>((event, emit) {
      final newTheme = state.copyWith(
          mode:
              state.mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
      emit(newTheme);
    });
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return const ThemeState();
    }
    return ThemeState.parse(map: json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}

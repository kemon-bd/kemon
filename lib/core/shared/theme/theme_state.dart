part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeMode mode;
  const ThemeState({
    this.mode = ThemeMode.light,
  });

  @override
  List<Object> get props => [mode];

  factory ThemeState.parse({
    required Map<String, dynamic> map,
  }) {
    return ThemeState(
      mode: ThemeMode.values[map['mode']],
    );
  }
}

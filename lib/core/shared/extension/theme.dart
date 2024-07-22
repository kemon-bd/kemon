import '../shared.dart';

extension ThemeExtension on ThemeState {
  ThemeState copyWith({
    ThemeMode? mode,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mode': mode.index,
    };
  }

  ThemeScheme get scheme {
    return mode == ThemeMode.dark ? ThemeScheme.dark() : ThemeScheme.light();
  }
}

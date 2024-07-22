import '../shared.dart';

class ThemeScheme {
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundTertiary;
  final Color textPrimary;
  final Color textSecondary;
  final Color positive;
  final Color positiveBackground;
  final Color positiveBackgroundSecondary;
  final Color positiveBackgroundTertiary;
  final Color primary;
  final Color negative;
  final Color warning;
  final Color shimmer;

  ThemeScheme({
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.textPrimary,
    required this.textSecondary,
    required this.primary,
    required this.positive,
    required this.positiveBackground,
    required this.positiveBackgroundSecondary,
    required this.positiveBackgroundTertiary,
    required this.negative,
    required this.warning,
    required this.shimmer,
  });

  factory ThemeScheme.light() {
    final theme = ThemeScheme(
      backgroundPrimary: const Color(0xFFffffff),
      backgroundSecondary: const Color(0xFFf5f3f4),
      backgroundTertiary: const Color(0xFFd3d3d3),
      textPrimary: const Color(0xFF020202),
      textSecondary: const Color(0xFF6c757d),
      primary: const Color(0xFF058c42),
      positive: const Color(0xFF058c42),
      positiveBackground: const Color(0xFFd8f3dc),
      positiveBackgroundSecondary: const Color(0xFFb7e4c7),
      positiveBackgroundTertiary: const Color(0xFF95d5b2),
      negative: const Color(0xFFe41749),
      warning: const Color(0xFFff8000),
      shimmer: const Color(0xFFf4f4f9),
    );

    return theme;
  }

  factory ThemeScheme.dark() {
    final theme = ThemeScheme(
      backgroundPrimary: const Color(0xFF020202),
      backgroundSecondary: const Color(0xFF171717),
      backgroundTertiary: const Color(0xFF2d2926),
      textPrimary: const Color(0xFFe9ecef),
      textSecondary: const Color(0xFF6c757d),
      primary: const Color(0xFF058c42),
      positive: const Color(0xFF058c42),
      positiveBackground: const Color(0xFF2f3e46),
      positiveBackgroundSecondary: const Color(0xFF354f52),
      positiveBackgroundTertiary: const Color(0xFF52796f),
      negative: const Color(0xFFfd0054),
      warning: const Color(0xFFff8000),
      shimmer: const Color(0xFFf4f4f9),
    );

    return theme;
  }
}

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
  final Color white = Colors.white;
  final Color semiWhite = Colors.white60;
  final Color semiBlack = Colors.black26;

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
      textSecondary: const Color(0xFF474747),
      primary: const Color(0xFF2BB673),
      positive: const Color(0xFF058c42),
      positiveBackground: const Color(0xFFeefbf5),
      positiveBackgroundSecondary: const Color(0xFFdef7eb),
      positiveBackgroundTertiary: const Color(0xFFcdf3e1),
      negative: const Color(0xFFe41749),
      warning: const Color(0xFFff8000),
      shimmer: const Color(0xFFf4f4f9),
    );

    return theme;
  }

  factory ThemeScheme.dark() {
    final theme = ThemeScheme(
      backgroundPrimary: const Color(0xFF000000),
      backgroundSecondary: const Color(0xFF141414),
      backgroundTertiary: const Color(0xFF1F1F1F),
      textPrimary: const Color(0xFFe9ecef),
      textSecondary: const Color(0xFFc2c2c2),
      primary: const Color(0xFF2BB673),
      positive: const Color(0xFF058c42),
      positiveBackground: const Color(0xFF04110a),
      positiveBackgroundSecondary: const Color(0xFF082115),
      positiveBackgroundTertiary: const Color(0xFF04110a),
      negative: const Color(0xFFfd0054),
      warning: const Color(0xFFff8000),
      shimmer: const Color(0xFFf4f4f9),
    );

    return theme;
  }
}

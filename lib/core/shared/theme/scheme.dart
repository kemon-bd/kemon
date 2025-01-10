import '../shared.dart';

class ThemeScheme {
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundTertiary;
  final Color textPrimary;
  final Color textSecondary;
  final Color link;
  final Color positive;
  final Color positiveBackground;
  final Color positiveBackgroundSecondary;
  final Color positiveBackgroundTertiary;
  final Color primary = const Color(0xFF0DA574); // base: 2BB673
  final Color facebook = const Color(0xFF316FF6); // base: 2BB673
  final Color google = const Color(0xFFDB4437); // base: 2BB673
  final Color negative;
  final Color warning;
  final Color shimmer;
  final Color white = Colors.white;
  final Color semiWhite = Colors.white60;
  final Color semiBlack = Colors.black26;
  final Color black = Colors.black;

  ThemeScheme({
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.textPrimary,
    required this.textSecondary,
    required this.link,
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
      backgroundPrimary: const Color(0xFFfafaff),
      backgroundSecondary: const Color(0xFFeef0f2),
      backgroundTertiary: const Color(0xFFdaddd8),
      textPrimary: const Color(0xFF1c1c1c),
      textSecondary: const Color(0xFF66666e),
      positive: const Color(0xFF058c42),
      link: Colors.lightBlueAccent.shade700,
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
      link: Colors.cyanAccent.shade400,
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

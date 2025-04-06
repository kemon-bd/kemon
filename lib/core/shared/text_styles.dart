import 'shared.dart';

class TextStyles {
  static TextStyle overline({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
            fontSize: 10,
            letterSpacing: 0.15,
          ),
    );
  }

  static TextStyle caption({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
            fontSize: 12,
            letterSpacing: 0,
          ),
    );
  }

  static TextStyle button({
    required BuildContext context,
  }) {
    final theme = context.theme.scheme;
    return GoogleFonts.solway(
      color: theme.white,
      textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: theme.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1.25,
          ),
    );
  }

  static TextStyle body({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.normal,
            fontSize: 14,
            letterSpacing: 0.25,
          ),
    );
  }

  static TextStyle subTitle({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.normal,
            fontSize: 20,
            letterSpacing: 0,
          ),
    );
  }

  static TextStyle title({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.normal,
            fontSize: 28,
            letterSpacing: -1.5,
          ),
    );
  }
}

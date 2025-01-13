import 'shared.dart';

class TextStyles {

  static TextStyle overline({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
            fontSize: 21.sp,
            letterSpacing: 0.15.sp,
          ),
    );
  }

  static TextStyle caption({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
            fontSize: 26.sp,
            letterSpacing: 0.sp,
          ),
    );
  }

  static TextStyle button({
    required BuildContext context,
  }) {
    final theme = context.theme.scheme;
    return GoogleFonts.solway(
      color: theme.white,
      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: theme.black,
            fontWeight: FontWeight.bold,
            fontSize: 51.sp,
            letterSpacing: 1.25.sp,
          ),
    );
  }

  static TextStyle body({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.normal,
            fontSize: 36.sp,
            letterSpacing: 0.25.sp,
          ),
    );
  }

  static TextStyle subTitle({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.normal,
            fontSize: 51.sp,
            letterSpacing: 0.sp,
          ),
    );
  }

  static TextStyle title({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.w100,
            fontSize: 103.sp,
            letterSpacing: -1.5.sp,
          ),
    );
  }
}

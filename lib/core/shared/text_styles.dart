import 'shared.dart';

class TextStyles {
  static TextStyle overline({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.normal,
            fontSize: 11.sp,
            letterSpacing: 1.5.sp,
          ),
    );
  }

  static TextStyle body1({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.normal,
            fontSize: 17.sp,
            letterSpacing: 0.5.sp,
          ),
    );
  }

  static TextStyle body2({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.normal,
            fontSize: 15.sp,
            letterSpacing: 0.25.sp,
          ),
    );
  }

  static TextStyle subTitle1({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.normal,
            fontSize: 17.sp,
            letterSpacing: 0.15.sp,
          ),
    );
  }

  static TextStyle subTitle2({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
            letterSpacing: 0.1.sp,
          ),
    );
  }

  static TextStyle h6({
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
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
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

  static TextStyle h2({
    required BuildContext context,
    required Color color,
  }) {
    return GoogleFonts.solway(
      textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.w100,
            fontSize: 64.sp,
            letterSpacing: -0.5.sp,
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

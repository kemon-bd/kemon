import '../shared/shared.dart';
//! mason:linking-imports - DO NOT REMOVE THIS COMMENT --------------------------->
import '../../features/analytics/analytics.dart';
import '../../features/leaderboard/leaderboard.dart';
import '../../features/registration/registration.dart';
import '../../features/search/search.dart';
import '../../features/review/review.dart';
import '../../features/business/business.dart';
import '../../features/location/location.dart';
import '../../features/lookup/lookup.dart';
import '../../features/sub_category/sub_category.dart';
import '../../features/category/category.dart';
import '../../features/industry/industry.dart';
import '../../features/profile/profile.dart';
import '../../features/login/login.dart';
import '../../features/authentication/authentication.dart';

part 'dependencies.dart';
part 'network_certificates.dart';
//! mason:linking-dependencies - DO NOT REMOVE THIS COMMENT ---------------------->
part 'dependencies/analytics.dart';
part 'dependencies/leaderboard.dart';
part 'dependencies/registration.dart';
part 'dependencies/search.dart';
part 'dependencies/review.dart';
part 'dependencies/business.dart';
part 'dependencies/location.dart';
part 'dependencies/lookup.dart';
part 'dependencies/sub_category.dart';
part 'dependencies/category.dart';
part 'dependencies/industry.dart';
part 'dependencies/profile.dart';
part 'dependencies/login.dart';
part 'dependencies/authentication.dart';

class AppConfig {
  static FutureOr<void> init() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    // Bypass the SSL certificate verification
    HttpOverrides.global = MyHttpOverrides();

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );

    // Initialize the configurations
    await _setupDependencies();

    // Firebase Messaging
    await setupFirebaseMessaging();

    await ScreenUtil.ensureScreenSize();
  }

  static ThemeData themeData({
    required BuildContext context,
    required ThemeMode mode,
  }) {
    final ThemeScheme theme = mode != ThemeMode.dark ? ThemeScheme.light() : ThemeScheme.dark();
    return ThemeData(
      canvasColor: theme.backgroundPrimary,
      scaffoldBackgroundColor: theme.backgroundPrimary,
      splashFactory: InkRipple.splashFactory,
      primaryColor: theme.primary,
      indicatorColor: theme.primary,
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: theme.backgroundSecondary,
        labelStyle: TextStyles.body(context: context, color: theme.textPrimary),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dimension.padding.horizontal.max,
          vertical: Dimension.padding.vertical.max,
        ),
        hintStyle: TextStyles.body(context: context, color: theme.textSecondary),
        errorStyle: TextStyle(height: 0, fontSize: 0),
        helperStyle: TextStyle(height: 0, fontSize: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
          borderSide: BorderSide(
            color: theme.negative.withAlpha(50),
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
          borderSide: BorderSide(
            color: theme.negative,
            width: Dimension.size.horizontal.one,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
            side: BorderSide(
              color: theme.textSecondary.withAlpha(150),
              width: Dimension.padding.horizontal.min,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Dimension.padding.horizontal.max,
            vertical: Dimension.padding.vertical.large,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          elevation: Dimension.radius.three,
          backgroundColor: theme.backgroundPrimary,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          padding: EdgeInsets.symmetric(
            horizontal: Dimension.padding.horizontal.max,
            vertical: Dimension.padding.vertical.large,
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: theme.textPrimary),
      iconTheme: IconThemeData(color: theme.textPrimary, size: Dimension.radius.twenty),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dividerTheme: DividerThemeData(
        space: Dimension.divider.normal,
        color: theme.backgroundTertiary,
        thickness: Dimension.divider.normal,
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: theme.textPrimary),
        titleSpacing: 0,
        actionsIconTheme: IconThemeData(color: theme.textPrimary),
        backgroundColor: theme.backgroundPrimary,
        surfaceTintColor: theme.backgroundPrimary,
        foregroundColor: theme.backgroundPrimary,
        elevation: 0,
        systemOverlayStyle: (mode != ThemeMode.dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light).copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: theme.primary,
        primary: theme.primary,
        brightness: mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
      ),
      useMaterial3: true,
    );
  }
}

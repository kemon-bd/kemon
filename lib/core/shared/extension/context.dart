import '../../../features/authentication/authentication.dart';
import '../../../features/business/business.dart';
import '../shared.dart';

extension BuildContextExtension on BuildContext {
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  double get topInset => MediaQuery.of(this).padding.top;

  double get bottomInset => MediaQuery.of(this).padding.bottom;

  double get smallestSide => MediaQuery.of(this).size.shortestSide;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  void successNotification({
    required String message,
  }) {
    final scheme = theme.scheme;
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyles.body(context: this, color: scheme.white),
      ),
      backgroundColor: scheme.positive,
    );
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void errorNotification({
    required String message,
  }) {
    final scheme = theme.scheme;
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyles.body(context: this, color: scheme.white),
      ),
      backgroundColor: scheme.negative,
    );
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void warningNotification({
    required String message,
  }) {
    final scheme = theme.scheme;
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyles.body(context: this, color: scheme.white),
      ),
      backgroundColor: scheme.warning,
    );
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Color get barrierColor {
    final darkMode = theme.mode == ThemeMode.dark;
    return theme.scheme.textPrimary.withAlpha(darkMode ? 150 : 125);
  }

  TextTheme get text => Theme.of(this).textTheme;
  ThemeState get theme => this.read<ThemeBloc>().state;

  AuthenticationBloc get auth => this.read<AuthenticationBloc>();
  FindBusinessBloc get businessBloc => this.read<FindBusinessBloc>();
  FindBusinessState get businessState => businessBloc.state;
  BusinessEntity get business => (businessState as FindBusinessDone).business;

  void dismissKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }
}

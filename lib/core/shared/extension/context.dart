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

  ScaffoldMessengerState successNotification({
    required String message,
  }) {
    final scheme = theme.scheme;
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyles.body(context: this, color: scheme.backgroundPrimary),
      ),
      backgroundColor: scheme.positive,
    );
    return ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  ScaffoldMessengerState errorNotification({
    required String message,
  }) {
    final scheme = theme.scheme;
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyles.body(context: this, color: scheme.backgroundPrimary),
      ),
      backgroundColor: scheme.negative,
    );
    return ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar)
      ..build(this);
  }

  ScaffoldMessengerState warningNotification({
    required String message,
  }) {
    final scheme = theme.scheme;
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyles.body(context: this, color: scheme.backgroundPrimary),
      ),
      backgroundColor: scheme.warning,
    );
    return ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Color get barrierColor {
    return theme.scheme.textPrimary.withOpacity(theme.mode == ThemeMode.dark ? .1 : .5);
  }

  ThemeState get theme => this.read<ThemeBloc>().state;

  AuthenticationBloc get auth => this.read<AuthenticationBloc>();
  FindBusinessBloc get businessBloc => this.read<FindBusinessBloc>();
  FindBusinessState get businessState => businessBloc.state;
  BusinessEntity get business => (businessState as FindBusinessDone).business;
}

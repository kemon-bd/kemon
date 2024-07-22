import '../../../features/authentication/authentication.dart';
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
    final scheme = theme.state.scheme;
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
    final scheme = theme.state.scheme;
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
    final scheme = theme.state.scheme;
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
    return theme.state.scheme.textPrimary
        .withOpacity(theme.state.mode == ThemeMode.dark ? .1 : .5);
  }

  ThemeBloc get theme => this.read<ThemeBloc>();

  AuthenticationBloc get auth => this.read<AuthenticationBloc>();
}

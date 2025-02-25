import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../profile.dart';

class ChangePasswordPage extends StatefulWidget {
  static const String path = '/change-password';
  static const String name = 'ChangePasswordPage';
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool verified = false;
  late final VerifyOtpForChangePasswordWidget verification;
  final ResetMyPasswordWidget reset = ResetMyPasswordWidget();

  @override
  void initState() {
    super.initState();
    verification = VerifyOtpForChangePasswordWidget(
      onVerified: () {
        setState(() {
          verified = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(HomePage.name);
                }
              },
              icon: Icon(Icons.arrow_back, color: theme.textPrimary),
            ),
          ),
          body: verified ? reset : verification,
        );
      },
    );
  }
}

import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../login.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String path = '/forgot-password';
  static const String name = 'ForgotPasswordPage';
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool verified = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                        if(context.canPop()) {
                          context.pop();
                        } else {
                          context.goNamed(HomePage.name);
                        }
                      },
              icon: Icon(Icons.arrow_back, color: theme.textPrimary),
            ),
          ),
          body: ForgotPasswordPickUsernameWidget(
            onUsernameSelected: (username) => verified
                ? ResetPasswordWidget(username: username).animate().fade()
                : VerifyOtpForForgotPasswordWidget(
                    username: username,
                    onVerified: () {
                      setState(() {
                        verified = true;
                      });
                    },
                  ).animate().fade(),
          ),
        );
      },
    );
  }
}

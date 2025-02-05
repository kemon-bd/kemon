import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class VerifyPhoneButton extends StatelessWidget {
  final TextEditingController phone;
  const VerifyPhoneButton({
    super.key,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return IconButton(
      padding: EdgeInsets.all(0),
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      onPressed: () async {
        if (!phone.validPhone) {
          context.warningNotification(message: "Invalid phone address");
          return;
        }
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (_) => VerificationConfirmationWidget(affirm: 'Continue'),
        );

        if (!(confirmed ?? false)) return;
        if (!context.mounted) return;

        final verified = await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          barrierColor: context.barrierColor,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => sl<RequestOtpForPasswordChangeBloc>()
                  ..add(
                    RequestOtpForPhoneOrEmailVerification(
                      username: phone.text,
                    ),
                  ),
              ),
              BlocProvider(create: (_) => sl<UpdateProfileBloc>()),
            ],
            child: Padding(
              padding: context.viewInsets,
              child: VerifyPhoneOrEmailWidget(
                username: phone.text,
              ),
            ),
          ),
        );
        if (!(verified ?? true)) return;
        if (!context.mounted) return;
        context.read<FindProfileBloc>().add(RefreshProfile(identity: context.auth.profile!.identity));
      },
      icon: Icon(Icons.verified_outlined, color: theme.link),
    );
  }
}

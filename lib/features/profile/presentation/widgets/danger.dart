import 'package:kemon/features/profile/presentation/pages/deactivate.dart';

import '../../../../../core/shared/shared.dart';
import '../../../../core/config/config.dart';
import '../../../authentication/authentication.dart';
import '../../profile.dart';

class ProfileDangerZoneWidget extends StatelessWidget {
  const ProfileDangerZoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Text(
              'Danger Zone',
              style: TextStyles.subTitle(context: context, color: theme.negative),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: theme.negative.withAlpha(15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.negative, width: .5),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.antiAlias,
                children: [
                  BlocProvider(
                    create: (context) => sl<DeactivateAccountBloc>(),
                    child: BlocConsumer<DeactivateAccountBloc, DeactivateAccountState>(
                      listener: (context, state) {
                        if (state is DeactivateAccountOtp) {
                          context.pushNamed(
                            DeactivateAccountPage.name,
                            queryParameters: {
                              'otp': state.otp,
                            },
                          );
                        }
                      },
                      builder: (deactivateContext, state) {
                        return ListTile(
                          leading: const CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.deepPurple,
                            child: Icon(Icons.block_rounded, color: Colors.white, size: 16),
                          ),
                          title: Text(
                            'Deactivate account',
                            style: TextStyles.title(context: context, color: Colors.deepPurple),
                          ),
                          trailing: state is DeactivateAccountLoading
                              ? const NetworkingIndicator(dimension: 16, color: Colors.deepPurple)
                              : const Icon(Icons.open_in_new_rounded, color: Colors.deepPurple, size: 16),
                          onTap: () {
                            deactivateContext.read<DeactivateAccountBloc>().add(GenerateOtpForAccountDeactivation());
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        );
                      },
                    ),
                  ),
                  Divider(height: .25, thickness: .25, color: theme.negative),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 16,
                      backgroundColor: theme.negative,
                      child: Icon(Icons.logout_rounded, color: theme.white, size: 16),
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyles.title(context: context, color: theme.negative),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_rounded, size: 12, color: theme.negative),
                    onTap: () {
                      context.read<AuthenticationBloc>().add(const AuthenticationLogout());
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

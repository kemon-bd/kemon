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
          padding: EdgeInsets.all(Dimension.radius.sixteen),
          physics: const NeverScrollableScrollPhysics(),
          clipBehavior: Clip.antiAlias,
          children: [
            Text(
              'Danger Zone',
              style: context.text.labelMedium?.copyWith(
                color: theme.negative,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
            SizedBox(height: Dimension.padding.vertical.medium),
            Container(
              decoration: BoxDecoration(
                color: theme.negative.withAlpha(15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.negative, width: .5),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: Dimension.padding.vertical.small),
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.antiAlias,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: Dimension.radius.sixteen,
                      backgroundColor: theme.textPrimary,
                      child: Icon(Icons.block_rounded, color: theme.backgroundPrimary, size: Dimension.radius.sixteen),
                    ),
                    title: Text(
                      'Blocked accounts',
                      style: context.text.titleMedium?.copyWith(
                        color: theme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(Icons.open_in_new_rounded, color: theme.textPrimary, size: Dimension.radius.sixteen),
                    onTap: () {
                      context.pushNamed(
                        BlockedAccountsPage.name,
                        pathParameters: {
                          'user': context.auth.identity?.guid ?? '',
                        },
                      );
                    },
                  ),
                  Divider(height: Dimension.padding.vertical.small, thickness: .5, color: theme.negative),
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
                          leading: CircleAvatar(
                            radius: Dimension.radius.sixteen,
                            backgroundColor: Colors.deepPurple,
                            child: Icon(Icons.visibility_off_rounded, color: theme.white, size: Dimension.radius.sixteen),
                          ),
                          title: Text(
                            'Deactivate account',
                            style: context.text.titleMedium?.copyWith(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: state is DeactivateAccountLoading
                              ? NetworkingIndicator(dimension: Dimension.radius.sixteen, color: Colors.deepPurple)
                              : Icon(Icons.open_in_new_rounded, color: Colors.deepPurple, size: Dimension.radius.sixteen),
                          onTap: () async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (_) => DeleteConfirmationWidget(affirm: 'Yes, Deactivate'),
                            );
                            if (!(confirmed ?? false)) return;
                            if (!context.mounted) return;
                            deactivateContext.read<DeactivateAccountBloc>().add(GenerateOtpForAccountDeactivation());
                          },
                        );
                      },
                    ),
                  ),
                  Divider(height: Dimension.padding.vertical.small, thickness: .5, color: theme.negative),
                  ListTile(
                    leading: CircleAvatar(
                      radius: Dimension.radius.sixteen,
                      backgroundColor: theme.negative,
                      child: Icon(Icons.logout_rounded, color: theme.white, size: Dimension.radius.sixteen),
                    ),
                    title: Text(
                      'Logout',
                      style: context.text.titleMedium?.copyWith(
                        color: theme.negative,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_rounded, size: Dimension.radius.sixteen, color: theme.negative),
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

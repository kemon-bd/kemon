import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../../home/home.dart';
import '../../profile.dart';

class ProfilePage extends StatelessWidget {
  static const String path = '/profile';
  static const String name = 'ProfilePage';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.profile == null) {
              context.goNamed(HomePage.name);
            }
          },
          child: Scaffold(
            backgroundColor: theme.backgroundPrimary,
            appBar: AppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: theme.primary,
              surfaceTintColor: theme.primary,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded, color: theme.white),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.goNamed(HomePage.name);
                  }
                },
              ),
              title: BlocBuilder<FindProfileBloc, FindProfileState>(
                builder: (context, state) {
                  if (state is FindProfileDone) {
                    return Text(
                      state.profile.kemonIdentity.username,
                      style: context.text.titleMedium?.copyWith(
                        color: theme.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else if (state is FindProfileLoading) {
                    return Align(
                      alignment: Alignment.center,
                      child: const ShimmerLabel(width: 112, height: 12, radius: 12),
                    );
                  }
                  return Container();
                },
              ),
              titleSpacing: 0,
              actions: [
                IconButton(
                  icon: Icon(Icons.logout_rounded, color: theme.white),
                  onPressed: () => context.read<AuthenticationBloc>().add(const AuthenticationLogout()),
                ),
              ],
              centerTitle: true,
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<FindProfileBloc>().add(RefreshProfile(identity: context.auth.identity!));
              },
              child: ListView(
                shrinkWrap: false,
                padding: EdgeInsets.zero.copyWith(
                  bottom: context.bottomInset + 16,
                ),
                children: const [
                  ProfileInformationWidget(edit: true),
                  ProfileProgressWidget(),
                  ProfileFeatureOptionsWidget(),
                  ProfilePreferenceWidget(),
                  ProfileDangerZoneWidget(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

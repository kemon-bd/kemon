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
                onPressed: context.pop,
              ),
              title: MyProfileUsernameWidget(
                shimmerAlignment: Alignment.center,
                style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
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
            body: ListView(
              shrinkWrap: false,
              padding: EdgeInsets.zero,
              children: const [
                ProfileInformationWidget(edit: true),
                ProfileFeatureOptionsWidget(),
                ProfilePreferenceWidget(),
                ProfileDangerZoneWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}

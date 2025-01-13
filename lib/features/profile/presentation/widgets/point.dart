import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../profile.dart';

class ProfilePointWidget extends StatelessWidget {
  final TextStyle? style;

  const ProfilePointWidget({super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<FindProfileBloc, FindProfileState>(
          builder: (context, state) {
            if (state is FindProfileDone) {
              return Text(
                state.profile.kemonIdentity.point.toString(),
                style: style ??
                    TextStyles.subTitle1(
                        context: context, color: theme.textPrimary),
              );
            } else if (state is FindProfileLoading) {
              return const ShimmerLabel(width: 112, height: 12, radius: 12);
            }
            return Container();
          },
        );
      },
    );
  }
}

class MyProfilePointWidget extends StatelessWidget {
  final TextStyle? style;
  const MyProfilePointWidget({super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final profile = state.profile;
        if (profile != null) {
          return BlocProvider(
            create: (context) => sl<FindProfileBloc>()
              ..add(FindProfile(identity: profile.identity)),
            child: ProfilePointWidget(style: style),
          );
        }
        return Container();
      },
    );
  }
}

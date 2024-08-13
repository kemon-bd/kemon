import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../profile.dart';

class ProfileUsernameWidget extends StatelessWidget {
  final TextStyle? style;
  final TextAlign? align;
  final Alignment? shimmerAlignment;

  const ProfileUsernameWidget({
    super.key,
    this.style,
    this.align,
    this.shimmerAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<FindProfileBloc, FindProfileState>(
          builder: (context, state) {
            if (state is FindProfileDone) {
              return Text(
                state.profile.kemonIdentity.username,
                style: style ?? TextStyles.subTitle(context: context, color: theme.textPrimary),
                textAlign: align,
              );
            } else if (state is FindProfileLoading) {
              return Align(
                alignment: shimmerAlignment ?? Alignment.centerLeft,
                child: const ShimmerLabel(width: 112, height: 12, radius: 12),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}

class MyProfileUsernameWidget extends StatelessWidget {
  final Alignment? shimmerAlignment;
  final TextStyle? style;
  const MyProfileUsernameWidget({
    super.key,
    this.style,
    this.shimmerAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final profile = state.profile;
        if (profile != null) {
          return BlocProvider(
            create: (context) => sl<FindProfileBloc>()..add(FindProfile(identity: profile.identity)),
            child: ProfileUsernameWidget(style: style, shimmerAlignment: shimmerAlignment),
          );
        }
        return Container();
      },
    );
  }
}

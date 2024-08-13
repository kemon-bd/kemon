import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../profile.dart';

class ProfileSinceWidget extends StatelessWidget {
  final TextStyle? style;
  final TextAlign? align;
  final Alignment? shimmerAlignment;

  const ProfileSinceWidget({
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
                'Joined on: ${state.profile.memberSince.dMMMMyyyy}.',
                style: style ?? TextStyles.caption(context: context, color: theme.textPrimary),
                textAlign: align,
              );
            } else if (state is FindProfileLoading) {
              return Align(
                alignment: shimmerAlignment ?? Alignment.centerLeft,
                child: const ShimmerLabel(width: 84, height: 8, radius: 12),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}

class MyPublicSinceWidget extends StatelessWidget {
  final TextStyle? style;
  const MyPublicSinceWidget({super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final profile = state.profile;
        if (profile != null) {
          return BlocProvider(
            create: (context) => sl<FindProfileBloc>()..add(FindProfile(identity: profile.identity)),
            child: ProfileSinceWidget(style: style),
          );
        }
        return Container();
      },
    );
  }
}

import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../profile.dart';

class ProfileNameWidget extends StatelessWidget {
  final TextStyle? style;
  final TextAlign? align;

  const ProfileNameWidget({
    super.key,
    this.style,
    this.align,
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
                state.profile.name.full,
                style: style ?? TextStyles.subTitle(context: context, color: theme.textPrimary),
                textAlign: align,
              );
            } else if (state is FindProfileLoading) {
              return const Align(
                alignment: Alignment.centerLeft,
                child: ShimmerLabel(width: 112, height: 12, radius: 12),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}

class MyProfileNameWidget extends StatelessWidget {
  final TextStyle? style;
  final TextAlign? align;
  const MyProfileNameWidget({
    super.key,
    this.style,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final profile = state.profile;
        if (profile != null) {
          return BlocProvider(
            create: (context) => sl<FindProfileBloc>()..add(FindProfile(identity: profile.identity)),
            child: ProfileNameWidget(style: style, align: align),
          );
        }
        return Container();
      },
    );
  }
}

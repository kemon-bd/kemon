import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../profile.dart';

class ProfilePictureWidget extends StatelessWidget {
  final double size;
  final Color? backgroundColor;
  final double border;
  final Color? borderColor;
  final VoidCallback? onTap;

  const ProfilePictureWidget({
    super.key,
    this.size = 20,
    this.border = 0,
    this.borderColor,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(size),
          child: BlocBuilder<FindProfileBloc, FindProfileState>(
            builder: (context, state) {
              if (state is FindProfileDone) {
                final url = state.profile.profilePicture ?? '';
                return Container(
                  decoration: BoxDecoration(
                    color: backgroundColor ?? theme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: borderColor ?? Colors.transparent,
                      width: border,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  clipBehavior: Clip.none,
                  child: CachedNetworkImage(
                    imageUrl: url,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => ShimmerIcon(radius: size),
                    errorWidget: (_, __, ___) => Center(
                      child: Text(
                        state.profile.name.symbol,
                        style: TextStyles.body(context: context, color: theme.white).copyWith(
                          fontSize: size / 2,
                        ),
                      ),
                    ),
                  ),
                );
              } else if (state is FindProfileLoading) {
                return ShimmerIcon(radius: size);
              }
              return Icon(
                Icons.account_circle_outlined,
                size: size,
                color: theme.textPrimary,
              );
            },
          ),
        );
      },
    );
  }
}

class MyProfilePictureWidget extends StatelessWidget {
  final bool showWhenUnAuthorized;
  final double size;
  final Color? backgroundColor;
  final Color? borderColor;
  final double border;
  final VoidCallback? onTap;
  const MyProfilePictureWidget({
    super.key,
    this.showWhenUnAuthorized = false,
    this.size = 20,
    this.border = 0,
    this.backgroundColor,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final profile = state.profile;
        final theme = context.theme.scheme;
        if (profile != null) {
          return BlocProvider(
            create: (context) => sl<FindProfileBloc>()..add(FindProfile(identity: profile.identity)),
            child: ProfilePictureWidget(
              size: size,
              backgroundColor: backgroundColor,
              borderColor: borderColor,
              border: border,
              onTap: onTap,
            ),
          );
        } else if (showWhenUnAuthorized) {
          return Icon(
            Icons.account_circle_outlined,
            size: size,
            color: theme.textPrimary,
          );
        }
        return Container();
      },
    );
  }
}

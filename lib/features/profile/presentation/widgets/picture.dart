import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../profile.dart';

class ProfilePictureWidget extends StatelessWidget {
  final double size;
  final Color? backgroundColor;
  final Color? placeholderColor;
  final double border;
  final Color? borderColor;
  final VoidCallback? onTap;
  final bool showFlare;
  final bool showBadge;

  const ProfilePictureWidget({
    super.key,
    this.size = 20,
    this.border = 0,
    this.borderColor,
    this.backgroundColor,
    this.placeholderColor,
    this.onTap,
    this.showFlare = false,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final avatar = Center(
          child: Icon(
            Icons.account_circle_outlined,
            size: size,
            color: theme.textPrimary,
          ),
        );
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(size),
          child: BlocBuilder<FindProfileBloc, FindProfileState>(
            builder: (context, state) {
              if (state is FindProfileDone) {
                final url = state.profile.profilePicture?.url ?? '';
                final fallback = Center(
                  child: Text(
                    state.profile.name.symbol,
                    style: TextStyles.body(context: context, color: placeholderColor ?? theme.white).copyWith(
                      fontSize: size / 2,
                    ),
                  ),
                );
                final child = Container(
                  decoration: BoxDecoration(
                    color: backgroundColor ?? theme.primary,
                    borderRadius: BorderRadius.circular(size),
                    border: Border.all(
                      color: borderColor ?? Colors.transparent,
                      width: border,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: url.isEmpty
                      ? fallback
                      : CachedNetworkImage(
                          imageUrl: url,
                          width: size,
                          height: size,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => ShimmerIcon(radius: size),
                          errorWidget: (_, __, ___) => fallback,
                        ),
                );
                return Center(
                  child: SizedBox(
                    width: size,
                    height: size,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        showFlare
                            ? child
                                .animate(
                                  onComplete: (controller) => controller.repeat(reverse: true),
                                )
                                .boxShadow(
                                  borderRadius: BorderRadius.circular(size),
                                  duration: 3.seconds,
                                  begin: BoxShadow(
                                    color: theme.white,
                                    spreadRadius: border * 3,
                                    blurRadius: border * 3,
                                  ),
                                  end: BoxShadow(
                                    color: theme.semiWhite,
                                    spreadRadius: border,
                                    blurRadius: border,
                                  ),
                                )
                            : child,
                        if (showFlare)
                          Positioned(
                            bottom: -(border * 4),
                            left: 0,
                            right: 0,
                            child: Center(
                              child: PhysicalModel(
                                color: borderColor ?? theme.white,
                                borderRadius: BorderRadius.circular(size),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: border * 2, vertical: border * 2),
                                  child: Icon(
                                    Icons.verified_user_rounded,
                                    color: theme.primary,
                                    size: border * 4,
                                    weight: 700,
                                    grade: 200,
                                    fill: 1.0,
                                    opticalSize: border,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (showBadge)
                          Positioned(
                            bottom: -size * .2,
                            right: -size * .2,
                            child: Center(
                              child: PhysicalModel(
                                color: borderColor ?? theme.backgroundPrimary,
                                borderRadius: BorderRadius.circular(size),
                                child: Padding(
                                  padding: EdgeInsets.all(size * .05),
                                  child: Icon(
                                    Icons.verified_user_rounded,
                                    color: theme.primary,
                                    size: size * .5,
                                    weight: 700,
                                    grade: 200,
                                    fill: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              } else if (state is FindProfileLoading) {
                return ShimmerIcon(radius: size);
              }
              return avatar;
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
  final Color? placeholderColor;
  final Color? borderColor;
  final double border;
  final VoidCallback? onTap;
  const MyProfilePictureWidget({
    super.key,
    this.showWhenUnAuthorized = false,
    this.size = 20,
    this.border = 0,
    this.backgroundColor,
    this.placeholderColor,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          final profile = state.profile;
          final theme = context.theme.scheme;
          if (profile != null) {
            final url = profile.profilePicture?.url ?? '';
            final symbol = profile.name.symbol;
            final fallback = Center(
              child: Text(
                symbol,
                style: TextStyles.body(context: context, color: placeholderColor ?? theme.white).copyWith(
                  fontSize: size / 2,
                ),
              ),
            );
            return Center(
              child: SizedBox(
                width: size,
                height: size,
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColor ?? theme.primary,
                    borderRadius: BorderRadius.circular(size),
                    border: Border.all(
                      color: borderColor ?? Colors.transparent,
                      width: border,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: url.isEmpty
                      ? fallback
                      : CachedNetworkImage(
                          imageUrl: url,
                          width: size,
                          height: size,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => ShimmerIcon(radius: size),
                          errorWidget: (_, __, ___) => fallback,
                        ),
                ),
              ),
            );
          } else if (showWhenUnAuthorized) {
            return CircleAvatar(
              radius: size / 2,
              backgroundColor: theme.white,
              child: Icon(
                Icons.account_circle_outlined,
                size: size * .85,
                color: theme.primary,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

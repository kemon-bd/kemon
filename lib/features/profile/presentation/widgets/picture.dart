import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';


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

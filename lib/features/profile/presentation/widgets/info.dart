import '../../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';
import '../../profile.dart';

class ProfileInformationWidget extends StatelessWidget {
  final bool edit;
  const ProfileInformationWidget({
    super.key,
    this.edit = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final gradient = LinearGradient(
          colors: [
            theme.primary,
            theme.backgroundPrimary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
        return Container(
          decoration: BoxDecoration(
            gradient: gradient,
            image: const DecorationImage(
              image: AssetImage('images/logo/full.png'),
              opacity: .025,
              scale: 500,
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            children: [
              BlocBuilder<FindProfileBloc, FindProfileState>(
                builder: (context, state) {
                  if (state is FindProfileDone) {
                    return ProfilePointsBuilder(builder: (checks) {
                      return ProfilePictureWidget(
                        size: Dimension.radius.max,
                        backgroundColor: theme.positiveBackgroundSecondary,
                        placeholderColor: theme.primary,
                        border: Dimension.radius.four,
                        borderColor: theme.white,
                        showFlare: state.profile.progress(checks: checks) == 100,
                      );
                    });
                  }
                  return ProfilePictureWidget(
                    size: Dimension.radius.max,
                    backgroundColor: theme.positiveBackgroundSecondary,
                    placeholderColor: theme.primary,
                    border: Dimension.radius.four,
                    borderColor: theme.white,
                  );
                },
              ),
              const SizedBox(height: 16),
              ProfileNameWidget(
                align: TextAlign.center,
                style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                shimmerAlignment: Alignment.center,
              ),
              const SizedBox(height: 8),
              ProfileSinceWidget(
                style: TextStyles.body(context: context, color: theme.textSecondary),
                align: TextAlign.center,
                shimmerAlignment: Alignment.center,
              ),
              if (edit) ...[
                const SizedBox(height: 24),
                ActionChip(
                  elevation: 4,
                  side: BorderSide.none,
                  shadowColor: theme.semiWhite,
                  backgroundColor: theme.textPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  label: Text(
                    'Edit profile',
                    style: TextStyles.button(context: context).copyWith(
                      color: theme.backgroundPrimary,
                    ),
                  ),
                  onPressed: () async {
                    final identity = context.auth.identity!;
                    final bloc = context.read<FindProfileBloc>();
                    final bool? updated = await context.pushNamed(EditProfilePage.name);
                    if (updated ?? false) {
                      bloc.add(RefreshProfile(identity: identity));
                    }
                  },
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}

import '../../../../../core/shared/shared.dart';
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
          decoration: BoxDecoration(gradient: gradient),
          child: BlocBuilder<FindProfileBloc, FindProfileState>(
            builder: (context, state) {
              if (state is FindProfileDone) {
                final profile = state.profile;
                final url = profile.profilePicture?.url ?? '';
                final fallback = Center(
                  child: Text(
                    profile.name.symbol,
                    style: context.text.bodyLarge?.copyWith(color: theme.white),
                  ),
                );
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: theme.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.white,
                          width: 2,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: url.isEmpty
                          ? fallback
                          : InkWell(
                              onTap: () {
                                context.pushNamed(
                                  PhotoPreviewPage.name,
                                  pathParameters: {'url': url},
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: url,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => ShimmerIcon(radius: 100),
                                errorWidget: (_, __, ___) => fallback,
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      profile.name.full,
                      textAlign: TextAlign.center,
                      style: context.text.headlineMedium?.copyWith(
                        color: theme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Joined on: ${profile.memberSince.dMMMMyyyy}.',
                      style: context.text.bodySmall?.copyWith(color: theme.textSecondary),
                      textAlign: TextAlign.center,
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
                          'Edit profile'.toUpperCase(),
                          style: context.text.titleMedium?.copyWith(
                            color: theme.backgroundPrimary,
                            fontWeight: FontWeight.w900,
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
                );
              } else if (state is FindProfileLoading) {
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: ShimmerIcon(radius: 100),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: ShimmerLabel(
                        width: 144,
                        height: context.text.headlineMedium!.fontSize!,
                        radius: context.text.headlineMedium!.fontSize!,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.center,
                      child: ShimmerLabel(
                        width: 112,
                        height: context.text.bodySmall!.fontSize!,
                        radius: context.text.bodySmall!.fontSize!,
                      ),
                    ),
                    if (edit) ...[
                      const SizedBox(height: 24),
                      Align(alignment: Alignment.center, child: ShimmerLabel(width: 72, height: 54, radius: 100)),
                    ]
                  ],
                );
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}

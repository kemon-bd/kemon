import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../location.dart';

class FeaturedLocationsWidget extends StatelessWidget {
  const FeaturedLocationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<OverviewBloc, OverviewState>(
          builder: (_, state) {
            if (state is OverviewLoading) {
              return const FeaturedLocationsShimmerWidget();
            } else if (state is OverviewDone) {
              final locations = state.locations;
              return ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimension.padding.horizontal.max,
                  vertical: Dimension.padding.horizontal.max,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Locations",
                        style: TextStyles.body(context: context, color: theme.textSecondary),
                      ),
                      ActionChip(
                        label: Text(
                          "See all",
                          style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: theme.backgroundSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: const BorderSide(width: 0, color: Colors.transparent),
                        ),
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        onPressed: () async {
                          await sl<FirebaseAnalytics>().logEvent(
                            name: 'home_featured_locations_all',
                            parameters: {
                              'id': context.auth.profile?.identity.id ?? 'anonymous',
                              'name': context.auth.profile?.name.full ?? 'Guest',
                            },
                          );
                          if (!context.mounted) return;
                          context.pushNamed(LocationsPage.name);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: Dimension.padding.vertical.small),
                  SizedBox(
                    height: 120,
                    child: MasonryGridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: Dimension.padding.horizontal.max,
                      crossAxisSpacing: Dimension.padding.vertical.small,
                      padding: EdgeInsets.zero,
                      itemCount: locations.length,
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final location = locations.elementAt(index);
                        return InkWell(
                          borderRadius: BorderRadius.circular(Dimension.radius.max),
                          onTap: () async {
                            await sl<FirebaseAnalytics>().logEvent(
                              name: 'home_featured_locations_item',
                              parameters: {
                                'id': context.auth.profile?.identity.id ?? 'anonymous',
                                'name': context.auth.profile?.name.full ?? 'Guest',
                                'location': location.name.full,
                                'urlSlug': location.urlSlug,
                              },
                            );
                            if (!context.mounted) return;
                            context.pushNamed(
                              ThanaPage.name,
                              pathParameters: {
                                'division': location.division,
                                'district': location.district,
                                'thana': location.urlSlug,
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimension.radius.four),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: theme.backgroundTertiary,
                                  radius: Dimension.radius.ten,
                                  child: Icon(Icons.place_outlined, color: theme.textSecondary, size: Dimension.radius.ten),
                                ),
                                SizedBox(width: Dimension.padding.horizontal.small),
                                Text(
                                  location.name.full,
                                  style: TextStyles.body(context: context, color: theme.textPrimary),
                                ),
                                SizedBox(width: Dimension.padding.horizontal.small),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }
}

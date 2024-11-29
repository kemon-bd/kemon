import '../../../../core/shared/shared.dart';
import '../../location.dart';

class FeaturedLocationsWidget extends StatelessWidget {
  const FeaturedLocationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<FeaturedLocationsBloc, FeaturedLocationsState>(
          builder: (_, state) {
            if (state is FeaturedLocationsLoading) {
              return const FeaturedLocationsShimmerWidget();
            } else if (state is FeaturedLocationsDone) {
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
                        style: TextStyles.title(context: context, color: theme.textPrimary),
                      ),
                      ActionChip(
                        label: Text(
                          "See all",
                          style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        backgroundColor: theme.backgroundSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: const BorderSide(width: 0, color: Colors.transparent),
                        ),
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        onPressed: () {
                          context.pushNamed(LocationsPage.name);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: Dimension.padding.vertical.small),
                  SizedBox(
                    height: 400.h,
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
                          onTap: () {
                            context.pushNamed(
                              LocationPage.name,
                              pathParameters: {
                                'urlSlug': location.urlSlug,
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(Dimension.radius.four),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: theme.textPrimary,
                                  radius: Dimension.radius.twelve,
                                  child: Icon(Icons.layers_outlined, color: theme.white, size: Dimension.radius.twelve),
                                ),
                                SizedBox(width: Dimension.padding.horizontal.small),
                                Text(
                                  location.name.full,
                                  style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is FeaturedLocationsError) {
              return Center(
                child: Text(state.failure.message),
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

import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../../review/review.dart';
import '../../business.dart';

class FeaturedListingsWidget extends StatelessWidget {
  const FeaturedListingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<OverviewBloc, OverviewState>(
          builder: (_, state) {
            if (state is OverviewLoading) {
              return const FeaturedReviewsShimmerWidget();
            } else if (state is OverviewDone) {
              final businesses = state.businesses;
              return ListView(
                padding: EdgeInsets.symmetric(
                  vertical: Dimension.padding.vertical.max,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Dimension.padding.horizontal.max),
                    child: Text(
                      "Featured listings",
                      style: TextStyles.body(context: context, color: theme.textSecondary),
                    ),
                  ),
                  SizedBox(height: Dimension.padding.vertical.small),
                  if (businesses.isNotEmpty)
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: Dimension.size.horizontal.max,
                        maxHeight: Dimension.size.vertical.ninetyTwo+1,
                      ),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: Dimension.padding.horizontal.max),
                        separatorBuilder: (_, index) => SizedBox(width: Dimension.padding.horizontal.medium),
                        itemCount: businesses.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (_, index) => FeaturedBusinessItemWidget(business: businesses.elementAt(index)),
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

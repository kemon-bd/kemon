import '../../../../../core/shared/shared.dart';
import '../../../search.dart';

class DashboardSearchSectionWidget extends StatelessWidget {
  const DashboardSearchSectionWidget({super.key});

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
              image: CachedNetworkImageProvider(ExternalLinks.banner),
              fit: BoxFit.contain,
              alignment: Alignment.centerRight,
              opacity: .075,
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: Dimension.padding.horizontal.max,
              vertical: Dimension.padding.horizontal.max,
            ),
            children: [
              Text(
                "Trusted Reviews and Ratings Platform in Bangladesh",
                style: TextStyles.miniHeadline(
                        context: context, color: theme.semiBlack)
                    .copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Dimension.padding.horizontal.max),
              InkWell(
                onTap: () {
                  context.pushNamed(SearchPage.name);
                },
                borderRadius: BorderRadius.circular(Dimension.radius.max),
                child: PhysicalModel(
                  color: theme.backgroundPrimary,
                  elevation: Dimension.radius.three,
                  shadowColor: theme.positiveBackground,
                  borderRadius: BorderRadius.circular(Dimension.radius.max),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimension.padding.horizontal.small,
                      vertical: Dimension.padding.vertical.small,
                    ).copyWith(left: Dimension.padding.horizontal.max),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Company or category",
                            style: TextStyles.subTitle(
                              context: context,
                              color: theme.textSecondary.withAlpha(150),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimension.padding.horizontal.large,
                            vertical: Dimension.padding.vertical.large,
                          ),
                          decoration: BoxDecoration(
                            color: theme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.search,
                              color: theme.backgroundPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimension.padding.vertical.max),
            ],
          ),
        );
      },
    );
  }
}

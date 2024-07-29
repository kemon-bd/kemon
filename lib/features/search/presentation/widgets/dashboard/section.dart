import '../../../../../core/shared/shared.dart';

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
            padding: const EdgeInsets.all(16.0).copyWith(top: 24, bottom: 24),
            children: [
              Text(
                "Trusted Reviews and Ratings Platform in Bangladesh",
                style: TextStyles.headline(context: context, color: theme.backgroundPrimary).copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              InkWell(
                radius: 100,
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  //TODO:
                  // context.pushNamed(SearchPage.tag);
                },
                child: PhysicalModel(
                  color: theme.backgroundPrimary,
                  elevation: 1,
                  borderRadius: BorderRadius.circular(100),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0).copyWith(left: 16),
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
                          padding: const EdgeInsets.all(11.0),
                          decoration: BoxDecoration(
                            color: theme.primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(Icons.search, color: theme.backgroundPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

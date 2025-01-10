import '../../../../core/shared/shared.dart';
import '../../search.dart';

class DashboardSearchWidget extends StatelessWidget {
  const DashboardSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Container(
          decoration: BoxDecoration(
            color: theme.primary,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimension.padding.horizontal.max,
                  vertical: Dimension.padding.vertical.ultraMax,
                ),
                child: InkWell(
                  onTap: () {
                    context.pushNamed(SearchPage.name);
                  },
                  borderRadius: BorderRadius.circular(Dimension.radius.max),
                  child: Container(
                    key: Keys.home.search,
                    decoration: BoxDecoration(
                      color: theme.backgroundPrimary,
                      borderRadius: BorderRadius.circular(Dimension.radius.max),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimension.padding.horizontal.max,
                      vertical: Dimension.padding.vertical.large,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: theme.textSecondary),
                        SizedBox(width: Dimension.padding.horizontal.medium),
                        Expanded(
                          child: Text(
                            "Find company or category ...",
                            style: TextStyles.subTitle(
                                context: context, color: theme.textSecondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: Dimension.padding.vertical.ultraMax,
                width: Dimension.size.horizontal.max,
                decoration: BoxDecoration(
                  color: theme.backgroundPrimary,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Dimension.radius.max),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

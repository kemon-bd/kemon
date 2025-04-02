import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../search.dart';

class DashboardSearchWidget extends StatelessWidget {
  const DashboardSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final darkMode = state.mode == ThemeMode.dark;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(color: theme.primary),
              padding: EdgeInsets.symmetric(
                horizontal: Dimension.padding.horizontal.max,
                vertical: Dimension.padding.vertical.ultraMax,
              ),
              child: InkWell(
                onTap: () async {
                  context.pushNamed(SearchPage.name);
                  await sl<FirebaseAnalytics>().logEvent(
                    name: 'home_search',
                    parameters: {
                      'id': context.auth.profile?.identity.id ?? 'anonymous',
                      'name': context.auth.profile?.name.full ?? 'Guest',
                    },
                  );
                },
                borderRadius: BorderRadius.circular(Dimension.radius.max),
                child: Container(
                  key: Keys.home.search,
                  decoration: BoxDecoration(
                    color: theme.backgroundPrimary,
                    borderRadius: BorderRadius.circular(Dimension.radius.max),
                    border: Border.all(color: theme.textPrimary, width: darkMode ? 1 : 2),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimension.padding.horizontal.max,
                    vertical: Dimension.padding.vertical.large,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.search, color: theme.textSecondary.withAlpha(150), size: context.text.bodyMedium?.fontSize),
                      SizedBox(width: Dimension.padding.horizontal.medium),
                      Expanded(
                        child: Text(
                          "Find company or category ...",
                          style: context.text.bodyMedium?.copyWith(color: theme.textSecondary.withAlpha(150)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Dimension.size.horizontal.max,
              height: Dimension.size.vertical.twentyFour,
              child: Stack(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: [
                  Positioned.fill(
                    bottom: .1,
                    child: Container(
                      width: Dimension.size.horizontal.max,
                      height: Dimension.size.vertical.twentyFour,
                      decoration: BoxDecoration(
                        color: theme.primary,
                      ),
                      padding: EdgeInsets.all(0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      width: Dimension.size.horizontal.max,
                      height: Dimension.size.vertical.twentyFour,
                      decoration: BoxDecoration(
                        color: theme.backgroundPrimary,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimension.radius.max)),
                        border: Border(
                          top: BorderSide(
                            color: theme.textPrimary,
                            width: darkMode ? 1 : 2,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

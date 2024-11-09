import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';

class DashboardForYouWidget extends StatelessWidget {
  const DashboardForYouWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;

        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            horizontal: Dimension.padding.horizontal.max,
          ),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Text(
              'For You',
              style: TextStyles.title(context: context, color: theme.textPrimary),
            ),
            SizedBox(height: Dimension.padding.vertical.medium),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state.profile == null) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimension.padding.horizontal.large,
                      vertical: Dimension.padding.vertical.large,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.backgroundTertiary),
                      borderRadius: BorderRadius.circular(Dimension.radius.twentyFour),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [1, 2, 3, 4, 5]
                              .map(
                                (index) => Transform.rotate(
                                  angle: (pi / 12) * (index.isOdd ? -1 : 1),
                                  child: Image.asset(
                                    'images/logo/full.png',
                                    width: Dimension.radius.thirty,
                                    height: Dimension.radius.thirty,
                                    color: theme.primary,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        SizedBox(height: Dimension.padding.vertical.large),
                        Text(
                          "Join for free and explore all of KEMON.",
                          style: TextStyles.body(context: context, color: theme.textPrimary),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Dimension.padding.vertical.large),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(Dimension.radius.twelve),
                          decoration: BoxDecoration(
                            color: theme.primary.withAlpha(50),
                            borderRadius: BorderRadius.circular(Dimension.radius.thirtyTwo),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Login or Sign up",
                            style: TextStyles.miniHeadline(context: context, color: theme.primary).copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            SizedBox(height: Dimension.padding.vertical.max),
            Container(
              decoration: BoxDecoration(
                color: theme.link.withGreen(5).withRed(25).withBlue(50),
                border: Border.all(color: theme.backgroundTertiary, strokeAlign: BorderSide.strokeAlignOutside),
                borderRadius: BorderRadius.circular(Dimension.radius.twentyFour),
              ),
              clipBehavior: Clip.antiAlias,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimension.padding.horizontal.max,
                        vertical: Dimension.padding.vertical.large,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Bought something recently?',
                            style: TextStyles.subHeadline(context: context, color: theme.white).copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(Dimension.radius.eight),
                            margin: EdgeInsets.only(top: Dimension.padding.vertical.large),
                            decoration: BoxDecoration(
                              color: theme.white,
                              borderRadius: BorderRadius.circular(Dimension.radius.thirtyTwo),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Write a review",
                              style: TextStyles.miniHeadline(context: context, color: theme.black).copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: theme.backgroundSecondary,
                      child: CachedNetworkImage(
                        imageUrl: 'https://kemon.com.bd/images/top_bg_man.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimension.padding.vertical.max),
          ],
        );
      },
    );
  }
}

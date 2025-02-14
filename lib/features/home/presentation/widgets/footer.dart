import '../../../../core/shared/shared.dart';
import '../../home.dart';

class HomeFooterWidget extends StatelessWidget {
  const HomeFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Container(
          color: theme.backgroundSecondary,
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(0).copyWith(
              bottom: context.bottomInset + Dimension.padding.vertical.max,
            ),
            children: [
              Container(
                width: Dimension.size.horizontal.max,
                height: Dimension.size.vertical.twentyFour,
                decoration: BoxDecoration(
                  color: theme.backgroundPrimary,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(Dimension.radius.max),
                  ),
                ),
                padding: EdgeInsets.all(0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              SizedBox(height: Dimension.padding.vertical.max),
              Row(
                children: [
                  SizedBox(width: Dimension.padding.horizontal.max),
                  Image.asset(
                    'images/logo/full.png',
                    width: Dimension.radius.twentyFour,
                    height: Dimension.radius.twentyFour,
                    fit: BoxFit.contain,
                    color: theme.primary,
                  ),
                  SizedBox(width: Dimension.size.horizontal.eight),
                  Text(
                    'KEMON',
                    style: TextStyles.title(context: context, color: theme.primary),
                  ),
                  Spacer(),
                  FutureBuilder(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) {
                        return Text(
                          "v${snapshot.data?.version ?? ""}",
                          style: TextStyles.caption(context: context, color: theme.textPrimary),
                        );
                      }),
                  SizedBox(width: Dimension.padding.horizontal.max),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimension.padding.horizontal.max),
                child: Text(
                  'Kemon is a comprehensive platform dedicated to providing honest, community-driven reviews and ratings for a wide range of products and services. Whether accessed through our website or via our mobile apps on iOS and Android.',
                  style: TextStyles.caption(context: context, color: theme.textSecondary).copyWith(
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              SizedBox(height: Dimension.padding.vertical.max),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: Dimension.padding.horizontal.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // launchUrlString(
                      //   ExternalLinks.termsAndConditions,
                      //   mode: LaunchMode.externalApplication,
                      // );
                      context.pushNamed(TermsAndConditionsPage.name);
                    },
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyles.body(context: context, color: theme.link).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(Icons.circle, size: Dimension.radius.four, color: theme.backgroundTertiary),
                  InkWell(
                    onTap: () {
                      // launchUrlString(
                      //   ExternalLinks.privacyPolicy,
                      //   mode: LaunchMode.externalApplication,
                      // );
                      context.pushNamed(PrivacyPolicyPage.name);
                    },
                    child: Text(
                      'Privacy Policy',
                      style: TextStyles.body(context: context, color: theme.link).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimension.padding.vertical.max),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimension.padding.horizontal.max),
                child: Text(
                  '© Copyright ${DateTime.now().year} Kemon . All Right Reserved.',
                  style: TextStyles.overline(context: context, color: theme.primary),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

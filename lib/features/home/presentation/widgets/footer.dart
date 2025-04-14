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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: Dimension.padding.horizontal.max),
                  Image.asset(
                    'images/logo/full.png',
                    width: context.text.headlineSmall?.fontSize,
                    height: context.text.headlineSmall?.fontSize,
                    fit: BoxFit.contain,
                    color: theme.primary,
                  ),
                  SizedBox(width: Dimension.size.horizontal.eight),
                  Text(
                    'KEMON',
                    style: context.text.headlineSmall?.copyWith(
                      color: theme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      return Text(
                        "v${snapshot.data?.version ?? ""}",
                        style: context.text.labelSmall?.copyWith(
                          color: theme.textSecondary.withAlpha(200),
                          fontWeight: FontWeight.normal,
                          height: 1.0,
                        ),
                      );
                    },
                  ),
                  SizedBox(width: Dimension.padding.horizontal.max),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimension.padding.horizontal.max),
                child: Text(
                  'Kemon is a comprehensive platform dedicated to providing honest, community-driven reviews and ratings for a wide range of products and services. Whether accessed through our website or via our mobile apps on iOS and Android.',
                  style: context.text.bodySmall?.copyWith(
                    color: theme.textSecondary.withAlpha(200),
                    fontWeight: FontWeight.w100,
                    height: 1.25,
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
                      style: context.text.bodyMedium?.copyWith(
                        color: theme.link,
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
                      style: context.text.bodyMedium?.copyWith(
                        color: theme.link,
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
                  style: context.text.labelSmall?.copyWith(
                    color: theme.textPrimary,
                    fontWeight: FontWeight.normal,
                    height: 1.0,
                  ),
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

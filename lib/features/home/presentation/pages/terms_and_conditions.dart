import '../../../../core/shared/shared.dart';
import '../../home.dart';

class TermsAndConditionsPage extends StatelessWidget {
  static const String path = '/terms-conditions';
  static const String name = 'TermsAndConditionsPage';
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            backgroundColor: theme.backgroundSecondary,
            surfaceTintColor: theme.backgroundSecondary,
            titleSpacing: Dimension.size.horizontal.sixteen,
            leading: IconButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(HomePage.name);
                }
              },
              icon: Icon(Icons.arrow_back_rounded, color: theme.textPrimary),
            ),
            title: Text(
              'Terms and Conditions'.titleCase,
              style: context.text.headlineSmall?.copyWith(
              color: theme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            ),
            centerTitle: false,
          ),
          body: WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..loadRequest(Uri.parse(ExternalLinks.termsAndConditions)),
          ),
        );
      },
    );
  }
}

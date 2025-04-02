import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../profile.dart';

class PublicProfilePage extends StatelessWidget {
  static const String path = '/:user/profile';
  static const String name = 'PublicProfilePage';

  final Identity identity;
  const PublicProfilePage({
    super.key,
    required this.identity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: theme.primary,
            surfaceTintColor: theme.primary,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: theme.white),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(HomePage.name);
                }
              },
            ),
            title: ProfileUsernameWidget(
              style: context.text.titleMedium?.copyWith(
                color: theme.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            shrinkWrap: false,
            padding: EdgeInsets.zero,
            children: const [
              ProfileInformationWidget(),
              ProfileFeatureOptionsWidget(),
            ],
          ),
        );
      },
    );
  }
}

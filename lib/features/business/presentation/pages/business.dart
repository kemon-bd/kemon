import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessPage extends StatelessWidget {
  static const String path = '/business/:urlSlug';
  static const String name = 'BusinessPage';

  final String urlSlug;

  const BusinessPage({
    super.key,
    required this.urlSlug,
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
              icon: Icon(Icons.arrow_back_rounded, color: theme.backgroundPrimary),
              onPressed: context.pop,
            ),
            title: BlocBuilder<FindBusinessBloc, FindBusinessState>(
              builder: (context, state) {
                if (state is FindBusinessDone) {
                  final business = state.business;
                  return Text(
                    business.name.full,
                    style: TextStyles.title(context: context, color: theme.backgroundPrimary).copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 2,
                  );
                }
                return Container();
              },
            ),
            centerTitle: false,
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            children: const [
              BusinessInformationWidget(),
              BusinessRatingsWidget(),
              BusinessReviewsWidget(),
            ],
          ),
        );
      },
    );
  }
}

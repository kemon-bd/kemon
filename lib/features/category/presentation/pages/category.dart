import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../category.dart';

class CategoryPage extends StatelessWidget {
  static const String path = '/category/:urlSlug';
  static const String name = 'CategoryPage';

  final String urlSlug;

  const CategoryPage({
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: theme.textPrimary),
              onPressed: context.pop,
            ),
            title: BlocBuilder<FindCategoryBloc, FindCategoryState>(
              builder: (context, state) {
                if (state is FindCategoryDone) {
                  final category = state.category;
                  return Text(
                    category.name.full,
                    style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );
                }
                return Container();
              },
            ),
            centerTitle: false,
          ),
          body: BlocBuilder<FindBusinessesByCategoryBloc, FindBusinessesByCategoryState>(
            builder: (context, state) {
              if (state is FindBusinessesByCategoryLoading) {
                return ListView.separated(
                  cacheExtent: double.maxFinite,
                  itemBuilder: (_, index) {
                    return const BusinessItemShimmerWidget();
                  },
                  separatorBuilder: (_, __) => SizedBox(height: Dimension.padding.vertical.medium),
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: Dimension.padding.vertical.max),
                );
              } else if (state is FindBusinessesByCategoryDone) {
                final businesses = state.businesses;
                return businesses.isNotEmpty
                    ? ListView.separated(
                        cacheExtent: double.maxFinite,
                        itemBuilder: (_, index) {
                          final business = businesses[index];
                          return BusinessItemWidget(urlSlug: business.urlSlug);
                        },
                        separatorBuilder: (_, __) => SizedBox(height: Dimension.padding.vertical.medium),
                        itemCount: businesses.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: Dimension.padding.vertical.max),
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: context.height * .25),
                          child: Text(
                            "No listing found :(",
                            style: TextStyles.title(context: context, color: theme.backgroundTertiary),
                          ),
                        ),
                      );
              } else {
                return const SizedBox();
              }
            },
          ),
        );
      },
    );
  }
}

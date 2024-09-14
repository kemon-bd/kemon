import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../category.dart';

class CategoryPage extends StatefulWidget {
  static const String path = '/category/:urlSlug';
  static const String name = 'CategoryPage';

  final String urlSlug;

  const CategoryPage({
    super.key,
    required this.urlSlug,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Scaffold(
          key: scaffoldKey,
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
                    style: TextStyles.title(
                            context: context, color: theme.textPrimary)
                        .copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );
                }
                return Container();
              },
            ),
            actions: [
              Container(
                margin:
                    EdgeInsets.only(right: Dimension.padding.horizontal.small),
                alignment: Alignment.centerRight,
                child: BlocBuilder<FindBusinessesByCategoryBloc,
                    FindBusinessesByCategoryState>(
                  builder: (context, state) {
                    if (state is FindBusinessesByCategoryDone) {
                      return Text(
                        '${state.businesses.length} out of ${state.total}',
                        style: TextStyles.caption(
                            context: context, color: theme.textPrimary),
                      );
                    } else if (state is FindBusinessesByCategoryPaginating) {
                      return Text(
                        'fetching more...',
                        style: TextStyles.caption(
                            context: context, color: theme.textPrimary),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
                icon: Icon(
                  Icons.filter_alt_rounded,
                  color: theme.primary,
                  size: Dimension.radius.tweenty,
                ),
              )
            ],
            centerTitle: false,
          ),
          endDrawer: BlocListener<FilterBloc, FilterState>(
            listener: (_, state) {
              context.read<FindBusinessesByCategoryBloc>().add(
                    FindBusinessesByCategory(
                      category: widget.urlSlug,
                      sort: state.sortBy,
                      ratings: state.ratings,
                      division: state.division,
                      district: state.district,
                      thana: state.thana,
                      subCategory: state.subCategory,
                    ),
                  );
            },
            child: const FilterMenuWidget(),
          ),
          body: BlocBuilder<FindBusinessesByCategoryBloc,
              FindBusinessesByCategoryState>(
            builder: (context, state) {
              if (state is FindBusinessesByCategoryLoading) {
                return ListView.separated(
                  itemBuilder: (_, index) {
                    return const BusinessItemShimmerWidget();
                  },
                  separatorBuilder: (_, __) =>
                      SizedBox(height: Dimension.padding.vertical.medium),
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.zero.copyWith(
                      bottom:
                          Dimension.padding.vertical.max + context.bottomInset),
                );
              } else if (state is FindBusinessesByCategoryDone) {
                final businesses = state.businesses;
                final hasMore = state.total > businesses.length;

                return businesses.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (_, index) {
                          if (index == businesses.length) {
                            if (state is! FindBusinessesByCategoryPaginating) {
                              final filter = context.read<FilterBloc>().state;
                              context.read<FindBusinessesByCategoryBloc>().add(
                                    PaginateBusinessesByCategory(
                                      page: state.page + 1,
                                      category: widget.urlSlug,
                                      sort: filter.sortBy,
                                      ratings: filter.ratings,
                                      division: filter.division,
                                      district: filter.district,
                                      thana: filter.thana,
                                      subCategory: filter.subCategory,
                                    ),
                                  );
                            }
                            return const BusinessItemShimmerWidget();
                          }
                          final business = businesses[index];
                          return BusinessItemWidget(urlSlug: business.urlSlug);
                        },
                        separatorBuilder: (_, __) =>
                            SizedBox(height: Dimension.padding.vertical.medium),
                        itemCount: businesses.length + (hasMore ? 1 : 0),
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: EdgeInsets.zero.copyWith(
                            bottom: Dimension.padding.vertical.max +
                                context.bottomInset),
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.height * .25),
                          child: Text(
                            "No listing found :(",
                            style: TextStyles.title(
                                context: context,
                                color: theme.backgroundTertiary),
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

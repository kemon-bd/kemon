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
  final _scrollController = ScrollController();
  final _isAppBarExpanded = ValueNotifier<bool>(true);

  void _scrollListener() {
    final isExpanded = _scrollController.offset <= 200 - kToolbarHeight;
    if (isExpanded != _isAppBarExpanded.value) {
      _isAppBarExpanded.value = isExpanded;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return KeyboardDismissOnTap(
          child: Scaffold(
            body: ValueListenableBuilder<bool>(
              valueListenable: _isAppBarExpanded,
              builder: (context, isExpanded, _) {
                return CustomScrollView(
                  cacheExtent: 0,
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      collapsedHeight: context.topInset +
                          kToolbarHeight +
                          Dimension.padding.vertical.min -
                          (Platform.isIOS ? Dimension.size.vertical.twenty : 0),
                      expandedHeight: context.topInset +
                          kToolbarHeight +
                          (Platform.isAndroid ? Dimension.size.vertical.twenty : 0) +
                          Dimension.size.vertical.oneTwelve,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: context.pop,
                      ),
                      title: isExpanded
                          ? null
                          : NameWidget(
                              urlSlug: widget.urlSlug,
                              fontSize: Dimension.radius.twenty,
                            ).animate().fade(),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {},
                        ),
                      ],
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(Dimension.size.vertical.twenty),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimension.padding.horizontal.max,
                            vertical: Dimension.padding.vertical.large,
                          ).copyWith(top: 0),
                          child: TextField(
                            style: TextStyles.body(context: context, color: theme.textPrimary),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                size: Dimension.radius.sixteen,
                                color: theme.textSecondary,
                              ),
                              hintText: 'Find company or products...',
                              hintStyle: TextStyles.body(context: context, color: theme.textSecondary),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: Dimension.padding.horizontal.max,
                                vertical: Dimension.padding.vertical.large,
                              ),
                            ),
                          ),
                        ),
                      ),
                      flexibleSpace: isExpanded
                          ? FlexibleSpaceBar(
                              background: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimension.padding.horizontal.max,
                                ).copyWith(top: context.topInset + kToolbarHeight),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        NameWidget(urlSlug: widget.urlSlug, fontSize: Dimension.radius.twentyFour)
                                            .animate()
                                            .fade(),
                                        IconWidget(urlSlug: widget.urlSlug),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        FilterButton(urlSlug: widget.urlSlug),
                                        const SizedBox(width: 16),
                                        SortButton(),
                                        const Spacer(),
                                        TotalCount(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : null,
                    ),
                    const SliverToBoxAdapter(child: ListingsWidget()),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class FilterButton extends StatelessWidget {
  final String urlSlug;
  const FilterButton({
    super.key,
    required this.urlSlug,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: theme.backgroundPrimary,
          barrierColor: context.barrierColor,
          isScrollControlled: true,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<FindBusinessesByCategoryBloc>()),
              BlocProvider.value(value: context.read<FindCategoryBloc>()),
            ],
            child: const FilterBusinessesByCategoryWidget(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(Dimension.radius.twentyFour),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimension.padding.horizontal.ultraMax,
          vertical: Dimension.padding.vertical.medium,
        ),
        decoration: BoxDecoration(
          color: theme.link,
          borderRadius: BorderRadius.circular(Dimension.radius.twentyFour),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.filter_alt_outlined, size: Dimension.radius.twenty, color: theme.white),
            Text(
              'Filter',
              style: TextStyles.caption(context: context, color: theme.white),
            ),
          ],
        ),
      ),
    );
  }
}

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimension.padding.horizontal.ultraMax,
        vertical: Dimension.padding.vertical.medium,
      ),
      decoration: BoxDecoration(
        color: theme.link.withAlpha(50),
        borderRadius: BorderRadius.circular(Dimension.radius.twentyFour),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.swap_vert_rounded, size: Dimension.radius.twenty, color: theme.link),
          Text(
            'Sort',
            style: TextStyles.caption(context: context, color: theme.link),
          ),
        ],
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  final String urlSlug;
  final double? fontSize;
  const NameWidget({
    super.key,
    required this.urlSlug,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindCategoryBloc, FindCategoryState>(
      builder: (context, state) {
        if (state is FindCategoryDone) {
          final category = state.category;
          return Text(
            category.name.full,
            style: TextStyles.bigHeadline(context: context, color: theme.textPrimary).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? Dimension.radius.twelve,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          );
        }
        return Container();
      },
    );
  }
}

class IconWidget extends StatelessWidget {
  final String urlSlug;
  const IconWidget({
    super.key,
    required this.urlSlug,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return Container(
      padding: EdgeInsets.all(Dimension.radius.eight),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: theme.backgroundTertiary),
        borderRadius: BorderRadius.circular(Dimension.radius.twelve),
      ),
      child: Icon(
        Icons.label_rounded,
        size: Dimension.radius.twenty,
        color: theme.backgroundTertiary,
      ),
    );
  }
}

class TotalCount extends StatelessWidget {
  const TotalCount({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindBusinessesByCategoryBloc, FindBusinessesByCategoryState>(
      builder: (context, state) {
        if (state is FindBusinessesByCategoryDone) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.total.toString(),
                style: TextStyles.title(context: context, color: theme.textPrimary),
              ),
              Text(
                "Results",
                style: TextStyles.body(context: context, color: theme.textSecondary),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class ListingsWidget extends StatelessWidget {
  const ListingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindCategoryBloc, FindCategoryState>(
      builder: (context, state) {
        if (state is FindCategoryDone) {
          final urlSlug = state.category.urlSlug;
          return BlocBuilder<FindBusinessesByCategoryBloc, FindBusinessesByCategoryState>(
            builder: (context, state) {
              if (state is FindBusinessesByCategoryLoading) {
                return ListView.separated(
                  itemBuilder: (_, index) {
                    return const BusinessItemShimmerWidget();
                  },
                  separatorBuilder: (_, __) => SizedBox(height: Dimension.padding.vertical.medium),
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.zero.copyWith(bottom: Dimension.padding.vertical.max + context.bottomInset),
                );
              } else if (state is FindBusinessesByCategoryDone) {
                final businesses = state.businesses;
                final hasMore = state.total > businesses.length;

                return businesses.isNotEmpty
                    ? ListView.separated(
                        cacheExtent: 0,
                        itemBuilder: (_, index) {
                          if (index == businesses.length && hasMore) {
                            if (state is! FindBusinessesByCategoryPaginating) {
                              context.read<FindBusinessesByCategoryBloc>().add(
                                    PaginateBusinessesByCategory(
                                      page: state.page + 1,
                                      category: urlSlug,
                                      sort: state.sortBy,
                                      ratings: state.ratings,
                                      division: state.division,
                                      district: state.district,
                                      thana: state.thana,
                                      subCategory: state.subCategory,
                                    ),
                                  );
                            }
                            return const BusinessItemShimmerWidget();
                          }
                          final business = businesses[index];
                          return BusinessItemWidget(urlSlug: business.urlSlug);
                        },
                        separatorBuilder: (_, __) => SizedBox(height: Dimension.padding.vertical.medium),
                        itemCount: businesses.length + (hasMore ? 1 : 0),
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: EdgeInsets.zero.copyWith(
                          bottom: Dimension.padding.vertical.max + context.bottomInset,
                        ),
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
          );
        }
        return Container();
      },
    );
  }
}

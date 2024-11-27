import '../../../../core/shared/shared.dart';
import '../../category.dart';

class CategoriesPage extends StatefulWidget {
  static const String path = '/categories';
  static const String name = 'CategoriesPage';

  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final TextEditingController search = TextEditingController();

  final controller = ScrollController();
  final expanded = ValueNotifier<bool>(true);

  void _scrollListener() {
    final isExpanded = controller.offset <= 200 - kToolbarHeight;
    if (isExpanded != expanded.value) {
      expanded.value = isExpanded;
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.dispose();
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
              valueListenable: expanded,
              builder: (context, isExpanded, _) {
                final double collapsedHeight =
                    context.topInset + kToolbarHeight + Dimension.padding.vertical.min - Dimension.size.vertical.twenty;
                final double expandedHeight = context.topInset + kToolbarHeight + Dimension.size.vertical.oneTwelve;
                return CustomScrollView(
                  cacheExtent: 0,
                  controller: controller,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      scrolledUnderElevation: 1,
                      shadowColor: theme.backgroundSecondary,
                      collapsedHeight: collapsedHeight,
                      expandedHeight: expandedHeight,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: theme.primary),
                        onPressed: context.pop,
                      ),
                      title: isExpanded
                          ? null
                          : Text(
                              'Categories',
                              style: TextStyles.bigHeadline(context: context, color: theme.textPrimary).copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimension.radius.sixteen,
                              ),
                            ).animate().fade(),
                      centerTitle: false,
                      actions: [
                        const _ShareButton(),
                      ],
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(Dimension.size.vertical.twenty),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.backgroundPrimary.withAlpha(200),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimension.padding.horizontal.max,
                            vertical: Dimension.padding.vertical.large,
                          ).copyWith(top: 0),
                          child: TextField(
                            controller: search,
                            style: TextStyles.body(context: context, color: theme.textPrimary),
                            onChanged: (query) {
                              final bloc = context.read<FindAllCategoriesBloc>();
                              final filter = bloc.state;

                              bloc.add(FindAllCategories(
                                query: query,
                                industry: filter.industry,
                              ));
                            },
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
                                        Expanded(
                                          child: Text(
                                            'Categories',
                                            style: TextStyles.bigHeadline(context: context, color: theme.textPrimary).copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: Dimension.radius.twentyFour,
                                            ),
                                          ).animate().fade(),
                                        ),
                                        Container(
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
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const _FilterButton(),
                                        const SizedBox(width: 16),
                                        _SortButton(),
                                        const Spacer(),
                                        _TotalCount(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : null,
                    ),
                    SliverToBoxAdapter(child: _CategoriesWidget(search: search)),
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

class _ShareButton extends StatelessWidget {
  const _ShareButton();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return IconButton(
      icon: Icon(Icons.share, color: theme.primary),
      onPressed: () async {
        final result = await Share.share(
          """🌟 Discover the Best, Rated by the Rest! 🌟
🚀 Explore authentic reviews and ratings on Kemon!
💬 Real People. Real Reviews. Make smarter decisions today.
👀 Check out Categories(https://kemon.com.bd/category/category) now and share your experience with the community!

📲 Join the conversation on Kemon – Bangladesh's Premier Review Platform!

#KemonApp #TrustedReviews #CommunityFirst #RealOpinions""",
        );

        if (result.status == ShareResultStatus.success && context.mounted) {
          result.raw;
          context.successNotification(message: 'Thank you for sharing Categories.');
        }
      },
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton();

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
              BlocProvider.value(value: context.read<FindAllCategoriesBloc>()),
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

class _SortButton extends StatelessWidget {
  const _SortButton();

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
              BlocProvider.value(value: context.read<FindAllCategoriesBloc>()),
              BlocProvider.value(value: context.read<FindCategoryBloc>()),
            ],
            child: const SortBusinessesByCategoryWidget(),
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
      ),
    );
  }
}

class _TotalCount extends StatelessWidget {
  const _TotalCount();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindAllCategoriesBloc, FindAllCategoriesState>(
      builder: (context, state) {
        if (state is FindAllCategoriesDone) {
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

class _CategoriesWidget extends StatelessWidget {
  final TextEditingController search;

  const _CategoriesWidget({
    required this.search,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindAllCategoriesBloc, FindAllCategoriesState>(
      builder: (context, state) {
        if (state is FindAllCategoriesLoading) {
          return Center(child: const CircularProgressIndicator());
        } else if (state is FindAllCategoriesDone) {
          final hasMore = state.total > state.results.count;

          return state.results.isNotEmpty
              ? ListView.separated(
                  cacheExtent: 0,
                  itemBuilder: (_, index) {
                    final row = state.results.elementAt(index);
                    final industry = row.industry;
                    final categories = row.categories;
                    final icon = Padding(
                      padding: EdgeInsets.all(Dimension.radius.eight),
                      child: Icon(
                        Icons.label_rounded,
                        size: Dimension.radius.sixteen,
                        color: theme.backgroundTertiary,
                      ),
                    );
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: theme.backgroundTertiary),
                                borderRadius: BorderRadius.circular(Dimension.radius.eight),
                              ),
                              child: industry.icon.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: industry.icon.url,
                                      fit: BoxFit.cover,
                                        width: Dimension.radius.thirtyTwo,
                                        height: Dimension.radius.thirtyTwo,
                                      placeholder: (_, __) => ShimmerLabel(
                                        width: Dimension.radius.thirtyTwo,
                                        height: Dimension.radius.thirtyTwo,
                                      ),
                                      errorWidget: (_, __, ___) => icon,
                                    )
                                  : icon,
                            ),
                            SizedBox(width: Dimension.padding.horizontal.large),
                            Expanded(
                              child: Text(
                                industry.name.full,
                                style: TextStyles.headline(context: context, color: theme.textPrimary).copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimension.radius.sixteen,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        ListView.separated(
                          cacheExtent: 0,
                          itemBuilder: (_, index) {
                            final category = categories.elementAt(index);
                            final icon = Padding(
                              padding: EdgeInsets.all(Dimension.radius.four),
                              child: Icon(
                                Icons.label_rounded,
                                size: Dimension.radius.sixteen,
                                color: theme.backgroundTertiary,
                              ),
                            );
                            final child = Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: theme.backgroundTertiary),
                                    borderRadius: BorderRadius.circular(Dimension.radius.eight),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: category.icon.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: category.icon.url,
                                          width: Dimension.radius.twentyFour,
                                          height: Dimension.radius.twentyFour,
                                          fit: BoxFit.cover,
                                          placeholder: (_, __) => ShimmerLabel(
                                            width: Dimension.radius.twentyFour,
                                            height: Dimension.radius.twentyFour,
                                          ),
                                          errorWidget: (_, __, ___) => icon,
                                        )
                                      : icon,
                                ),
                                SizedBox(width: Dimension.padding.horizontal.medium),
                                Expanded(
                                  child: Text(
                                    category.name.full,
                                    style: TextStyles.body(context: context, color: theme.textPrimary),
                                  ),
                                ),
                              ],
                            );
                            if (state.results.lastItem(category: category) && hasMore) {
                              if (state is! FindAllCategoriesPaginating) {
                                final bloc = context.read<FindAllCategoriesBloc>();
                                final filter = bloc.state;

                                bloc.add(
                                  PaginateAllCategories(
                                    page: state.page + 1,
                                    query: filter.query,
                                    industry: filter.industry,
                                  ),
                                );
                              }
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  child,
                                  const LinearProgressIndicator(),
                                ],
                              );
                            }
                            return child;
                          },
                          separatorBuilder: (_, __) => Divider(height: Dimension.padding.vertical.large),
                          itemCount: categories.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          padding: EdgeInsets.all(Dimension.radius.sixteen).copyWith(
                            left: Dimension.padding.horizontal.ultraMax,
                            top: Dimension.padding.vertical.medium,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: Dimension.padding.vertical.medium),
                  itemCount: state.results.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.all(Dimension.radius.sixteen).copyWith(
                    bottom: Dimension.radius.sixteen + context.bottomInset,
                  ),
                )
              : Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: context.height * .25),
                    child: Text(
                      "No category found :(",
                      style: TextStyles.title(context: context, color: theme.backgroundTertiary),
                    ),
                  ),
                );
        } else if (state is FindAllCategoriesError) {
          return Text(
            state.failure.message,
            style: TextStyles.body(context: context, color: theme.negative),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

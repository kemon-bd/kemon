import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../home/home.dart';
import '../../category.dart';

class CategoryPage extends StatefulWidget {
  static const String path = '/category/:urlSlug';
  static const String name = 'CategoryPage';
  final CategoryEntity? category;
  final String urlSlug;

  const CategoryPage({
    super.key,
    required this.urlSlug,
    required this.category,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController search = TextEditingController();

  final controller = ScrollController();
  final expanded = ValueNotifier<bool>(true);

  void _scrollListener() {
    final isExpanded = controller.offset <= context.topInset + kToolbarHeight + Dimension.padding.vertical.medium;
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
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return KeyboardDismissOnTap(
          child: BlocListener<CategoryListingsFilterBloc, CategoryListingsFilterState>(
            listener: (context, state) {
              context.read<FindBusinessesByCategoryBloc>().add(
                    RefreshBusinessesByCategory(
                      division: state.division,
                      district: state.district,
                      thana: state.thana,
                      subCategory: state.subCategory,
                      ratings: state.rating.stars,
                      urlSlug: widget.urlSlug,
                    ),
                  );
            },
            child: Scaffold(
              body: ValueListenableBuilder<bool>(
                valueListenable: expanded,
                builder: (context, isExpanded, _) {
                  final appBar = SliverAppBar(
                    pinned: true,
                    collapsedHeight: context.topInset + kToolbarHeight - Dimension.padding.vertical.medium,
                    expandedHeight: context.topInset + kToolbarHeight + Dimension.size.vertical.oneFortyFour,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: theme.primary),
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.goNamed(HomePage.name);
                        }
                      },
                    ),
                    title: isExpanded
                        ? null
                        : _NameWidget(
                            category: widget.category,
                            urlSlug: widget.urlSlug,
                            fontSize: Dimension.radius.twenty,
                            maxLines: 2,
                          ).animate().fade(),
                    centerTitle: false,
                    actions: [
                      const _ShareButton(),
                    ],
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(Dimension.size.vertical.twenty),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimension.padding.horizontal.max,
                          vertical: Dimension.padding.vertical.large,
                        ).copyWith(top: 0),
                        child: TextField(
                          controller: search,
                          style: TextStyles.body(context: context, color: theme.textPrimary),
                          onChanged: (query) {
                            final bloc = context.read<FindBusinessesByCategoryBloc>();
                            final filter = context.read<CategoryListingsFilterBloc>().state;

                            bloc.add(FindBusinessesByCategory(
                              urlSlug: widget.urlSlug,
                              query: query,
                              sort: SortBy.recommended,
                              ratings: filter.rating.stars,
                              division: filter.division,
                              district: filter.district,
                              thana: filter.thana,
                              subCategory: filter.subCategory,
                            ));
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              size: Dimension.radius.sixteen,
                              color: theme.textSecondary,
                            ),
                            hintText: 'Looking for something specific?',
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
                                        child: _NameWidget(
                                          category: widget.category,
                                          urlSlug: widget.urlSlug,
                                          fontSize: Dimension.radius.twentyFour,
                                        ).animate().fade(),
                                      ),
                                      _IconWidget(urlSlug: widget.urlSlug),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BlocBuilder<FindCategoryBloc, FindCategoryState>(
                                        builder: (context, state) {
                                          if (state is FindCategoryDone) {
                                            return _FilterButton(category: state.category);
                                          }
                                          return const SizedBox();
                                        },
                                      ),
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
                  );
                  final shimmer = SliverList.separated(
                    separatorBuilder: (context, index) => SizedBox(height: Dimension.padding.vertical.max),
                    itemBuilder: (context, index) => const BusinessItemShimmerWidget(),
                    itemCount: 10,
                  );
                  done(FindBusinessesByCategoryDone state, urlSlug) {
                    final businesses = state.businesses;
                    final hasMore = state.total > businesses.length;

                    return SliverList.separated(
                      addAutomaticKeepAlives: false,
                      separatorBuilder: (context, index) => SizedBox(height: Dimension.padding.vertical.medium),
                      itemBuilder: (context, index) {
                        if (index == businesses.length && hasMore) {
                          if (state is! FindBusinessesByCategoryPaginating) {
                            final filter = context.read<CategoryListingsFilterBloc>().state;
                            context.read<FindBusinessesByCategoryBloc>().add(
                                  PaginateBusinessesByCategory(
                                    page: state.page + 1,
                                    query: search.text,
                                    urlSlug: urlSlug,
                                    sort: state.sortBy,
                                    ratings: filter.rating.stars,
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
                        final child = BusinessItemWidget(urlSlug: business.urlSlug);
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            child,
                            if (index + 1 == businesses.length && !hasMore) ...[
                              SizedBox(height: Dimension.padding.vertical.max),
                              Container(
                                width: context.width,
                                color: theme.backgroundSecondary,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(Dimension.radius.twelve),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.info_outline_rounded,
                                      color: theme.textSecondary,
                                      size: Dimension.radius.twelve,
                                    ),
                                    SizedBox(width: Dimension.padding.horizontal.small),
                                    Text(
                                      "reached the bottom of the results.",
                                      style: TextStyles.body(context: context, color: theme.textSecondary),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ],
                        );
                      },
                      itemCount: businesses.length + (hasMore ? 1 : 0),
                    );
                  }

                  return BlocBuilder<FindBusinessesByCategoryBloc, FindBusinessesByCategoryState>(
                    builder: (context, state) {
                      return CustomScrollView(
                        controller: controller,
                        slivers: [
                          appBar,
                          if (state is FindBusinessesByCategoryLoading) shimmer,
                          if (state is FindBusinessesByCategoryDone) done(state, widget.urlSlug),
                          SliverPadding(padding: EdgeInsets.all(0).copyWith(bottom: context.bottomInset + 16)),
                        ],
                      );
                    },
                  );
                },
              ),
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
    return BlocBuilder<FindCategoryBloc, FindCategoryState>(
      builder: (context, state) {
        if (state is FindCategoryDone) {
          final category = state.category;
          return IconButton(
            icon: Icon(Icons.share, color: theme.primary),
            onPressed: () async {
              final result = await Share.share(
                """🌟 Discover the Best, Rated by the Rest! 🌟
🚀 Explore authentic reviews and ratings on Kemon!
💬 Real People. Real Reviews. Make smarter decisions today.
👀 Check out ${category.name.full}(https://kemon.com.bd/category/${category.urlSlug}) now and share your experience with the community!

📲 Join the conversation on Kemon – Bangladesh's Premier Review Platform!

#KemonApp #TrustedReviews #CommunityFirst #RealOpinions""",
              );

              if (result.status == ShareResultStatus.success && context.mounted) {
                result.raw;
                context.successNotification(message: 'Thank you for sharing ${category.name.full}');
              }
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _FilterButton extends StatelessWidget {
  final CategoryEntity category;
  const _FilterButton({
    required this.category,
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
          shape: RoundedRectangleBorder(),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<FindBusinessesByCategoryBloc>()),
              BlocProvider.value(value: context.read<FindCategoryBloc>()),
              BlocProvider.value(value: context.read<CategoryListingsFilterBloc>()),
            ],
            child: CategoryListingsFilter(category: category.identity.guid),
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
              BlocProvider.value(value: context.read<FindBusinessesByCategoryBloc>()),
              BlocProvider.value(value: context.read<FindCategoryBloc>()),
              BlocProvider.value(value: context.read<CategoryListingsFilterBloc>()),
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

class _NameWidget extends StatelessWidget {
  final String urlSlug;
  final CategoryEntity? category;
  final double? fontSize;
  final int? maxLines;
  const _NameWidget({
    required this.urlSlug,
    required this.category,
    this.fontSize,
    this.maxLines,
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
            style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? Dimension.radius.twelve,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          );
        }
        return Text(
          category?.name.full ?? '',
          style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: fontSize ?? Dimension.radius.twelve,
          ),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}

class _IconWidget extends StatelessWidget {
  final String urlSlug;
  const _IconWidget({
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
      child: BlocBuilder<FindCategoryBloc, FindCategoryState>(
        builder: (context, state) {
          final fallback = Icon(
            Icons.label_rounded,
            size: Dimension.radius.twenty,
            color: theme.backgroundTertiary,
          );
          if (state is FindCategoryDone) {
            return CachedNetworkImage(
              imageUrl: state.category.icon.url,
              width: Dimension.radius.twenty,
              height: Dimension.radius.twenty,
              fit: BoxFit.cover,
              placeholder: (context, url) => fallback,
              errorWidget: (context, url, error) => fallback,
            );
          }
          return fallback;
        },
      ),
    );
  }
}

class _TotalCount extends StatelessWidget {
  const _TotalCount();

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
                style: TextStyles.subTitle(context: context, color: theme.textPrimary),
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

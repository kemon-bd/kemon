import '../../../../core/config/config.dart';
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
                return CustomScrollView(
                  cacheExtent: 0,
                  controller: controller,
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
                        icon: Icon(Icons.arrow_back, color: theme.primary),
                        onPressed: context.pop,
                      ),
                      title: isExpanded
                          ? null
                          : _NameWidget(
                              urlSlug: widget.urlSlug,
                              fontSize: Dimension.radius.sixteen,
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
                              final filter = bloc.state;

                              bloc.add(FindBusinessesByCategory(
                                category: widget.urlSlug,
                                query: query,
                                sort: filter.sortBy,
                                ratings: filter.ratings,
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
                                          child: _NameWidget(urlSlug: widget.urlSlug, fontSize: Dimension.radius.twentyFour)
                                              .animate()
                                              .fade(),
                                        ),
                                        _IconWidget(urlSlug: widget.urlSlug),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        _FilterButton(urlSlug: widget.urlSlug),
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
                    SliverToBoxAdapter(child: _ListingsWidget(search: search, urlSlug: widget.urlSlug)),
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
  final String urlSlug;
  const _FilterButton({
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
  final double? fontSize;
  final int? maxLines;
  const _NameWidget({
    required this.urlSlug,
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
            style: TextStyles.bigHeadline(context: context, color: theme.textPrimary).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? Dimension.radius.twelve,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          );
        }
        return Container();
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
      child: Icon(
        Icons.label_rounded,
        size: Dimension.radius.twenty,
        color: theme.backgroundTertiary,
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

class _ListingsWidget extends StatelessWidget {
  final String urlSlug;
  final TextEditingController search;

  const _ListingsWidget({
    required this.urlSlug,
    required this.search,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
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
                  itemBuilder: (_, index) {
                    if (index == businesses.length && hasMore) {
                      if (state is! FindBusinessesByCategoryPaginating) {
                        context.read<FindBusinessesByCategoryBloc>().add(
                              PaginateBusinessesByCategory(
                                page: state.page + 1,
                                query: search.text,
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
                    return BlocProvider(
                      create: (_) => sl<FindBusinessBloc>()..add(FindBusiness(urlSlug: business.urlSlug)),
                      child: const BusinessItemWidget(),
                    );
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
        } else if (state is FindBusinessesByCategoryError) {
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

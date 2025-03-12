import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../home/home.dart';
import '../../../location/location.dart';
import '../../category.dart';

class CategoryPage extends StatefulWidget {
  static const String path = '/category/:urlSlug';
  static const String name = 'CategoryPage';
  final Identity industry;
  final Identity category;

  const CategoryPage({
    super.key,
    required this.industry,
    required this.category,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController search = TextEditingController();
  SortBy sort = SortBy.recommended;
  RatingRange ratings = RatingRange.all;
  DivisionWithListingCountEntity? division;
  DistrictWithListingCountEntity? district;
  ThanaWithListingCountEntity? thana;

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
              builder: (_, isExpanded, __) {
                final appBar = SliverAppBar(
                  pinned: true,
                  collapsedHeight: context.topInset + kToolbarHeight - Dimension.padding.vertical.medium,
                  expandedHeight: context.topInset + kToolbarHeight + Dimension.size.vertical.oneTwelve,
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
                          fontSize: Dimension.radius.twenty,
                          maxLines: 2,
                        ).animate().fade(),
                  centerTitle: false,
                  actions: [
                    _ShareButton(),
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
                          if (query.isEmpty) {
                            bloc.add(SearchBusinessesByCategory(
                              query: query,
                              division: division?.urlSlug,
                              district: district?.urlSlug,
                              thana: thana?.urlSlug,
                              sort: sort,
                              ratings: ratings,
                              industry: widget.industry,
                              category: widget.category,
                            ));
                            return;
                          }

                          bloc.add(FindBusinessesByCategory(
                            division: division?.urlSlug,
                            district: district?.urlSlug,
                            thana: thana?.urlSlug,
                            sort: sort,
                            ratings: ratings,
                            industry: widget.industry,
                            category: widget.category,
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
                                        fontSize: Dimension.radius.twentyFour,
                                      ).animate().fade(),
                                    ),
                                    _IconWidget(),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _FilterButton(
                                      division: division,
                                      district: district,
                                      thana: thana,
                                      ratings: ratings,
                                      industry: widget.industry,
                                      category: widget.category,
                                      subCategory: null,
                                      onSelect: (i, c, s, r) {
                                        setState(() {
                                          division = i;

                                          district = c;
                                          thana = s;
                                          ratings = r;
                                        });

                                        context.read<FindBusinessesByCategoryBloc>().add(
                                              FindBusinessesByCategory(
                                                division: division?.urlSlug,
                                                district: district?.urlSlug,
                                                thana: thana?.urlSlug,
                                                sort: sort,
                                                ratings: ratings,
                                                industry: widget.industry,
                                                category: widget.category,
                                              ),
                                            );
                                      },
                                    ),
                                    const SizedBox(width: 16),
                                    _SortButton(
                                      sort: sort,
                                      onSelect: (selection) {
                                        setState(() {
                                          sort = selection;
                                        });

                                        context.read<FindBusinessesByCategoryBloc>().add(
                                              FindBusinessesByCategory(
                                                division: division?.urlSlug,
                                                district: district?.urlSlug,
                                                thana: thana?.urlSlug,
                                                sort: selection,
                                                ratings: ratings,
                                                industry: widget.industry,
                                                category: widget.category,
                                              ),
                                            );
                                      },
                                    ),
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
                done(FindBusinessesByCategoryDone state) {
                  final businesses = state.businesses;

                  return SliverList.separated(
                    addAutomaticKeepAlives: false,
                    separatorBuilder: (context, index) => SizedBox(height: Dimension.padding.vertical.medium),
                    itemBuilder: (context, index) {
                      final business = businesses[index];
                      final child = BusinessItemWidget(business: business);
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          child,
                          if (index == businesses.length) ...[
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
                    itemCount: businesses.length,
                  );
                }

                return BlocBuilder<FindBusinessesByCategoryBloc, FindBusinessesByCategoryState>(
                  builder: (context, state) {
                    return CustomScrollView(
                      cacheExtent: 0,
                      controller: controller,
                      slivers: [
                        appBar,
                        if (state is FindBusinessesByCategoryLoading) shimmer,
                        if (state is FindBusinessesByCategoryDone)
                          SliverPadding(
                            padding: EdgeInsets.all(16).copyWith(top: 0),
                            sliver: done(state),
                          ),
                        SliverPadding(padding: EdgeInsets.all(0).copyWith(bottom: context.bottomInset + 16)),
                      ],
                    );
                  },
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
          return IconButton(
            icon: Icon(Icons.share, color: theme.primary),
            onPressed: () async {
              final result = await Share.share(
                """🌟 Discover the Best, Rated by the Rest! 🌟
🚀 Explore authentic reviews and ratings on Kemon!
💬 Real People. Real Reviews. Make smarter decisions today.
👀 Check out ${state.category.name.full}(https://kemon.com.bd/category/${state.category.urlSlug}) now and share your experience with the community!

📲 Join the conversation on Kemon – Bangladesh's Premier Review Platform!

#KemonApp #TrustedReviews #CommunityFirst #RealOpinions""",
              );

              if (result.status == ShareResultStatus.success && context.mounted) {
                result.raw;
                context.successNotification(message: 'Thank you for sharing ${state.category.name.full}');
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
  final Identity industry;
  final Identity category;
  final Identity? subCategory;
  final DivisionWithListingCountEntity? division;
  final DistrictWithListingCountEntity? district;
  final ThanaWithListingCountEntity? thana;
  final RatingRange ratings;
  final Function(
    DivisionWithListingCountEntity?,
    DistrictWithListingCountEntity?,
    ThanaWithListingCountEntity?,
    RatingRange,
  ) onSelect;

  const _FilterButton({
    required this.industry,
    required this.category,
    required this.subCategory,
    required this.division,
    required this.district,
    required this.thana,
    required this.ratings,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return InkWell(
      onTap: () async {
        final selection = await showModalBottomSheet<
            (
              DivisionWithListingCountEntity?,
              DistrictWithListingCountEntity?,
              ThanaWithListingCountEntity?,
              RatingRange,
            )>(
          context: context,
          backgroundColor: theme.backgroundPrimary,
          barrierColor: context.barrierColor,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(),
          builder: (_) => CategoryBasedListingsFilter(
            division: division,
            district: district,
            thana: thana,
            industry: industry,
            category: category,
            subCategory: subCategory,
            ratings: ratings,
          ),
        );
        if (selection != null) {
          onSelect(selection.$1, selection.$2, selection.$3, selection.$4);
        }
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
  final SortBy sort;
  final Function(SortBy) onSelect;
  const _SortButton({
    required this.sort,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return InkWell(
      onTap: () async {
        final selection = await showModalBottomSheet<SortBy>(
          context: context,
          backgroundColor: theme.backgroundPrimary,
          barrierColor: context.barrierColor,
          isScrollControlled: true,
          builder: (_) => SortBusinessesByLocationWidget(selection: sort),
        );
        if (!context.mounted) return;
        if (selection != null) {
          onSelect(selection);
        }
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
  final double? fontSize;
  final int? maxLines;
  const _NameWidget({
    this.fontSize,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindCategoryBloc, FindCategoryState>(
      builder: (context, state) {
        if (state is FindCategoryDone) {
          return Text(
            state.category.name.full,
            style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? Dimension.radius.twelve,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          );
        }
        return Text(
          "Category",
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
  const _IconWidget();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindCategoryBloc, FindCategoryState>(
      builder: (context, state) {
        final fallback = Icon(
          Icons.label_rounded,
          size: Dimension.radius.twenty,
          color: theme.backgroundTertiary,
        );
        if (state is FindCategoryDone) {
          return CachedNetworkImage(
            imageUrl: state.category.icon.url,
            width: Dimension.radius.thirtyTwo,
            height: Dimension.radius.thirtyTwo,
            fit: BoxFit.cover,
            placeholder: (context, url) => fallback,
            errorWidget: (context, url, error) => fallback,
          );
        }
        return fallback;
      },
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
                state.businesses.length.toString(),
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

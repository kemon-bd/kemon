import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../category/category.dart';
import '../../../home/home.dart';
import '../../../industry/industry.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../location.dart';

class DivisionPage extends StatefulWidget {
  static const String path = '/locations/:division';
  static const String name = 'DivisionPage';
  final String division;

  const DivisionPage({
    super.key,
    required this.division,
  });

  @override
  State<DivisionPage> createState() => _DivisionPageState();
}

class _DivisionPageState extends State<DivisionPage> {
  final TextEditingController search = TextEditingController();
  SortBy sort = SortBy.recommended;
  RatingRange ratings = RatingRange.all;
  IndustryWithListingCountEntity? industry;
  CategoryWithListingCountEntity? category;
  SubCategoryWithListingCountEntity? subCategory;

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
    sl<FirebaseAnalytics>().logScreenView(
      screenClass: 'LocationPage',
      screenName: 'LocationPage',
      parameters: {
        'id': context.auth.profile?.identity.id ?? 'anonymous',
        'name': context.auth.profile?.name.full ?? 'Guest',
        'urlSlug': widget.division,
      },
    );
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
                          urlSlug: widget.division,
                          fontSize: Dimension.radius.twenty,
                          maxLines: 2,
                        ).animate().fade(),
                  centerTitle: false,
                  actions: [
                    _ShareButton(division: widget.division),
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
                          final bloc = context.read<FindBusinessesByLocationBloc>();

                          bloc.add(FindBusinessesByLocation(
                            division: widget.division,
                            query: query,
                          ));
                        },
                        onEditingComplete: () async {
                          await sl<FirebaseAnalytics>().logEvent(
                            name: 'listing_search_within_location',
                            parameters: {
                              'id': context.auth.profile?.identity.id ?? 'anonymous',
                              'name': context.auth.profile?.name.full ?? 'Guest',
                              'urlSlug': widget.division,
                            },
                          );
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
                                        urlSlug: widget.division,
                                        fontSize: Dimension.radius.twentyFour,
                                      ).animate().fade(),
                                    ),
                                    _IconWidget(urlSlug: widget.division),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _FilterButton(
                                      industry: industry,
                                      category: category,
                                      subCategory: subCategory,
                                      ratings: ratings,
                                      urlSlug: widget.division,
                                      onSelect: (i, c, s, r) {
                                        setState(() {
                                          industry = i;

                                          category = c;
                                          subCategory = s;
                                          ratings = r;
                                        });

                                        context.read<FindBusinessesByLocationBloc>().add(
                                              FindBusinessesByLocation(
                                                division: widget.division,
                                                sort: sort,
                                                ratings: ratings,
                                                industry: industry?.identity,
                                                category: category?.identity,
                                                subCategory: subCategory?.identity,
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

                                        context.read<FindBusinessesByLocationBloc>().add(
                                              FindBusinessesByLocation(
                                                division: widget.division,
                                                sort: selection,
                                                ratings: ratings,
                                                industry: industry?.identity,
                                                category: category?.identity,
                                                subCategory: subCategory?.identity,
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
                done(FindBusinessesByLocationDone state, urlSlug) {
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

                return BlocBuilder<FindBusinessesByLocationBloc, FindBusinessesByLocationState>(
                  builder: (context, state) {
                    return CustomScrollView(
                      cacheExtent: 0,
                      controller: controller,
                      slivers: [
                        appBar,
                        if (state is FindBusinessesByLocationLoading) shimmer,
                        if (state is FindBusinessesByLocationDone)
                          SliverPadding(
                            padding: EdgeInsets.all(16).copyWith(top: 0),
                            sliver: done(state, widget.division),
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
  final String division;
  const _ShareButton({
    required this.division,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindLookupBloc, FindLookupState>(
      builder: (context, state) {
        if (state is FindLookupDone) {
          final location = state.lookups.firstWhere((l) => l.value.same(as: division));
          return IconButton(
            icon: Icon(Icons.share, color: theme.primary),
            onPressed: () async {
              await sl<FirebaseAnalytics>().logEvent(
                name: 'location_share',
                parameters: {
                  'id': context.auth.profile?.identity.id ?? 'anonymous',
                  'name': context.auth.profile?.name.full ?? 'Guest',
                  'location': location.text,
                  'urlSlug': location.value,
                },
              );
              final result = await Share.share(
                """🌟 Discover the Best, Rated by the Rest! 🌟
🚀 Explore authentic reviews and ratings on Kemon!
💬 Real People. Real Reviews. Make smarter decisions today.
👀 Check out ${location.text}(https://kemon.com.bd/location/division/$division) now and share your experience with the community!

📲 Join the conversation on Kemon – Bangladesh's Premier Review Platform!

#KemonApp #TrustedReviews #CommunityFirst #RealOpinions""",
              );

              if (result.status == ShareResultStatus.success && context.mounted) {
                result.raw;
                context.successNotification(message: 'Thank you for sharing ${location.text}');
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
  final IndustryWithListingCountEntity? industry;
  final CategoryWithListingCountEntity? category;
  final SubCategoryWithListingCountEntity? subCategory;
  final RatingRange ratings;
  final Function(
          IndustryWithListingCountEntity?, CategoryWithListingCountEntity?, SubCategoryWithListingCountEntity?, RatingRange)
      onSelect;

  const _FilterButton({
    required this.urlSlug,
    required this.industry,
    required this.category,
    required this.subCategory,
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
              IndustryWithListingCountEntity?,
              CategoryWithListingCountEntity?,
              SubCategoryWithListingCountEntity?,
              RatingRange
            )>(
          context: context,
          backgroundColor: theme.backgroundPrimary,
          barrierColor: context.barrierColor,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(),
          builder: (_) => LocationBasedListingsFilter(
            division: urlSlug,
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
    return BlocBuilder<FindLookupBloc, FindLookupState>(
      builder: (context, state) {
        if (state is FindLookupDone) {
          final location = state.lookups.firstWhere((l) => l.value.same(as: urlSlug));
          return Text(
            location.text,
            style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? Dimension.radius.twelve,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          );
        }
        return Text(
          urlSlug,
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
    return BlocBuilder<FindBusinessesByLocationBloc, FindBusinessesByLocationState>(
      builder: (context, state) {
        if (state is FindBusinessesByLocationDone) {
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

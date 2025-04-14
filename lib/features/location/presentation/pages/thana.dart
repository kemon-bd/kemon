import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../category/category.dart';
import '../../../home/home.dart';
import '../../../industry/industry.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../location.dart';

class ThanaPage extends StatefulWidget {
  static const String path = '/locations/:division/:district/:thana';
  static const String name = 'ThanaPage';
  final String division;
  final String district;
  final String thana;

  const ThanaPage({
    super.key,
    required this.division,
    required this.district,
    required this.thana,
  });

  @override
  State<ThanaPage> createState() => _ThanaPageState();
}

class _ThanaPageState extends State<ThanaPage> {
  final TextEditingController search = TextEditingController();
  SortBy sort = SortBy.recommended;
  RatingRange ratings = RatingRange.all;
  IndustryWithListingCountEntity? industry;
  CategoryWithListingCountEntity? category;
  SubCategoryWithListingCountEntity? subCategory;

  final controller = ScrollController();
  final expanded = ValueNotifier<bool>(true);

  void _scrollListener() {
    final isExpanded = controller.offset <=
        240 - context.topInset - kToolbarHeight - Dimension.size.vertical.twenty - 2 * Dimension.padding.vertical.large;
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
                  collapsedHeight: kToolbarHeight + Dimension.size.vertical.twenty + 2 * Dimension.padding.vertical.large,
                  expandedHeight: 240,
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
                          urlSlug: widget.thana,
                          style: context.text.titleLarge?.copyWith(color: theme.textPrimary),
                          maxLines: 2,
                        ).animate().fade(),
                  centerTitle: false,
                  actions: [
                    _ShareButton(district: widget.district),
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
                        style: context.text.bodyMedium?.copyWith(color: theme.textPrimary),
                        onChanged: (query) {
                          final bloc = context.read<FindBusinessesByLocationBloc>();

                          bloc.add(FindBusinessesByLocation(
                            division: widget.division,
                            district: widget.district,
                            thana: widget.thana,
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
                            size: context.text.bodyMedium?.fontSize,
                            color: theme.textSecondary,
                          ),
                          hintText: 'Looking for something specific?',
                          hintStyle: context.text.bodyMedium?.copyWith(color: theme.textSecondary),
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
                                        urlSlug: widget.thana,
                                        style: context.text.headlineSmall?.copyWith(
                                          color: theme.textPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                      ).animate().fade(),
                                    ),
                                    _IconWidget(urlSlug: widget.district),
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
                                      division: widget.division,
                                      district: widget.district,
                                      thana: widget.thana,
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
                                                district: widget.district,
                                                thana: widget.thana,
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
                                                district: widget.district,
                                                thana: widget.thana,
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
                          if (index + 1 == businesses.length) ...[
                            SizedBox(height: Dimension.padding.vertical.max),
                            Container(
                              width: context.width,
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
                                    "That's all for now.",
                                    style: context.text.bodySmall?.copyWith(
                                      color: theme.textSecondary,
                                      fontWeight: FontWeight.normal,
                                    ),
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
  final String district;
  const _ShareButton({
    required this.district,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindLookupBloc, FindLookupState>(
      builder: (context, state) {
        if (state is FindLookupDone) {
          final location = state.lookups.firstWhereOrNull((l) => l.value.same(as: district));
          return IconButton(
            icon: Icon(Icons.share, color: theme.primary),
            onPressed: () async {
              await sl<FirebaseAnalytics>().logEvent(
                name: 'location_share',
                parameters: {
                  'id': context.auth.profile?.identity.id ?? 'anonymous',
                  'name': context.auth.profile?.name.full ?? 'Guest',
                  'location': location?.text ?? '',
                  'urlSlug': location?.value ?? '',
                },
              );
              final result = await Share.share(
                """🌟 Discover the Best, Rated by the Rest! 🌟
🚀 Explore authentic reviews and ratings on Kemon!
💬 Real People. Real Reviews. Make smarter decisions today.
👀 Check out ${location?.text}(https://kemon.com.bd/location/division/$district) now and share your experience with the community!

📲 Join the conversation on Kemon – Bangladesh's Premier Review Platform!

#KemonApp #TrustedReviews #CommunityFirst #RealOpinions""",
              );

              if (result.status == ShareResultStatus.success && context.mounted) {
                result.raw;
                context.successNotification(message: 'Thank you for sharing ${location?.text}');
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
  final String division;
  final String district;
  final String thana;
  final IndustryWithListingCountEntity? industry;
  final CategoryWithListingCountEntity? category;
  final SubCategoryWithListingCountEntity? subCategory;
  final RatingRange ratings;
  final Function(
          IndustryWithListingCountEntity?, CategoryWithListingCountEntity?, SubCategoryWithListingCountEntity?, RatingRange)
      onSelect;

  const _FilterButton({
    required this.division,
    required this.district,
    required this.thana,
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
            Icon(Icons.filter_alt_outlined, size: Dimension.radius.twenty, color: theme.backgroundPrimary),
            Text(
              'Filter',
              style: context.text.labelMedium?.copyWith(
                color: theme.backgroundPrimary,
                fontWeight: FontWeight.bold,
              ),
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
          builder: (_) => SortBusinessesByLocationWidget(
            selection: sort,
          ),
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
              style: context.text.labelMedium?.copyWith(
                color: theme.link,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NameWidget extends StatelessWidget {
  final String urlSlug;
  final TextStyle? style;
  final int? maxLines;
  const _NameWidget({
    required this.urlSlug,
    this.style,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindLookupBloc, FindLookupState>(
      builder: (context, state) {
        if (state is FindLookupDone) {
          final location = state.lookups.firstWhereOrNull((l) => l.value.same(as: urlSlug));
          return Text(
            location?.text ?? urlSlug,
            style: style,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          );
        }
        return Text(
          urlSlug,
          style: style,
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
                style: context.text.headlineSmall?.copyWith(
                  color: theme.textSecondary,
                  fontWeight: FontWeight.normal,
                  height: 1.0,
                ),
              ),
              Text(
                "Results",
                style: context.text.labelSmall?.copyWith(
                  color: theme.textSecondary,
                  fontWeight: FontWeight.normal,
                  height: 1.0,
                ),
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

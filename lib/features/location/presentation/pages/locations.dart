import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';
import '../../location.dart';

class LocationsPage extends StatefulWidget {
  static const String path = '/locations';
  static const String name = 'LocationsPage';

  const LocationsPage({
    super.key,
  });

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final divisionBloc = sl<FindLookupBloc>()..add(FindLookup(lookup: Lookups.division));

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
                final double collapsedHeight = kToolbarHeight + Dimension.padding.vertical.medium;
                final double expandedHeight = context.topInset + kToolbarHeight + Dimension.size.vertical.fortyEight;
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
                              'Locations',
                              style: TextStyles.bigHeadline(context: context, color: theme.textPrimary).copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimension.radius.sixteen,
                              ),
                            ).animate().fade(),
                      centerTitle: false,
                      actions: [
                        const _ShareButton(),
                      ],
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
                                            'Locations',
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
                                            Icons.push_pin_rounded,
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
                                        // _TotalCount(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : null,
                    ),
                    SliverToBoxAdapter(
                      child: BlocProvider.value(
                        value: divisionBloc,
                        child: BlocBuilder<FindLookupBloc, FindLookupState>(
                          builder: (context, state) {
                            if (state is FindLookupDone) {
                              final divisions = state.lookups;
                              return divisions.isNotEmpty
                                  ? ListView.separated(
                                      cacheExtent: 0,
                                      itemBuilder: (_, index) {
                                        final division = divisions.elementAt(index);
                                        return _DivisionItem(division: division);
                                      },
                                      separatorBuilder: (_, __) => SizedBox(height: Dimension.padding.vertical.medium),
                                      itemCount: divisions.length,
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
                            }
                            return Container();
                          },
                        ),
                      ),
                    ),
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
👀 Check out Locations(https://kemon.com.bd/category/category) now and share your experience with the community!

📲 Join the conversation on Kemon – Bangladesh's Premier Review Platform!

#KemonApp #TrustedReviews #CommunityFirst #RealOpinions""",
        );

        if (result.status == ShareResultStatus.success && context.mounted) {
          result.raw;
          context.successNotification(message: 'Thank you for sharing Locations.');
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
              BlocProvider.value(value: context.read<FindLocationBloc>()),
            ],
            child: const FilterBusinessesByLocationWidget(),
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
              BlocProvider.value(value: context.read<FindLocationBloc>()),
            ],
            child: const SortBusinessesByLocationWidget(),
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

class _DivisionItem extends StatelessWidget {
  final LookupEntity division;
  const _DivisionItem({
    required this.division,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return ExpansionTile(
      tilePadding: EdgeInsets.all(0),
      childrenPadding: EdgeInsets.all(0),
      leading: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: theme.backgroundTertiary),
          borderRadius: BorderRadius.circular(Dimension.radius.eight),
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimension.radius.eight),
          child: Icon(
            Icons.push_pin_rounded,
            size: Dimension.radius.sixteen,
            color: theme.backgroundTertiary,
          ),
        ),
      ),
      title: Text(
        division.text,
        style: TextStyles.headline(context: context, color: theme.textPrimary).copyWith(
          fontWeight: FontWeight.bold,
          fontSize: Dimension.radius.sixteen,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: Dimension.padding.horizontal.large),
            Icon(
              Icons.subdirectory_arrow_right_rounded,
              size: Dimension.radius.thirtyTwo,
              color: theme.backgroundSecondary,
            ),
            Expanded(
              child: BlocProvider(
                create: (_) => sl<FindLookupBloc>()
                  ..add(
                    FindLookupWithParent(lookup: Lookups.district, parent: division.value),
                  ),
                child: BlocBuilder<FindLookupBloc, FindLookupState>(
                  builder: (context, state) {
                    if (state is FindLookupDone) {
                      final districts = state.lookups;
                      return ListView.separated(
                        cacheExtent: 0,
                        itemBuilder: (_, index) {
                          final district = districts.elementAt(index);
                          return _DistrictItem(district: district);
                        },
                        separatorBuilder: (_, __) => Divider(height: Dimension.padding.vertical.small),
                        itemCount: districts.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: EdgeInsets.all(Dimension.radius.sixteen).copyWith(
                          left: Dimension.padding.horizontal.small,
                          top: 0,
                          right: 0,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _DistrictItem extends StatelessWidget {
  final LookupEntity district;
  const _DistrictItem({
    required this.district,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return ExpansionTile(
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      tilePadding: EdgeInsets.all(0),
      childrenPadding: EdgeInsets.all(0),
      leading: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: theme.backgroundTertiary),
          borderRadius: BorderRadius.circular(Dimension.radius.eight),
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimension.radius.six),
          child: Icon(
            Icons.place_rounded,
            size: Dimension.radius.sixteen,
            color: theme.backgroundTertiary,
          ),
        ),
      ),
      title: Text(
        district.text,
        style: TextStyles.headline(context: context, color: theme.textPrimary).copyWith(
          fontWeight: FontWeight.bold,
          fontSize: Dimension.radius.fourteen,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: Dimension.padding.horizontal.large),
            Icon(
              Icons.subdirectory_arrow_right_rounded,
              size: Dimension.radius.thirtyTwo,
              color: theme.backgroundSecondary,
            ),
            Expanded(
              child: BlocProvider(
                create: (_) => sl<FindLookupBloc>()
                  ..add(
                    FindLookupWithParent(lookup: Lookups.thana, parent: district.value),
                  ),
                child: BlocBuilder<FindLookupBloc, FindLookupState>(
                  builder: (context, state) {
                    if (state is FindLookupDone) {
                      final thanas = state.lookups;
                      return ListView.separated(
                        cacheExtent: 0,
                        itemBuilder: (_, index) {
                          final thana = thanas.elementAt(index);
                          final child = InkWell(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());

                              context.pushNamed(
                                LocationPage.name,
                                pathParameters: {
                                  'urlSlug': thana.value,
                                },
                              );
                            },
                            borderRadius: BorderRadius.circular(Dimension.radius.eight),
                            overlayColor: WidgetStatePropertyAll(theme.backgroundSecondary),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: theme.backgroundSecondary,
                                    border: Border.all(width: 1, color: theme.backgroundTertiary),
                                    borderRadius: BorderRadius.circular(Dimension.radius.eight),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Padding(
                                    padding: EdgeInsets.all(Dimension.radius.four),
                                    child: Icon(
                                      Icons.near_me_rounded,
                                      size: Dimension.radius.sixteen,
                                      color: theme.backgroundTertiary,
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimension.padding.horizontal.medium),
                                Expanded(
                                  child: Text(
                                    thana.text,
                                    style: TextStyles.body(context: context, color: theme.textPrimary),
                                  ),
                                ),
                                SizedBox(width: Dimension.padding.horizontal.medium),
                                Padding(
                                  padding: EdgeInsets.all(Dimension.radius.four).copyWith(right: 0),
                                  child: Icon(
                                    Icons.open_in_new_rounded,
                                    size: Dimension.radius.sixteen,
                                    color: theme.backgroundTertiary,
                                  ),
                                )
                              ],
                            ),
                          );
                          return child;
                        },
                        separatorBuilder: (_, __) => Divider(height: Dimension.padding.vertical.large),
                        itemCount: thanas.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: EdgeInsets.all(Dimension.radius.sixteen).copyWith(
                          left: Dimension.padding.horizontal.small,
                          top: Dimension.padding.vertical.medium,
                          right: 0,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

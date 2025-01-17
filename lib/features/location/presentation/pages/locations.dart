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
    final isExpanded = controller.offset <= kToolbarHeight - (Platform.isAndroid ? Dimension.padding.vertical.small : 0);
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
                final double expandedHeight =
                    context.topInset + kToolbarHeight + (Platform.isAndroid ? Dimension.padding.vertical.small : 0);
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
                              style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(
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
                                            style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(
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
                                          style: TextStyles.overline(context: context, color: theme.backgroundTertiary),
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
👀 Check out Locations(https://kemon.com.bd/locations) now and share your experience with the community!

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
      title: Text.rich(
        TextSpan(
          text: '',
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.aboveBaseline,
              baseline: TextBaseline.alphabetic,
              child: Text(
                division.text,
                style: TextStyles.subTitle(context: context, color: theme.textPrimary).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimension.radius.sixteen,
                ),
              ),
            ),
            WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.small)),
            WidgetSpan(
              child: IconButton(
                padding: EdgeInsets.all(4),
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                iconSize: Dimension.radius.twenty,
                constraints: BoxConstraints(
                  maxHeight: Dimension.radius.twenty,
                  maxWidth: Dimension.radius.twenty,
                ),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());

                  context.pushNamed(
                    LocationPage.name,
                    extra: division,
                    pathParameters: {
                      'urlSlug': division.value,
                    },
                    queryParameters: {
                      'division': division.value,
                    },
                  );
                },
                icon: Icon(Icons.open_in_new_rounded, size: Dimension.radius.sixteen),
              ),
            )
          ],
        ),
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
                          return _DistrictItem(district: district, division: division);
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
  final LookupEntity division;
  final LookupEntity district;
  const _DistrictItem({
    required this.division,
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
      title: Text.rich(
        TextSpan(
          text: '',
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.aboveBaseline,
              baseline: TextBaseline.alphabetic,
              child: Text(
                district.text,
                style: TextStyles.subTitle(context: context, color: theme.textPrimary).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimension.radius.fourteen,
                ),
              ),
            ),
            WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.small)),
            WidgetSpan(
              child: IconButton(
                padding: EdgeInsets.all(4),
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                iconSize: Dimension.radius.twenty,
                constraints: BoxConstraints(
                  maxHeight: Dimension.radius.twenty,
                  maxWidth: Dimension.radius.twenty,
                ),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());

                  context.pushNamed(
                    LocationPage.name,
                    extra: district,
                    pathParameters: {
                      'urlSlug': district.value,
                    },
                    queryParameters: {
                      'division': division.value,
                      'district': district.value,
                    },
                  );
                },
                icon: Icon(Icons.open_in_new_rounded, size: Dimension.radius.fourteen),
              ),
            )
          ],
        ),
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
                                extra: thana,
                                pathParameters: {
                                  'urlSlug': thana.value,
                                },
                                queryParameters: {
                                  'division': division.value,
                                  'district': district.value,
                                  'thana': thana.value,
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

import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
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
  final controller = ScrollController();
  final expanded = ValueNotifier<bool>(true);

  void _scrollListener() {
    final isExpanded = controller.offset <= kToolbarHeight;
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
                return BlocBuilder<FindAllLocationsBloc, FindAllLocationsState>(
                  builder: (context, state) {
                    if (state is FindAllLocationsDone) {
                      return CustomScrollView(
                        cacheExtent: 0,
                        controller: controller,
                        slivers: [
                          SliverAppBar(
                            pinned: true,
                            scrolledUnderElevation: 1,
                            shadowColor: theme.backgroundSecondary,
                            collapsedHeight: kToolbarHeight,
                            expandedHeight: 94,
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
                                : Text(
                                    'Locations',
                                    style: context.text.titleLarge?.copyWith(color: theme.textPrimary),
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
                                                  style: context.text.headlineSmall?.copyWith(
                                                    color: theme.textPrimary,
                                                    fontWeight: FontWeight.bold,
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
                            child: state.divisions.isNotEmpty
                                ? ListView.separated(
                                    cacheExtent: 0,
                                    itemBuilder: (_, index) {
                                      final division = state.divisions.elementAt(index);
                                      return _DivisionItem(division: division);
                                    },
                                    separatorBuilder: (_, __) => SizedBox(height: Dimension.padding.vertical.medium),
                                    itemCount: state.divisions.length,
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
                                        style: context.text.bodySmall?.copyWith(
                                          color: theme.textSecondary,
                                          fontWeight: FontWeight.normal,
                                          height: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      );
                    } else if (state is FindAllLocationsLoading) {
                      return Center(child: NetworkingIndicator(dimension: 20, color: theme.backgroundTertiary));
                    }
                    return Container();
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
  final DivisionWithListingCountEntity division;
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
          padding: EdgeInsets.all(Dimension.radius.six),
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
              alignment: PlaceholderAlignment.middle,
              baseline: TextBaseline.ideographic,
              child: Text(
                division.name.full,
                style: context.text.bodyLarge?.copyWith(
                  color: theme.textPrimary,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            ),
            WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.small)),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              baseline: TextBaseline.ideographic,
              child: Text(
                "(${division.count})",
                style: context.text.bodySmall?.copyWith(
                  color: theme.textSecondary,
                  fontWeight: FontWeight.normal,
                  height: 1.0,
                ),
              ),
            ),
            WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.small)),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              baseline: TextBaseline.ideographic,
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
                    DivisionPage.name,
                    pathParameters: {
                      'division': division.urlSlug,
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
            SizedBox(width: Dimension.padding.horizontal.medium),
            Icon(
              Icons.subdirectory_arrow_right_rounded,
              size: Dimension.radius.thirtyTwo,
              color: theme.backgroundSecondary,
            ),
            Expanded(
              child: ListView.separated(
                cacheExtent: 0,
                itemBuilder: (_, index) {
                  final district = division.districts.elementAt(index);
                  return _DistrictItem(district: district, division: division);
                },
                separatorBuilder: (_, __) => Divider(height: Dimension.padding.vertical.small),
                itemCount: division.districts.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: EdgeInsets.all(Dimension.radius.sixteen).copyWith(
                  left: Dimension.padding.horizontal.small,
                  top: 0,
                  right: 0,
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
  final DivisionWithListingCountEntity division;
  final DistrictWithListingCountEntity district;
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
              alignment: PlaceholderAlignment.middle,
              baseline: TextBaseline.ideographic,
              child: Text(
                district.name.full,
                style: context.text.bodyLarge?.copyWith(
                  color: theme.textPrimary,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            ),
            WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.small)),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              baseline: TextBaseline.ideographic,
              child: Text(
                "(${district.count})",
                style: context.text.bodySmall?.copyWith(
                  color: theme.textSecondary,
                  fontWeight: FontWeight.normal,
                  height: 1.0,
                ),
              ),
            ),
            WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.small)),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              baseline: TextBaseline.ideographic,
              child: IconButton(
                padding: EdgeInsets.all(0),
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                iconSize: Dimension.radius.twenty,
                constraints: BoxConstraints(
                  maxHeight: Dimension.radius.twenty,
                  maxWidth: Dimension.radius.twenty,
                ),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());

                  context.pushNamed(
                    DistrictPage.name,
                    pathParameters: {
                      'division': division.urlSlug,
                      'district': district.urlSlug,
                    },
                  );
                },
                icon: Icon(
                  Icons.open_in_new_rounded,
                  size: Dimension.radius.fourteen,
                  color: theme.primary,
                ),
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
              child: ListView.separated(
                cacheExtent: 0,
                itemBuilder: (_, index) {
                  final thana = district.thanas.elementAt(index);
                  final child = Row(
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
                        child: Text.rich(
                          TextSpan(
                            text: '',
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                baseline: TextBaseline.ideographic,
                                child: Text(
                                  thana.name.full,
                                  style: context.text.bodyMedium?.copyWith(
                                    color: theme.textPrimary,
                                    fontWeight: FontWeight.normal,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                              WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.small)),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                baseline: TextBaseline.ideographic,
                                child: Text(
                                  "(${thana.count})",
                                  style: context.text.bodySmall?.copyWith(
                                    color: theme.textSecondary,
                                    fontWeight: FontWeight.normal,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                              WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.small)),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                baseline: TextBaseline.ideographic,
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
                                      ThanaPage.name,
                                      pathParameters: {
                                        'division': division.urlSlug,
                                        'district': district.urlSlug,
                                        'thana': thana.urlSlug,
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.open_in_new_rounded,
                                    size: Dimension.radius.fourteen,
                                    color: theme.primary,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                  return child;
                },
                separatorBuilder: (_, __) => Divider(height: Dimension.padding.vertical.medium),
                itemCount: district.thanas.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: EdgeInsets.all(Dimension.radius.sixteen).copyWith(
                  left: Dimension.padding.horizontal.small,
                  top: Dimension.padding.vertical.medium,
                  right: 0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LocationPage {
  static const String path = '/location/:urlSlug';
  static const String name = 'LocationPage';
}

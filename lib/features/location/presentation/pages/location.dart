import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../home/home.dart';
import '../../../lookup/lookup.dart';
import '../../location.dart';

class LocationPage extends StatefulWidget {
  static const String path = '/location/:urlSlug';
  static const String name = 'LocationPage';
  final String urlSlug;
  final LookupEntity? location;
  final String? division;
  final String? district;
  final String? thana;

  const LocationPage({
    super.key,
    required this.urlSlug,
    required this.division,
    required this.district,
    required this.thana,
    required this.location,
  });

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController search = TextEditingController();

  final controller = ScrollController();
  final expanded = ValueNotifier<bool>(true);

  void _scrollListener() {
    final isExpanded = controller.offset <=
        (context.topInset - (Platform.isAndroid ? Dimension.padding.vertical.small : 0) + Dimension.size.vertical.oneTwelve) -
            kToolbarHeight;
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
        'urlSlug': widget.urlSlug,
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
          child: BlocListener<LocationListingsFilterBloc, LocationListingsFilterState>(
            listener: (context, state) {
              context.read<FindBusinessesByLocationBloc>().add(
                    RefreshBusinessesByLocation(
                      division: state.division,
                      district: state.district,
                      thana: state.thana,
                      sub: state.subCategory,
                      category: state.category,
                      ratings: state.rating.stars,
                      location: widget.urlSlug,
                    ),
                  );
            },
            child: Scaffold(
              body: ValueListenableBuilder<bool>(
                valueListenable: expanded,
                builder: (context, isExpanded, _) {
                  final appBar = SliverAppBar(
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
                            urlSlug: widget.urlSlug,
                            location: widget.location,
                            division: widget.division,
                            district: widget.district,
                            thana: widget.thana,
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
                            final bloc = context.read<FindBusinessesByLocationBloc>();
                            final filter = bloc.state;

                            bloc.add(FindBusinessesByLocation(
                              location: widget.urlSlug,
                              query: query,
                              sort: filter.sortBy,
                              ratings: filter.ratings,
                              division: widget.division,
                              district: widget.district,
                              thana: widget.thana,
                            ));
                          },
                          onEditingComplete: () async {
                            await sl<FirebaseAnalytics>().logEvent(
                              name: 'listing_search_within_location',
                              parameters: {
                                'id': context.auth.profile?.identity.id ?? 'anonymous',
                                'name': context.auth.profile?.name.full ?? 'Guest',
                                'urlSlug': widget.urlSlug,
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
                                          urlSlug: widget.urlSlug,
                                          location: widget.location,
                                          division: widget.division,
                                          district: widget.district,
                                          thana: widget.thana,
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
                                      _FilterButton(
                                        urlSlug: widget.urlSlug,
                                        division: widget.division,
                                        district: widget.district,
                                        thana: widget.thana,
                                      ),
                                      const SizedBox(width: 16),
                                      _SortButton(
                                        urlSlug: widget.urlSlug,
                                        division: widget.division,
                                        district: widget.district,
                                        thana: widget.thana,
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
                    final hasMore = state.total > businesses.length;

                    return SliverList.separated(
                      addAutomaticKeepAlives: false,
                      separatorBuilder: (context, index) => SizedBox(height: Dimension.padding.vertical.medium),
                      itemBuilder: (context, index) {
                        if (index == businesses.length && hasMore) {
                          if (state is! FindBusinessesByLocationPaginating) {
                            final filter = context.read<LocationListingsFilterBloc>().state;
                            context.read<FindBusinessesByLocationBloc>().add(
                                  PaginateBusinessesByLocation(
                                    page: state.page + 1,
                                    query: search.text,
                                    location: urlSlug,
                                    sort: state.sortBy,
                                    ratings: filter.rating.stars,
                                    division: filter.division,
                                    district: filter.district,
                                    thana: filter.thana,
                                    category: filter.category,
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

                  return BlocBuilder<FindBusinessesByLocationBloc, FindBusinessesByLocationState>(
                    builder: (context, state) {
                      return CustomScrollView(
                        cacheExtent: 0,
                        controller: controller,
                        slivers: [
                          appBar,
                          if (state is FindBusinessesByLocationLoading) shimmer,
                          if (state is FindBusinessesByLocationLoading) shimmer,
                          if (state is FindBusinessesByLocationDone) done(state, widget.urlSlug),
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
    return BlocBuilder<FindLocationBloc, FindLocationState>(
      builder: (context, state) {
        if (state is FindLocationDone) {
          final location = state.location;
          return IconButton(
            icon: Icon(Icons.share, color: theme.primary),
            onPressed: () async {
              await sl<FirebaseAnalytics>().logEvent(
                name: 'location_share',
                parameters: {
                  'id': context.auth.profile?.identity.id ?? 'anonymous',
                  'name': context.auth.profile?.name.full ?? 'Guest',
                  'location': location.name.full,
                  'urlSlug': location.urlSlug,
                },
              );
              final result = await Share.share(
                """🌟 Discover the Best, Rated by the Rest! 🌟
🚀 Explore authentic reviews and ratings on Kemon!
💬 Real People. Real Reviews. Make smarter decisions today.
👀 Check out ${location.name.full}(https://kemon.com.bd/location/${location.urlSlug}) now and share your experience with the community!

📲 Join the conversation on Kemon – Bangladesh's Premier Review Platform!

#KemonApp #TrustedReviews #CommunityFirst #RealOpinions""",
              );

              if (result.status == ShareResultStatus.success && context.mounted) {
                result.raw;
                context.successNotification(message: 'Thank you for sharing ${location.name.full}');
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
  final String? division;
  final String? district;
  final String? thana;
  const _FilterButton({
    required this.urlSlug,
    required this.division,
    required this.district,
    required this.thana,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return InkWell(
      onTap: () async {
        if (!context.mounted) return;
        showModalBottomSheet(
          context: context,
          backgroundColor: theme.backgroundPrimary,
          barrierColor: context.barrierColor,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<FindBusinessesByLocationBloc>()),
              BlocProvider.value(value: context.read<LocationListingsFilterBloc>()),
              BlocProvider.value(value: context.read<FindLocationBloc>()),
            ],
            child: LocationListingsFilter(
              division: division,
              district: district,
              thana: thana,
            ),
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
  final String urlSlug;
  final String? division;
  final String? district;
  final String? thana;
  const _SortButton({
    required this.urlSlug,
    required this.division,
    required this.district,
    required this.thana,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return InkWell(
      onTap: () async {
        await sl<FirebaseAnalytics>().logEvent(
          name: 'listings_by_location_sort',
          parameters: {
            'id': context.auth.profile?.identity.id ?? 'anonymous',
            'name': context.auth.profile?.name.full ?? 'Guest',
            'urlSlug': urlSlug,
          },
        );
        if (!context.mounted) return;
        showModalBottomSheet(
          context: context,
          backgroundColor: theme.backgroundPrimary,
          barrierColor: context.barrierColor,
          isScrollControlled: true,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<FindBusinessesByLocationBloc>()),
              BlocProvider.value(value: context.read<FindLocationBloc>()),
            ],
            child: SortBusinessesByLocationWidget(
              urlSlug: urlSlug,
              division: division,
              district: district,
              thana: thana,
            ),
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
  final LookupEntity? location;
  final String? division;
  final String? district;
  final String? thana;
  final double? fontSize;
  final int? maxLines;
  const _NameWidget({
    required this.urlSlug,
    required this.location,
    required this.division,
    required this.district,
    required this.thana,
    this.fontSize,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindLocationBloc, FindLocationState>(
      builder: (context, state) {
        if (state is FindLocationDone) {
          final location = state.location;
          return Text(
            location.name.full,
            style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? Dimension.radius.twelve,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          );
        }
        return Text(
          location?.text ?? '',
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

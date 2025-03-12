import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../../profile/profile.dart';
import '../../leaderboard.dart';

class LeaderboardPage extends StatefulWidget {
  static const String path = '/leaderboard';
  static const String name = 'LeaderboardPage';
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final TextEditingController search = TextEditingController();
  LeaderboardFilter filter = LeaderboardFilter.monthly;

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
    sl<FirebaseAnalytics>().logScreenView(
      screenName: 'Leaderboard',
      parameters: {
        'id': context.auth.profile?.identity.id ?? 'anonymous',
        'name': context.auth.profile?.name.full ?? 'Guest',
      },
    );
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
                              "Leaderboard",
                              style: TextStyles.title(context: context, color: theme.textPrimary)
                                  .copyWith(fontSize: Dimension.radius.twenty),
                            ).animate().fade(),
                      actions: [
                        const ShareButton(),
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
                              context.read<FindLeaderboardBloc>().add(FindLeaderboard(query: query));
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                size: Dimension.radius.sixteen,
                                color: theme.textSecondary,
                              ),
                              hintText: 'Search by name or email',
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
                                        Text(
                                          "Leaderboard",
                                          style: TextStyles.title(context: context, color: theme.textPrimary)
                                              .copyWith(fontSize: Dimension.radius.twentyFour),
                                        ).animate().fade(),
                                        IconWidget(),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        _FilterButton(search: search),
                                        const SizedBox(width: 16),
                                        const Spacer(),
                                        TotalCount(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : null,
                    ),
                    SliverToBoxAdapter(child: ListingsWidget(search: search)),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget filterBuilder({
    required String label,
    required bool selected,
    required ThemeScheme theme,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          label,
          style: TextStyles.subTitle(
            context: context,
            color: selected ? theme.white : theme.semiBlack,
          ).copyWith(
            fontWeight: selected ? FontWeight.bold : FontWeight.w100,
          ),
        ),
      );
}

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

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
👀 Check out Leaderboard(https://kemon.com.bd/leaderboard) now and share your experience with the community!

📲 Join the conversation on Kemon – Bangladesh's Premier Review Platform!

#KemonApp #TrustedReviews #CommunityFirst #RealOpinions""",
        );

        if (result.status == ShareResultStatus.success && context.mounted) {
          result.raw;
          context.successNotification(message: 'Thank you for sharing Leaderboard');
        }
      },
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
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
        Icons.workspace_premium_rounded,
        size: Dimension.radius.twenty,
        color: theme.backgroundTertiary,
      ),
    );
  }
}

class TotalCount extends StatelessWidget {
  const TotalCount({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindLeaderboardBloc, FindLeaderboardState>(
      builder: (context, state) {
        if (state is FindLeaderboardDone) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.leaders.length.toString(),
                style: TextStyles.subTitle(context: context, color: theme.textPrimary),
              ),
              Text(
                "Participants",
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

class ListingsWidget extends StatelessWidget {
  final TextEditingController search;

  const ListingsWidget({
    super.key,
    required this.search,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindLeaderboardBloc, FindLeaderboardState>(
      builder: (context, state) {
        if (state is FindLeaderboardLoading) {
          return ListView.separated(
            itemBuilder: (_, index) {
              return Container(
                decoration: BoxDecoration(
                  color: theme.backgroundSecondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimension.padding.horizontal.max,
                  vertical: Dimension.padding.vertical.medium,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShimmerIcon(radius: Dimension.radius.twelve),
                    SizedBox(width: Dimension.padding.horizontal.medium),
                    ShimmerIcon(radius: Dimension.radius.twentyFour),
                    SizedBox(width: Dimension.padding.horizontal.medium),
                    ShimmerLabel(
                      width: Dimension.size.horizontal.sixtyFour,
                      height: Dimension.size.vertical.twelve,
                    ),
                    Spacer(),
                    const SizedBox(width: 16),
                    ShimmerLabel(
                      width: Dimension.size.horizontal.twentyFour,
                      height: Dimension.size.vertical.twelve,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: Dimension.padding.vertical.medium),
            itemCount: 10,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            padding: EdgeInsets.zero.copyWith(bottom: Dimension.padding.vertical.max + context.bottomInset),
          );
        } else if (state is FindLeaderboardDone) {
          final participants = state.leaders;

          return participants.isNotEmpty
              ? ListView.separated(
                  cacheExtent: 0,
                  itemBuilder: (_, index) {
                    final leader = participants[index];
                    final fallback = Center(
                      child: Text(
                        leader.name.symbol,
                        style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(
                          fontSize: Dimension.radius.twelve,
                        ),
                      ),
                    );
                    return InkWell(
                      onTap: () {
                        context.pushNamed(
                          PublicProfilePage.name,
                          pathParameters: {'user': leader.identity.guid},
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.backgroundSecondary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimension.padding.horizontal.max,
                          vertical: Dimension.padding.vertical.large,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (leader.rank < 3)
                              SvgPicture.asset(
                                'images/medal/${leader.rank == 0 ? 'gold' : leader.rank == 1 ? 'silver' : 'bronze'}.svg',
                                width: Dimension.radius.twentyFour,
                                height: Dimension.radius.twentyFour,
                                fit: BoxFit.cover,
                              ),
                            if (leader.rank >= 3)
                              Container(
                                width: Dimension.radius.twentyFour,
                                height: Dimension.radius.twentyFour,
                                alignment: Alignment.center,
                                child: Text(
                                  '${leader.rank + 1}',
                                  style: TextStyles.overline(context: context, color: theme.textPrimary),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            SizedBox(width: Dimension.padding.horizontal.medium),
                            Container(
                              width: Dimension.radius.twentyFour,
                              height: Dimension.radius.twentyFour,
                              decoration: BoxDecoration(
                                color: theme.backgroundSecondary,
                                borderRadius: BorderRadius.circular(Dimension.radius.eight),
                                border: Border.all(
                                  color: theme.textSecondary,
                                  width: .15,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: leader.avatar.isEmpty
                                  ? fallback
                                  : CachedNetworkImage(
                                      imageUrl: leader.avatar.url,
                                      width: Dimension.radius.twentyFour,
                                      height: Dimension.radius.twentyFour,
                                      fit: BoxFit.cover,
                                      placeholder: (_, __) => ShimmerIcon(radius: Dimension.radius.twentyFour),
                                      errorWidget: (_, __, ___) => fallback,
                                    ),
                            ),
                            SizedBox(width: Dimension.padding.horizontal.medium),
                            Expanded(
                              child: Text(
                                leader.name.full,
                                style: TextStyles.body(context: context, color: theme.textPrimary),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              NumberFormat('###,###,###,###').format(leader.point),
                              style: TextStyles.body(context: context, color: theme.textPrimary),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: Dimension.padding.vertical.medium),
                  itemCount: participants.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.all(Dimension.radius.sixteen).copyWith(
                    top: 0,
                    bottom: Dimension.padding.vertical.max + context.bottomInset,
                  ),
                )
              : Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: context.height * .25),
                    child: Text(
                      "No leaders found :(",
                      style: TextStyles.overline(context: context, color: theme.backgroundTertiary),
                    ),
                  ),
                );
        } else if (state is FindLeaderboardError) {
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

class _FilterButton extends StatelessWidget {
  final TextEditingController search;

  const _FilterButton({
    required this.search,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return InkWell(
      onTap: () async {
        final bool? applied = await showModalBottomSheet(
          context: context,
          backgroundColor: theme.backgroundPrimary,
          barrierColor: context.barrierColor,
          isScrollControlled: true,
          builder: (_) => const LeaderboardFilterWidget(),
        );

        if (!context.mounted) return;

        if (applied ?? false) {
          context.read<FindLeaderboardBloc>().add(RefreshLeaderboard(query: search.text));
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

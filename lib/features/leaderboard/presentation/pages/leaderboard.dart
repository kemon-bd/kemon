import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
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
                          /* (Platform.isIOS ?  */ Dimension
                              .size.vertical.twenty /*  : 0) */,
                      expandedHeight: context.topInset +
                          kToolbarHeight +
                          /* (Platform.isAndroid ? Dimension.size.vertical.twenty : 0) + */
                          Dimension.size.vertical.oneTwelve,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: theme.primary),
                        onPressed: context.pop,
                      ),
                      title: isExpanded
                          ? null
                          : Text(
                              "Leaderboard",
                              style: TextStyles.bigHeadline(
                                      context: context,
                                      color: theme.textPrimary)
                                  .copyWith(fontSize: Dimension.radius.twenty),
                            ).animate().fade(),
                      actions: [
                        const ShareButton(),
                      ],
                      bottom: PreferredSize(
                        preferredSize:
                            Size.fromHeight(Dimension.size.vertical.twenty),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimension.padding.horizontal.max,
                            vertical: Dimension.padding.vertical.large,
                          ).copyWith(top: 0),
                          child: TextField(
                            controller: search,
                            style: TextStyles.body(
                                context: context, color: theme.textPrimary),
                            onChanged: (query) {
                              final bloc = context.read<FindLeaderboardBloc>();
                              final filter = bloc.state;

                              bloc.add(
                                FindLeaderboard(
                                  query: query,
                                  from: filter.from,
                                  to: filter.to,
                                ),
                              );
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                size: Dimension.radius.sixteen,
                                color: theme.textSecondary,
                              ),
                              hintText: 'Find company or products...',
                              hintStyle: TextStyles.body(
                                  context: context, color: theme.textSecondary),
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
                                ).copyWith(
                                    top: context.topInset + kToolbarHeight),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Leaderboard",
                                          style: TextStyles.bigHeadline(
                                                  context: context,
                                                  color: theme.textPrimary)
                                              .copyWith(
                                                  fontSize: Dimension
                                                      .radius.twentyFour),
                                        ).animate().fade(),
                                        IconWidget(),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        SortButton(),
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

  Widget firstPlace() {
    final theme = context.read<ThemeBloc>().state.scheme;
    const goldColor = Color(0xFFFFD700);
    final key = GlobalKey();
    return Stack(
      children: [
        Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                key: key,
                width: context.width,
                height: 159,
                padding: const EdgeInsets.all(0).copyWith(top: 39, bottom: 12),
                decoration: BoxDecoration(
                  color: theme.positiveBackgroundTertiary,
                  borderRadius: BorderRadius.circular(32).copyWith(
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.semiBlack,
                      offset: const Offset(0, 4),
                      blurRadius: 16,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Omar',
                      style: TextStyles.body(
                              context: context, color: theme.textPrimary)
                          .copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '1893',
                      style:
                          TextStyles.title(context: context, color: theme.link),
                    ),
                    Text(
                      '@omar',
                      style: TextStyles.caption(
                          context: context, color: theme.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 159 - 32,
              child: Center(
                child: Container(
                  width: 68,
                  height: 68,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: goldColor,
                      width: 3,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: goldColor,
                        offset: Offset(0, 4),
                        blurRadius: 16,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200',
                    fit: BoxFit.cover,
                    width: 68,
                    height: 68,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 159 + 42,
              child: Center(
                child:
                    FaIcon(FontAwesomeIcons.crown, color: goldColor, size: 32),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget secondPlace() {
    final theme = context.read<ThemeBloc>().state.scheme;
    const silverColor = Color(0xFFD9DADB);
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            width: context.width,
            height: 113,
            padding: const EdgeInsets.all(0).copyWith(top: 32, bottom: 8),
            decoration: BoxDecoration(
              color: theme.positiveBackgroundTertiary,
              borderRadius: BorderRadius.circular(16).copyWith(
                topRight: Radius.zero,
                bottomRight: Radius.zero,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.semiBlack,
                  offset: const Offset(0, 4),
                  blurRadius: 16,
                  spreadRadius: 0,
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Omar',
                  style: TextStyles.body(
                      context: context, color: theme.textPrimary),
                ),
                Text(
                  '1893',
                  style: TextStyles.title(context: context, color: theme.link),
                ),
                Text(
                  '@omar',
                  style: TextStyles.caption(
                      context: context, color: theme.textSecondary),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 113 - 28,
          child: Center(
            child: Container(
              width: 68,
              height: 68,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: silverColor,
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: silverColor,
                    offset: Offset(0, 4),
                    blurRadius: 16,
                    spreadRadius: 0,
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl:
                    'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200',
                fit: BoxFit.cover,
                width: 68,
                height: 68,
              ),
            ),
          ),
        ),
        const Positioned(
          left: 0,
          right: 0,
          bottom: 113 + 39 + 9,
          child: Center(
            child: FaIcon(FontAwesomeIcons.crown, color: silverColor, size: 24),
          ),
        ),
      ],
    );
  }

  Widget thirdPlace() {
    final theme = context.read<ThemeBloc>().state.scheme;
    const bronzeColor = Color(0xFFCD7F32);
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            width: context.width,
            height: 113,
            padding: const EdgeInsets.all(0).copyWith(top: 32, bottom: 8),
            decoration: BoxDecoration(
              color: theme.positiveBackgroundTertiary,
              borderRadius: BorderRadius.circular(12).copyWith(
                topLeft: Radius.zero,
                bottomLeft: Radius.zero,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.semiBlack,
                  offset: const Offset(0, 4),
                  blurRadius: 16,
                  spreadRadius: 0,
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Omar',
                  style: TextStyles.body(
                      context: context, color: theme.textPrimary),
                ),
                Text(
                  '1893',
                  style: TextStyles.title(context: context, color: theme.link),
                ),
                Text(
                  '@omar',
                  style: TextStyles.caption(
                      context: context, color: theme.textSecondary),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 113 - 28,
          child: Center(
            child: Container(
              width: 68,
              height: 68,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: bronzeColor,
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: bronzeColor,
                    offset: Offset(0, 4),
                    blurRadius: 16,
                    spreadRadius: 0,
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl:
                    'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200',
                fit: BoxFit.cover,
                width: 68,
                height: 68,
              ),
            ),
          ),
        ),
        const Positioned(
          left: 0,
          right: 0,
          bottom: 113 + 39 + 9,
          child: Center(
            child: FaIcon(FontAwesomeIcons.crown, color: bronzeColor, size: 24),
          ),
        ),
      ],
    );
  }
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
          context.successNotification(
              message: 'Thank you for sharing Leaderboard');
        }
      },
    );
  }
}

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return InkWell(
      onTap: () {
        /* showModalBottomSheet(
          context: context,
          backgroundColor: theme.backgroundPrimary,
          barrierColor: context.barrierColor,
          isScrollControlled: true,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<FindLeaderboardBloc>()),
              BlocProvider.value(value: context.read<FindCategoryBloc>()),
            ],
            child: const SortBusinessesByCategoryWidget(),
          ),
        ); */
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
            Icon(Icons.swap_vert_rounded,
                size: Dimension.radius.twenty, color: theme.link),
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
        Icons.local_activity,
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
                state.total.toString(),
                style: TextStyles.title(
                    context: context, color: theme.textPrimary),
              ),
              Text(
                "Participients",
                style: TextStyles.body(
                    context: context, color: theme.textSecondary),
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
              return NetworkingIndicator(
                  dimension: Dimension.radius.twentyFour, color: theme.primary);
            },
            separatorBuilder: (_, __) =>
                SizedBox(height: Dimension.padding.vertical.medium),
            itemCount: 10,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            padding: EdgeInsets.zero.copyWith(
                bottom: Dimension.padding.vertical.max + context.bottomInset),
          );
        } else if (state is FindLeaderboardDone) {
          final participients = state.leaders;
          final hasMore = state.total > participients.length;

          return participients.isNotEmpty
              ? ListView.separated(
                  cacheExtent: 0,
                  itemBuilder: (_, index) {
                    if (index == participients.length && hasMore) {
                      if (state is! FindLeaderboardPaginating) {
                        context.read<FindLeaderboardBloc>().add(
                              PaginateLeaderboard(
                                page: state.page + 1,
                                query: search.text,
                                from: DateTime.now(),
                                to: DateTime.now(),
                              ),
                            );
                      }
                      return NetworkingIndicator(
                          dimension: Dimension.radius.twentyFour,
                          color: theme.primary);
                    }
                    final leader = participients[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: theme.positiveBackgroundTertiary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 54,
                            child: Text(
                              '#${index + 1}',
                              style: TextStyles.title(
                                  context: context, color: theme.black),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: BlocProvider(
                              create: (context) => sl<FindProfileBloc>()
                                ..add(FindProfile(identity: leader.identity)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProfileNameWidget(
                                    style: TextStyles.title(
                                        context: context, color: theme.black),
                                  ),
                                  ProfileUsernameWidget(
                                    style: TextStyles.caption(
                                        context: context,
                                        color: theme.semiBlack),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            NumberFormat('###,###,###,###')
                                .format(leader.point),
                            style: TextStyles.subTitle(
                                context: context, color: theme.black),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) =>
                      SizedBox(height: Dimension.padding.vertical.medium),
                  itemCount: participients.length + (hasMore ? 1 : 0),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.zero.copyWith(
                    bottom:
                        Dimension.padding.vertical.max + context.bottomInset,
                  ),
                )
              : Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: context.height * .25),
                    child: Text(
                      "No leaders found :(",
                      style: TextStyles.title(
                          context: context, color: theme.backgroundTertiary),
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

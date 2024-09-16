import '../../../../core/shared/shared.dart';

class LeaderboardPage extends StatefulWidget {
  static const String path = '/leaderboard';
  static const String name = 'LeaderboardPage';
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  LeaderboardFilter filter = LeaderboardFilter.monthly;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.primary,
          appBar: AppBar(
            backgroundColor: theme.primary,
            leading: IconButton(
              onPressed: context.pop,
              icon: Icon(Icons.arrow_back_rounded, color: theme.white),
            ),
            title: Text(
              'Leaderboard',
              style: TextStyles.title(context: context, color: theme.white),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.gift, color: theme.white, size: 20),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: Column(
            children: [
              Container(
                width: context.width,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.positiveBackgroundSecondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: CupertinoSlidingSegmentedControl<LeaderboardFilter>(
                  groupValue: filter,
                  backgroundColor: theme.positiveBackgroundTertiary,
                  thumbColor: theme.primary,
                  padding: const EdgeInsets.all(8),
                  children: {
                    LeaderboardFilter.monthly: filterBuilder(
                      label: 'Monthly',
                      selected: filter == LeaderboardFilter.monthly,
                      theme: theme,
                    ),
                    LeaderboardFilter.yearly: filterBuilder(
                      label: 'Yearly',
                      selected: filter == LeaderboardFilter.yearly,
                      theme: theme,
                    ),
                    LeaderboardFilter.allTime: filterBuilder(
                      label: 'All Time',
                      selected: filter == LeaderboardFilter.allTime,
                      theme: theme,
                    ),
                  },
                  onValueChanged: (selection) {
                    if (selection != null) {
                      setState(() {
                        filter = selection;
                      });
                    }
                  },
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ListView(
                        padding: const EdgeInsets.all(16).copyWith(top: 0),
                        clipBehavior: Clip.antiAlias,
                        children: [
                          SizedBox(
                            width: context.width,
                            height: 113 + 148,
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: secondPlace()),
                                Expanded(flex: 1, child: firstPlace()),
                                Expanded(flex: 1, child: thirdPlace()),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0).copyWith(bottom: 64 + context.bottomInset),
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => const Divider(height: 16, thickness: .1),
                            itemBuilder: (_, index) {
                              final rank = index + 4;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 42,
                                      child: Text(
                                        '#$rank',
                                        style: TextStyles.title(context: context, color: theme.white),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Ranked user $rank',
                                            style: TextStyles.title(context: context, color: theme.white),
                                          ),
                                          Text(
                                            '@user$rank',
                                            style: TextStyles.caption(context: context, color: theme.semiWhite),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      NumberFormat('###,###,###,###').format(99999 - index),
                                      style: TextStyles.subTitle(context: context, color: theme.white),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: 47,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 8 + context.bottomInset,
                      left: 16,
                      right: 16,
                      child: Container(
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
                                '#624',
                                style: TextStyles.title(context: context, color: theme.black),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'YOU',
                                    style: TextStyles.title(context: context, color: theme.black),
                                  ),
                                  Text(
                                    '@username',
                                    style: TextStyles.caption(context: context, color: theme.semiBlack),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              NumberFormat('###,###,###,###').format(6224),
                              style: TextStyles.subTitle(context: context, color: theme.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                      style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '1893',
                      style: TextStyles.title(context: context, color: theme.link),
                    ),
                    Text(
                      '@omar',
                      style: TextStyles.caption(context: context, color: theme.textSecondary),
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
                    imageUrl: 'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200',
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
                child: FaIcon(FontAwesomeIcons.crown, color: goldColor, size: 32),
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
                  style: TextStyles.body(context: context, color: theme.textPrimary),
                ),
                Text(
                  '1893',
                  style: TextStyles.title(context: context, color: theme.link),
                ),
                Text(
                  '@omar',
                  style: TextStyles.caption(context: context, color: theme.textSecondary),
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
                imageUrl: 'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200',
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
                  style: TextStyles.body(context: context, color: theme.textPrimary),
                ),
                Text(
                  '1893',
                  style: TextStyles.title(context: context, color: theme.link),
                ),
                Text(
                  '@omar',
                  style: TextStyles.caption(context: context, color: theme.textSecondary),
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
                imageUrl: 'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200',
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

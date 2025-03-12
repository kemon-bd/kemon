import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../../industry/industry.dart';
import '../../../sub_category/sub_category.dart';
import '../../category.dart';

class CategoriesPage extends StatefulWidget {
  static const String path = '/categories';
  static const String name = 'CategoriesPage';

  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final TextEditingController search = TextEditingController();

  final controller = ScrollController();
  final expanded = ValueNotifier<bool>(true);

  void _scrollListener() {
    final isExpanded = controller.offset <= Dimension.size.vertical.fortyEight;
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
    search.dispose();
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
                final double collapsedHeight = context.topInset +
                    kToolbarHeight +
                    Dimension.padding.vertical.min -
                    (Platform.isIOS ? Dimension.size.vertical.twenty : 0);
                final double expandedHeight = context.topInset +
                    kToolbarHeight +
                    (Platform.isAndroid ? Dimension.size.vertical.twenty : 0) +
                    Dimension.size.vertical.fortyEight;
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
                              'Categories',
                              style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimension.radius.twenty,
                              ),
                            ).animate().fade(),
                      centerTitle: false,
                      actions: [
                        const _ShareButton(),
                      ],
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(Dimension.size.vertical.twenty),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.backgroundPrimary.withAlpha(200),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimension.padding.horizontal.max,
                            vertical: Dimension.padding.vertical.large,
                          ).copyWith(top: 0),
                          child: TextField(
                            controller: search,
                            style: TextStyles.body(context: context, color: theme.textPrimary),
                            onChanged: (query) {
                              context.read<FindAllCategoriesBloc>().add(FindAllCategories(query: query));
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
                                child: Text(
                                  'Categories',
                                  style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimension.radius.twentyFour,
                                  ),
                                ).animate().fade(),
                              ),
                            )
                          : null,
                    ),
                    SliverToBoxAdapter(child: _CategoriesWidget(search: search)),
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
👀 Check out Categories(https://kemon.com.bd/category/category) now and share your experience with the community!

📲 Join the conversation on Kemon – Bangladesh's Premier Review Platform!

#KemonApp #TrustedReviews #CommunityFirst #RealOpinions""",
        );

        if (result.status == ShareResultStatus.success && context.mounted) {
          result.raw;
          context.successNotification(message: 'Thank you for sharing Categories.');
        }
      },
    );
  }
}

class _CategoriesWidget extends StatelessWidget {
  final TextEditingController search;

  const _CategoriesWidget({
    required this.search,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindAllCategoriesBloc, FindAllCategoriesState>(
      builder: (context, state) {
        if (state is FindAllCategoriesLoading) {
          return Center(child: const CircularProgressIndicator());
        } else if (state is FindAllCategoriesDone) {
          return state.industries.isNotEmpty
              ? ListView.separated(
                  cacheExtent: 0,
                  itemBuilder: (_, index) {
                    final industry = state.industries.elementAt(index);
                    final categories = industry.categories;
                    final icon = Padding(
                      padding: EdgeInsets.all(Dimension.radius.eight),
                      child: Icon(
                        Icons.label_rounded,
                        size: Dimension.radius.sixteen,
                        color: theme.backgroundTertiary,
                      ),
                    );
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            industry.icon.url.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: industry.icon.url,
                                    fit: BoxFit.cover,
                                    width: Dimension.radius.thirtyTwo,
                                    height: Dimension.radius.thirtyTwo,
                                    placeholder: (_, __) => ShimmerLabel(
                                      width: Dimension.radius.thirtyTwo,
                                      height: Dimension.radius.thirtyTwo,
                                    ),
                                    errorWidget: (_, __, ___) => icon,
                                  )
                                : icon,
                            SizedBox(width: Dimension.padding.horizontal.large),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: '',
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.aboveBaseline,
                                      baseline: TextBaseline.alphabetic,
                                      child: Text(
                                        industry.name.full,
                                        style: TextStyles.subTitle(context: context, color: theme.textPrimary).copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimension.radius.sixteen,
                                        ),
                                      ),
                                    ),
                                    WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.small)),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.aboveBaseline,
                                      baseline: TextBaseline.ideographic,
                                      child: Text(
                                        " (${industry.listings})",
                                        style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimension.radius.twelve,
                                          height: Dimension.radius.two,
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
                                            IndustryPage.name,
                                            pathParameters: {
                                              'urlSlug': industry.urlSlug,
                                            },
                                            queryParameters: {
                                              'industry': industry.industry.guid,
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.open_in_new_rounded, size: Dimension.radius.sixteen),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (industry.categories.isNotEmpty)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: Dimension.padding.horizontal.small),
                              Icon(
                                Icons.subdirectory_arrow_right_rounded,
                                size: Dimension.radius.twentyFour,
                                color: theme.backgroundSecondary,
                              ),
                              Expanded(
                                child: ListView.separated(
                                  cacheExtent: 0,
                                  itemBuilder: (_, index) {
                                    final category = categories.elementAt(index);
                                    final icon = Padding(
                                      padding: EdgeInsets.all(Dimension.radius.four),
                                      child: Icon(
                                        Icons.category_rounded,
                                        size: Dimension.radius.sixteen,
                                        color: theme.backgroundTertiary,
                                      ),
                                    );
                                    final child = Row(
                                      children: [
                                        category.icon.url.isNotEmpty
                                            ? CachedNetworkImage(
                                                imageUrl: category.icon.url,
                                                width: Dimension.radius.sixteen,
                                                height: Dimension.radius.sixteen,
                                                fit: BoxFit.cover,
                                                placeholder: (_, __) => ShimmerLabel(
                                                  width: Dimension.radius.twentyFour,
                                                  height: Dimension.radius.twentyFour,
                                                ),
                                                errorWidget: (_, __, ___) => icon,
                                              )
                                            : icon,
                                        SizedBox(width: Dimension.padding.horizontal.medium),
                                        Expanded(
                                          child: Text.rich(
                                            TextSpan(
                                              text: '',
                                              children: [
                                                WidgetSpan(
                                                  alignment: PlaceholderAlignment.aboveBaseline,
                                                  baseline: TextBaseline.alphabetic,
                                                  child: Text(
                                                    category.name.full,
                                                    style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(
                                                      fontSize: Dimension.radius.fourteen,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.small)),
                                                WidgetSpan(
                                                  alignment: PlaceholderAlignment.aboveBaseline,
                                                  baseline: TextBaseline.ideographic,
                                                  child: Text(
                                                    " (${category.listings})",
                                                    style:
                                                        TextStyles.body(context: context, color: theme.textSecondary).copyWith(
                                                      fontSize: Dimension.radius.twelve,
                                                      height: Dimension.radius.two,
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
                                                        CategoryPage.name,
                                                        pathParameters: {
                                                          'urlSlug': category.urlSlug,
                                                        },
                                                        queryParameters: {
                                                          'industry': category.industry.guid,
                                                          'category': category.identity.guid,
                                                        },
                                                      );
                                                    },
                                                    icon: Icon(Icons.open_in_new_rounded, size: Dimension.radius.sixteen),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        child,
                                        if (category.subCategories.isNotEmpty)
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(width: Dimension.padding.horizontal.small),
                                              Icon(
                                                Icons.subdirectory_arrow_right_rounded,
                                                size: Dimension.radius.twentyFour,
                                                color: theme.backgroundSecondary,
                                              ),
                                              Expanded(
                                                child: ListView.separated(
                                                  cacheExtent: 0,
                                                  itemBuilder: (_, index) {
                                                    final subCategory = category.subCategories.elementAt(index);
                                                    final icon = Padding(
                                                      padding: EdgeInsets.all(Dimension.radius.four),
                                                      child: Icon(
                                                        Icons.category_rounded,
                                                        size: Dimension.radius.sixteen,
                                                        color: theme.backgroundTertiary,
                                                      ),
                                                    );
                                                    final child = Row(
                                                      children: [
                                                        subCategory.icon.url.isNotEmpty
                                                            ? CachedNetworkImage(
                                                                imageUrl: subCategory.icon.url,
                                                                width: Dimension.radius.sixteen,
                                                                height: Dimension.radius.sixteen,
                                                                fit: BoxFit.cover,
                                                                placeholder: (_, __) => ShimmerLabel(
                                                                  width: Dimension.radius.twentyFour,
                                                                  height: Dimension.radius.twentyFour,
                                                                ),
                                                                errorWidget: (_, __, ___) => icon,
                                                              )
                                                            : icon,
                                                        SizedBox(width: Dimension.padding.horizontal.medium),
                                                        Expanded(
                                                          child: Text.rich(
                                                            TextSpan(
                                                              text: '',
                                                              children: [
                                                                WidgetSpan(
                                                                  alignment: PlaceholderAlignment.aboveBaseline,
                                                                  baseline: TextBaseline.alphabetic,
                                                                  child: Text(
                                                                    subCategory.name.full,
                                                                    style: TextStyles.body(
                                                                            context: context, color: theme.textPrimary)
                                                                        .copyWith(
                                                                      fontSize: Dimension.radius.fourteen,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                WidgetSpan(
                                                                    child: SizedBox(width: Dimension.padding.horizontal.small)),
                                                                WidgetSpan(
                                                                  alignment: PlaceholderAlignment.aboveBaseline,
                                                                  baseline: TextBaseline.ideographic,
                                                                  child: Text(
                                                                    " (${subCategory.listings})",
                                                                    style: TextStyles.body(
                                                                            context: context, color: theme.textSecondary)
                                                                        .copyWith(
                                                                      fontSize: Dimension.radius.twelve,
                                                                      height: Dimension.radius.two,
                                                                    ),
                                                                  ),
                                                                ),
                                                                WidgetSpan(
                                                                    child: SizedBox(width: Dimension.padding.horizontal.small)),
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
                                                                        SubCategoryPage.name,
                                                                        pathParameters: {
                                                                          'urlSlug': subCategory.urlSlug,
                                                                        },
                                                                        queryParameters: {
                                                                          'industry': subCategory.industry.guid,
                                                                          'category': subCategory.category.guid,
                                                                          'subCategory': subCategory.identity.guid,
                                                                        }
                                                                      );
                                                                    },
                                                                    icon: Icon(Icons.open_in_new_rounded,
                                                                        size: Dimension.radius.sixteen),
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
                                                  separatorBuilder: (_, __) =>
                                                      Divider(height: Dimension.padding.vertical.large),
                                                  itemCount: category.subCategories.length,
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
                                  },
                                  separatorBuilder: (_, __) => Divider(height: Dimension.padding.vertical.large),
                                  itemCount: categories.length,
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
                  },
                  separatorBuilder: (_, __) => SizedBox(height: Dimension.padding.vertical.medium),
                  itemCount: state.industries.length,
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
        } else if (state is FindAllCategoriesError) {
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

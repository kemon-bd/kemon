import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../category/category.dart';
import '../../../home/home.dart';
import '../../../industry/industry.dart';
import '../../../review/review.dart';
import '../../../sub_category/sub_category.dart';
import '../../search.dart';

class SearchPage extends StatefulWidget {
  static const String path = '/search';
  static const String name = 'SearchPage';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            backgroundColor: theme.backgroundPrimary,
            surfaceTintColor: theme.backgroundPrimary,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: theme.textPrimary),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(HomePage.name);
                }
              },
            ),
            title: TextField(
              key: Keys.search.suggestion.field,
              autofocus: true,
              controller: controller,
              style: TextStyles.subTitle(context: context, color: theme.textPrimary),
              onChanged: (query) {
                if (query.isNotEmpty) {
                  context.read<SearchSuggestionBloc>().add(SearchSuggestion(query: query));
                } else {
                  context.read<SearchSuggestionBloc>().add(const ResetSuggestion());
                }
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: theme.textSecondary.withAlpha(150)),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                filled: false,
              ),
            ),
            actions: [
              if (controller.text.isNotEmpty)
                IconButton(
                  icon: Icon(Icons.clear_rounded, color: theme.textPrimary),
                  onPressed: () {
                    setState(() {
                      controller.clear();
                    });

                    context.read<SearchSuggestionBloc>().add(const ResetSuggestion());
                  },
                ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: controller.text.isEmpty
              ? null
              : FloatingActionButton.extended(
                  key: Keys.search.suggestion.submit,
                  backgroundColor: theme.primary,
                  onPressed: () {
                    context.pushNamed(
                      ResultPage.name,
                      queryParameters: {
                        'query': controller.text,
                      },
                    );
                  },
                  isExtended: true,
                  icon: Icon(Icons.search_rounded, color: theme.backgroundPrimary),
                  label: Text(
                    'Search',
                    style: TextStyles.subTitle(context: context, color: theme.backgroundPrimary),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
          body: BlocBuilder<SearchSuggestionBloc, SearchSuggestionState>(
            builder: (context, state) {
              if (state is SearchSuggestionLoading) {
                return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: theme.backgroundSecondary,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 42,
                        height: 12,
                        decoration: BoxDecoration(
                          color: theme.backgroundTertiary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 100.0 + Random().nextInt(100),
                              height: 12,
                              decoration: BoxDecoration(
                                color: theme.backgroundTertiary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          trailing: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: theme.backgroundTertiary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  ],
                );
              } else if (state is SearchSuggestionDone) {
                final businesses = state.businesses;
                final industries = state.industries;
                final categories = state.categories;
                final subCategories = state.subCategories;

                return ListView(
                  shrinkWrap: false,
                  padding: EdgeInsets.zero.copyWith(
                    bottom: context.bottomInset + (2 * Dimension.padding.vertical.max) + kToolbarHeight,
                  ),
                  children: [
                    if (businesses.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: theme.backgroundSecondary,
                        child: Text(
                          "${businesses.length} Business${businesses.length > 1 ? "es" : ""}",
                          style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.separated(
                        itemBuilder: (_, index) {
                          final urlSlug = businesses[index];
                          return InkWell(
                            onTap: () {
                              context.pushReplacementNamed(
                                BusinessPage.name,
                                pathParameters: {
                                  'urlSlug': urlSlug,
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (_) => sl<FindBusinessBloc>()..add(FindBusiness(urlSlug: urlSlug)),
                                  ),
                                  BlocProvider(
                                    create: (_) => sl<FindRatingBloc>()..add(FindRating(urlSlug: urlSlug)),
                                  ),
                                ],
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    BusinessLogoWidget(
                                      size: 32,
                                      radius: 8,
                                      backgroundColor: theme.backgroundSecondary,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          BusinessNameWidget(
                                            style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          BusinessRatingWidget(urlSlug: urlSlug),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const Divider(height: .15),
                        itemCount: businesses.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                      ),
                    ],
                    if (industries.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: theme.backgroundSecondary,
                        child: Text(
                          "${industries.length} Industr${industries.length > 1 ? "ies" : "y"}",
                          style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      ...industries.map(
                        (industry) {
                          return ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            title: Text(
                              industry.name.full,
                              style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Icon(
                              Icons.open_in_new_rounded,
                              color: theme.backgroundTertiary,
                              size: 16,
                            ),
                            onTap: () {
                              context.pushNamed(
                                IndustryPage.name,
                                pathParameters: {
                                  'urlSlug': industry.urlSlug,
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                    if (categories.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: theme.backgroundSecondary,
                        child: Text(
                          "${categories.length} Categor${categories.length > 1 ? "ies" : "y"}",
                          style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      ...categories.map(
                        (category) {
                          return ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            title: Text(
                              category.name.full,
                              style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Icon(
                              Icons.open_in_new_rounded,
                              color: theme.backgroundTertiary,
                              size: 16,
                            ),
                            onTap: () {
                              context.pushNamed(
                                CategoryPage.name,
                                pathParameters: {
                                  'urlSlug': category.urlSlug,
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                    if (subCategories.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: theme.backgroundSecondary,
                        child: Text(
                          "${subCategories.length} Sub categor${subCategories.length > 1 ? "ies" : "y"}",
                          style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      ...subCategories.map(
                        (subCategory) {
                          return ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            title: Text(
                              subCategory.name.full,
                              style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Icon(
                              Icons.open_in_new_rounded,
                              color: theme.backgroundTertiary,
                              size: 16,
                            ),
                            onTap: () {
                              context.pushNamed(
                                SubCategoryPage.name,
                                pathParameters: {
                                  'urlSlug': subCategory.urlSlug,
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                    if (businesses.isEmpty && industries.isEmpty && categories.isEmpty && subCategories.isEmpty) ...[
                      const SizedBox(height: 100),
                      InkWell(
                        onTap: () {
                          context.pushNamed(
                            NewListingPage.name,
                            queryParameters: {
                              'suggestion': controller.text.titleCase,
                            },
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add_home_work_outlined, size: Dimension.radius.seventyTwo, color: theme.textSecondary),
                            const SizedBox(height: 16),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Add ",
                                    style: TextStyles.subTitle(context: context, color: theme.textSecondary),
                                  ),
                                  TextSpan(
                                    text: controller.text,
                                    style: TextStyles.subTitle(context: context, color: theme.primary),
                                  ),
                                  TextSpan(
                                    text: " as new business?",
                                    style: TextStyles.subTitle(context: context, color: theme.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                );
              } else if (state is SearchSuggestionError) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      context.pushNamed(
                        NewListingPage.name,
                        queryParameters: {
                          'suggestion': controller.text.titleCase,
                        },
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          state.failure is NoInternetFailure ? Icons.cloud_off_rounded : Icons.error_outline_rounded,
                          size: Dimension.size.horizontal.seventyTwo,
                          color: theme.textSecondary,
                        ),
                        Text(
                          state.failure.message,
                          style: TextStyles.body(context: context, color: theme.textSecondary),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}

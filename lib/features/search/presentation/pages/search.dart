import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
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
              onPressed: context.pop,
            ),
            title: TextField(
              autofocus: true,
              controller: controller,
              style: TextStyles.subTitle(context: context, color: theme.textPrimary),
              onChanged: (query) {
                context.read<SearchSuggestionBloc>().add(SearchSuggestion(query: query));
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
                    style: TextStyles.title(context: context, color: theme.backgroundPrimary),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
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
                return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    if (state.businesses.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: theme.backgroundSecondary,
                        child: Text(
                          "Businesses",
                          style: TextStyles.caption(context: context, color: theme.textPrimary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    ...state.businesses
                        .map(
                          (urlSlug) => BlocProvider(
                            create: (_) => sl<FindBusinessBloc>()..add(FindBusiness(urlSlug: urlSlug)),
                            child: BlocBuilder<FindBusinessBloc, FindBusinessState>(
                              builder: (context, state) {
                                if (state is FindBusinessLoading) {
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
                                    leading: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: theme.backgroundTertiary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  );
                                } else if (state is FindBusinessDone) {
                                  final business = state.business;

                                  return ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                    title: Text(
                                      business.name.full,
                                      style: TextStyles.body(context: context, color: theme.primary),
                                    ),
                                    trailing: Icon(
                                      Icons.open_in_new_rounded,
                                      color: theme.primary,
                                      size: 16,
                                    ),
                                    onTap: () {
                                      context.pushNamed(
                                        BusinessPage.name,
                                        pathParameters: {
                                          "urlSlug": business.urlSlug,
                                        },
                                      );
                                    },
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                        )
                        .toList(),
                    if (state.industries.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: theme.backgroundSecondary,
                        child: Text(
                          "Industries",
                          style: TextStyles.caption(context: context, color: theme.textPrimary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...state.industries.map(
                        (industry) {
                          return ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            title: Text(
                              industry.name.full,
                              style: TextStyles.body(context: context, color: theme.primary),
                            ),
                            trailing: Icon(
                              Icons.open_in_new_rounded,
                              color: theme.primary,
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
                      ).toList(),
                    ],
                    if (state.categories.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: theme.backgroundSecondary,
                        child: Text(
                          "Categories",
                          style: TextStyles.caption(context: context, color: theme.textPrimary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...state.categories.map(
                        (category) {
                          return ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            title: Text(
                              category.name.full,
                              style: TextStyles.body(context: context, color: theme.primary),
                            ),
                            trailing: Icon(
                              Icons.open_in_new_rounded,
                              color: theme.primary,
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
                      ).toList(),
                    ],
                    if (state.subCategories.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: theme.backgroundSecondary,
                        child: Text(
                          "Sub categories",
                          style: TextStyles.caption(context: context, color: theme.textPrimary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...state.subCategories.map(
                        (subCategory) {
                          return ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            title: Text(
                              subCategory.name.full,
                              style: TextStyles.body(context: context, color: theme.primary),
                            ),
                            trailing: Icon(
                              Icons.open_in_new_rounded,
                              color: theme.primary,
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
                      ).toList(),
                    ],
                  ],
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

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
                final businesses = state.businesses;
                final industries = state.industries;
                final categories = state.categories;
                final subCategories = state.subCategories;

                return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    if (businesses.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: theme.backgroundSecondary,
                        child: Text(
                          "${businesses.length} Business${businesses.length > 1 ? "es" : ""}",
                          style: TextStyles.caption(context: context, color: theme.textPrimary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.separated(
                        itemBuilder: (_, index) {
                          final urlSlug = businesses[index];
                          return BlocProvider(
                            create: (_) => sl<FindBusinessBloc>()..add(FindBusiness(urlSlug: urlSlug)),
                            child: const Row(
                              children: [
                                BusinessLogoWidget(size: 16),
                                SizedBox(width: 16),
                                Expanded(child: BusinessNameWidget()),
                                SizedBox(width: 16),
                                
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const Divider(height: .15),
                        itemCount: businesses.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ],
                    if (industries.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: theme.backgroundSecondary,
                        child: Text(
                          "${industries.length} Industr${industries.length > 1 ? "ies" : "y"}",
                          style: TextStyles.caption(context: context, color: theme.textPrimary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...industries.map(
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
                    if (categories.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: theme.backgroundSecondary,
                        child: Text(
                          "${categories.length} Categor${categories.length > 1 ? "ies" : "y"}",
                          style: TextStyles.caption(context: context, color: theme.textPrimary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...categories.map(
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
                    if (subCategories.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: theme.backgroundSecondary,
                        child: Text(
                          "${subCategories.length} Sub categor${subCategories.length > 1 ? "ies" : "y"}",
                          style: TextStyles.caption(context: context, color: theme.textPrimary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...subCategories.map(
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

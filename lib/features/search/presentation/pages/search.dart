import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../category/category.dart';
import '../../../home/home.dart';
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
              autocorrect: false,
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
          body: BlocBuilder<SearchSuggestionBloc, SearchSuggestionState>(
            builder: (context, state) {
              if (state is SearchSuggestionLoading) {
                return ListView.separated(
                  padding: EdgeInsets.zero.copyWith(
                    bottom: context.bottomInset + (2 * Dimension.padding.vertical.max) + kToolbarHeight,
                  ),
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ShimmerLabel(radius: 4, width: 32, height: 32),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerLabel(width: 112.0 + Random().nextInt(72), height: 8),
                                const SizedBox(height: 4),
                                ShimmerLabel(width: 32.0 + Random().nextInt(32), height: 6),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          ShimmerLabel(width: 24.0 + Random().nextInt(24), height: 12)
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(height: .15),
                  itemCount: 10,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                );
              } else if (state is SearchSuggestionDone) {
                return ListView.separated(
                  padding: EdgeInsets.zero.copyWith(
                    bottom: context.bottomInset + (2 * Dimension.padding.vertical.max) + kToolbarHeight,
                  ),
                  itemBuilder: (_, index) {
                    final suggestion = state.suggestions[index];
                    final icon = suggestion is BusinessPreviewEntity
                        ? Icons.business_center_outlined
                        : suggestion is IndustryEntity
                            ? Icons.domain_outlined
                            : suggestion is SubCategoryEntity
                                ? Icons.category_outlined
                                : Icons.label_outline_rounded;
                    final String type = suggestion is BusinessPreviewEntity
                        ? ""
                        : suggestion is IndustryEntity
                            ? "Industry"
                            : suggestion is SubCategoryEntity
                                ? "Sub-Category"
                                : "Category";
                    final fallback = Center(child: Icon(icon, color: theme.textSecondary, size: 20));

                    final searchText = controller.text;
                    final label = suggestion.name.full;
                    final matchStart = label.toLowerCase().indexOf(searchText.toLowerCase());

                    final matchEnd = matchStart != -1 && searchText.isNotEmpty ? matchStart + searchText.length : -1;
                    final beforeMatch = matchStart != -1 && searchText.isNotEmpty ? label.substring(0, matchStart) : "";
                    final match = matchStart != -1 && searchText.isNotEmpty ? label.substring(matchStart, matchEnd) : "";
                    final afterMatch = matchStart != -1 && searchText.isNotEmpty ? label.substring(matchEnd) : "";
                    return InkWell(
                      onTap: () {
                        if (suggestion is BusinessPreviewEntity) {
                          context.pushNamed(
                            BusinessPage.name,
                            pathParameters: {'urlSlug': suggestion.urlSlug},
                          );
                        } else if (suggestion is IndustryEntity) {
                          context.pushNamed(
                            IndustryPage.name,
                            pathParameters: {'urlSlug': suggestion.urlSlug},
                            queryParameters: {'industry': (suggestion as IndustryEntity).identity.guid},
                          );
                        } else if (suggestion is SubCategoryEntity) {
                          context.pushNamed(
                            SubCategoryPage.name,
                            pathParameters: {'urlSlug': suggestion.urlSlug},
                            queryParameters: {
                              'industry': (suggestion as SubCategoryEntity).industry.guid,
                              'category': (suggestion as SubCategoryEntity).category.guid,
                              'subCategory': (suggestion as SubCategoryEntity).identity.guid,
                            },
                          );
                        } else if (suggestion is CategoryEntity) {
                          context.pushNamed(
                            CategoryPage.name,
                            pathParameters: {'urlSlug': suggestion.urlSlug},
                            queryParameters: {
                              'industry': (suggestion as CategoryEntity).industry.guid,
                              'category': (suggestion as CategoryEntity).identity.guid,
                            },
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: theme.backgroundSecondary,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: theme.backgroundTertiary,
                                  width: .15,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: (suggestion.logo ?? "").isEmpty
                                  ? fallback
                                  : CachedNetworkImage(
                                      imageUrl: suggestion.logo!.url,
                                      width: 32,
                                      height: 32,
                                      fit: BoxFit.contain,
                                      placeholder: (_, __) => ShimmerLabel(radius: 4, width: 32, height: 32),
                                      errorWidget: (_, __, ___) => fallback,
                                    ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  matchStart != -1 && searchText.isNotEmpty
                                      ? RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: beforeMatch,
                                                style: TextStyles.body(context: context, color: theme.textSecondary),
                                              ),
                                              TextSpan(
                                                text: match,
                                                style: TextStyles.body(context: context, color: theme.primary).copyWith(
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              TextSpan(
                                                text: afterMatch,
                                                style: TextStyles.body(context: context, color: theme.textSecondary),
                                              ),
                                              if (suggestion is BusinessPreviewEntity &&
                                                  (suggestion as BusinessPreviewEntity).verified) ...[
                                                WidgetSpan(child: SizedBox(width: 4)),
                                                WidgetSpan(
                                                  alignment: PlaceholderAlignment.aboveBaseline,
                                                  baseline: TextBaseline.alphabetic,
                                                  child: Icon(
                                                    Icons.verified_rounded,
                                                    color: theme.primary,
                                                    size: Dimension.radius.twelve,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        )
                                      : suggestion is BusinessPreviewEntity && (suggestion as BusinessPreviewEntity).verified
                                          ? RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: suggestion.name.full,
                                                    style: TextStyles.body(context: context, color: theme.primary),
                                                  ),
                                                  WidgetSpan(child: SizedBox(width: 4)),
                                                  WidgetSpan(
                                                    alignment: PlaceholderAlignment.aboveBaseline,
                                                    baseline: TextBaseline.alphabetic,
                                                    child: Icon(
                                                      Icons.verified_rounded,
                                                      color: theme.primary,
                                                      size: Dimension.radius.twelve,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Text(
                                              label,
                                              style: TextStyles.body(context: context, color: theme.textPrimary),
                                            ),
                                  const SizedBox(height: 2),
                                  if (type.isNotEmpty)
                                    Text(
                                      type,
                                      style: TextStyles.overline(context: context, color: theme.textSecondary.withAlpha(150))
                                          .copyWith(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  if (suggestion is BusinessSuggestionEntity && suggestion.rating > 0)
                                    Text(
                                      "${suggestion.reviews} review${suggestion.reviews > 1 ? 's' : ''}",
                                      style: TextStyles.caption(context: context, color: theme.textSecondary.withAlpha(150)),
                                    ),
                                ],
                              ),
                            ),
                            if (suggestion is BusinessSuggestionEntity && suggestion.rating > 0) ...[
                              const SizedBox(width: 16),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 4,
                                children: [
                                  Icon(Icons.stars_rounded, size: 16, color: theme.primary),
                                  Text(
                                    suggestion.rating.toStringAsFixed(1),
                                    style: TextStyles.caption(context: context, color: theme.primary),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(height: .15),
                  itemCount: state.suggestions.length,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
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

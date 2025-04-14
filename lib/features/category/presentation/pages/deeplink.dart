import '../../../../core/shared/shared.dart';
import '../../../industry/industry.dart';
import '../../../sub_category/sub_category.dart';
import '../../category.dart';

class CategoryDeepLinkPage extends StatelessWidget {
  static const String path = '/deeplink/category/:urlSlug';
  static const String name = 'CategoryDeepLinkPage';
  final String urlSlug;
  const CategoryDeepLinkPage({
    super.key,
    required this.urlSlug,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryDeeplinkBloc, CategoryDeeplinkState>(
      listener: (context, state) {
        if (state is CategoryDeeplinkDone) {
          if (state.category is IndustryEntity) {
            final industry = state.category as IndustryEntity;
            context.goNamed(
              IndustryPage.name,
              pathParameters: {
                'urlSlug': industry.urlSlug,
              },
              queryParameters: {
                'industry': industry.industry.guid,
              },
            );
          } else if (state.category is SubCategoryEntity) {
            final subCategory = state.category as SubCategoryEntity;
            context.goNamed(
              SubCategoryPage.name,
              pathParameters: {
                'urlSlug': subCategory.urlSlug,
              },
              queryParameters: {
                'industry': subCategory.industry.guid,
                'category': subCategory.category.guid,
                'subCategory': subCategory.identity.guid,
              },
            );
          } else {
            final category = state.category;
            context.goNamed(
              CategoryPage.name,
              pathParameters: {
                'urlSlug': category.urlSlug,
              },
              queryParameters: {
                'industry': category.industry.guid,
                'category': category.identity.guid,
              },
            );
          }
        }
      },
      builder: (context, state) {
        return const Placeholder();
      },
    );
  }
}

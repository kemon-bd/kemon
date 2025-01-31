import 'package:kemon/features/industry/industry.dart';

import '../../../../../core/shared/shared.dart';
import '../../../../category/category.dart';
import '../../../../lookup/lookup.dart';
import '../../../../sub_category/sub_category.dart';

class NewListingPreviewWidget extends StatelessWidget {
  final VoidCallback onNameEdit;
  final TextEditingController name;
  final TextEditingController urlSlug;
  final TextEditingController about;

  final VoidCallback onLogoEdit;
  final XFile? logo;

  final VoidCallback onTypeEdit;
  final ListingType? type;

  final VoidCallback onContactEdit;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController website;
  final TextEditingController social;

  final VoidCallback onCategoryEdit;
  final IndustryEntity? industry;
  final CategoryEntity? category;
  final SubCategoryEntity? subCategory;

  final VoidCallback onLocationEdit;
  final TextEditingController address;
  final LookupEntity? division;
  final LookupEntity? district;
  final LookupEntity? thana;

  const NewListingPreviewWidget({
    super.key,
    required this.onNameEdit,
    required this.name,
    required this.urlSlug,
    required this.about,
    required this.onLogoEdit,
    required this.logo,
    required this.onTypeEdit,
    required this.type,
    required this.onContactEdit,
    required this.phone,
    required this.email,
    required this.website,
    required this.social,
    required this.onCategoryEdit,
    required this.industry,
    required this.category,
    required this.subCategory,
    required this.onLocationEdit,
    required this.address,
    required this.division,
    required this.district,
    required this.thana,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return ListView(
          padding: const EdgeInsets.all(16).copyWith(
            bottom: 16 + context.bottomInset,
            top: 0,
          ),
          children: [
            PhysicalModel(
              color: theme.backgroundSecondary,
              borderRadius: BorderRadius.circular(Dimension.radius.max),
              child: Row(
                spacing: Dimension.padding.horizontal.large,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox.shrink(),
                  Icon(Icons.language_rounded, color: theme.textSecondary),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "kemon.com.bd/",
                          style: TextStyles.body(context: context, color: theme.textSecondary),
                        ),
                        TextSpan(
                          text: urlSlug.text,
                          style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: onNameEdit,
                    icon: Icon(Icons.drive_file_rename_outline_rounded, color: theme.link),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimension.padding.vertical.ultraMax),
            Row(
              spacing: Dimension.padding.horizontal.medium,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Dimension.radius.seventyTwo,
                  height: Dimension.radius.seventyTwo,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      PhysicalModel(
                        color: theme.backgroundSecondary,
                        borderRadius: BorderRadius.circular(Dimension.radius.twenty),
                        clipBehavior: Clip.antiAlias,
                        child: logo != null
                            ? Image.file(
                                File(logo!.path),
                                width: Dimension.radius.seventyTwo,
                                height: Dimension.radius.seventyTwo,
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: Dimension.radius.fortyEight,
                                  color: theme.backgroundTertiary,
                                ),
                              ),
                      ),
                      Positioned(
                        top: -8,
                        right: -8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.link,
                            borderRadius: BorderRadius.circular(Dimension.radius.eight),
                          ),
                          child: IconButton(
                            onPressed: onLogoEdit,
                            padding: EdgeInsets.all(0),
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            iconSize: Dimension.radius.twenty,
                            icon: Icon(
                              Icons.drive_file_rename_outline_rounded,
                              color: theme.white,
                              size: Dimension.radius.twenty,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Dimension.padding.horizontal.medium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: name.text,
                              style: TextStyles.subTitle(context: context, color: theme.textPrimary).copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const WidgetSpan(child: SizedBox(width: 4)),
                            WidgetSpan(
                              child: InkWell(
                                onTap: onNameEdit,
                                child: Icon(
                                  Icons.drive_file_rename_outline_rounded,
                                  color: theme.link,
                                  size: Dimension.radius.twenty,
                                ),
                              ),
                              baseline: TextBaseline.ideographic,
                              alignment: PlaceholderAlignment.aboveBaseline,
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: about.text.isNotEmpty ? about.text : "not description",
                              style: TextStyles.body(
                                context: context,
                                color: about.text.isNotEmpty ? theme.textPrimary : theme.textSecondary,
                              ).copyWith(
                                fontWeight: about.text.isNotEmpty ? FontWeight.bold : null,
                              ),
                            ),
                            const WidgetSpan(child: SizedBox(width: 4)),
                            WidgetSpan(
                              child: InkWell(
                                onTap: onNameEdit,
                                child: Icon(
                                  Icons.drive_file_rename_outline_rounded,
                                  color: theme.link,
                                  size: Dimension.radius.twenty,
                                ),
                              ),
                              baseline: TextBaseline.ideographic,
                              alignment: PlaceholderAlignment.aboveBaseline,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimension.padding.vertical.medium),
                      FilterChip(
                        backgroundColor: theme.link.withAlpha(25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimension.radius.max),
                          side: BorderSide(color: theme.link, width: 1.0),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                        avatar: Icon(
                          type == ListingType.product ? Icons.inventory_2_rounded : Icons.maps_home_work_rounded,
                          color: theme.link,
                        ),
                        label: Text(
                          type == ListingType.product ? "Product" : "Business",
                          style: TextStyles.body(context: context, color: theme.link).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onSelected: (_) => onTypeEdit(),
                        deleteIcon: Icon(
                          Icons.drive_file_rename_outline_rounded,
                          color: theme.link,
                          size: Dimension.radius.twenty,
                        ),
                        onDeleted: onTypeEdit,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: Dimension.padding.vertical.ultraProMax),
            if (type != ListingType.product) ...[
              Wrap(
                spacing: Dimension.padding.horizontal.medium,
                runSpacing: Dimension.padding.vertical.medium,
                children: [
                  FilterChip(
                    backgroundColor: theme.link.withAlpha(25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimension.radius.max),
                      side: BorderSide(color: theme.link, width: 1.0),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    avatar: Icon(Icons.call_rounded, color: phone.text.isNotEmpty ? theme.link : theme.textSecondary),
                    label: Text(
                      phone.text.isNotEmpty ? phone.text : "not provided",
                      style: TextStyles.body(
                        context: context,
                        color: phone.text.isNotEmpty ? theme.link : theme.textSecondary,
                      ).copyWith(
                        fontWeight: phone.text.isNotEmpty ? FontWeight.bold : null,
                      ),
                    ),
                    onSelected: (_) => onContactEdit(),
                    deleteIcon: Icon(
                      Icons.drive_file_rename_outline_rounded,
                      color: theme.link,
                      size: Dimension.radius.twenty,
                    ),
                    onDeleted: onContactEdit,
                  ),
                  FilterChip(
                    backgroundColor: theme.link.withAlpha(25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimension.radius.max),
                      side: BorderSide(color: theme.link, width: 1.0),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    avatar: Icon(Icons.email_rounded, color: email.text.isNotEmpty ? theme.link : theme.textSecondary),
                    label: Text(
                      email.text.isNotEmpty ? email.text : "not provided",
                      style: TextStyles.body(
                        context: context,
                        color: email.text.isNotEmpty ? theme.link : theme.textSecondary,
                      ).copyWith(
                        fontWeight: email.text.isNotEmpty ? FontWeight.bold : null,
                      ),
                    ),
                    onSelected: (_) => onContactEdit(),
                    deleteIcon: Icon(
                      Icons.drive_file_rename_outline_rounded,
                      color: theme.link,
                      size: Dimension.radius.twenty,
                    ),
                    onDeleted: onContactEdit,
                  ),
                  FilterChip(
                    backgroundColor: theme.link.withAlpha(25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimension.radius.max),
                      side: BorderSide(color: theme.link, width: 1.0),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    avatar: Icon(Icons.language_rounded, color: website.text.isNotEmpty ? theme.link : theme.textSecondary),
                    label: Text(
                      website.text.isNotEmpty ? website.text : "not provided",
                      style: TextStyles.body(
                        context: context,
                        color: website.text.isNotEmpty ? theme.link : theme.textSecondary,
                      ).copyWith(
                        fontWeight: website.text.isNotEmpty ? FontWeight.bold : null,
                      ),
                    ),
                    onSelected: (_) => onContactEdit(),
                    deleteIcon: Icon(
                      Icons.drive_file_rename_outline_rounded,
                      color: theme.link,
                      size: Dimension.radius.twenty,
                    ),
                    onDeleted: onContactEdit,
                  ),
                  FilterChip(
                    backgroundColor: theme.link.withAlpha(25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimension.radius.max),
                      side: BorderSide(color: theme.link, width: 1.0),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    avatar: Icon(Icons.link_rounded, color: social.text.isNotEmpty ? theme.link : theme.textSecondary),
                    label: Text(
                      social.text.isNotEmpty ? social.text : "not provided",
                      style: TextStyles.body(
                        context: context,
                        color: social.text.isNotEmpty ? theme.link : theme.textSecondary,
                      ).copyWith(
                        fontWeight: social.text.isNotEmpty ? FontWeight.bold : null,
                      ),
                    ),
                    onSelected: (_) => onContactEdit(),
                    deleteIcon: Icon(
                      Icons.drive_file_rename_outline_rounded,
                      color: theme.link,
                      size: Dimension.radius.twenty,
                    ),
                    onDeleted: onContactEdit,
                  ),
                ],
              ),
              SizedBox(height: Dimension.padding.vertical.ultraProMax),
            ],
            PhysicalModel(
              color: theme.backgroundSecondary,
              borderRadius: BorderRadius.circular(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 16,
                    contentPadding: EdgeInsets.symmetric(horizontal: Dimension.radius.sixteen).copyWith(
                      right: Dimension.radius.eight,
                    ),
                    leading: Icon(
                      Icons.category_rounded,
                      color: theme.textSecondary,
                    ),
                    title: Text(
                      "Category",
                      style: TextStyles.subTitle(context: context, color: theme.textSecondary),
                    ),
                    trailing: IconButton(
                      splashRadius: 12,
                      icon: Icon(Icons.drive_file_rename_outline_rounded, color: theme.link, size: Dimension.radius.twenty),
                      padding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                      onPressed: onCategoryEdit,
                    ),
                  ),
                  const Divider(thickness: 1, height: 1),
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 16,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    title: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Industry",
                            style: TextStyles.caption(context: context, color: theme.textSecondary),
                          ),
                          const WidgetSpan(child: SizedBox(width: 8)),
                          WidgetSpan(
                            baseline: TextBaseline.alphabetic,
                            alignment: PlaceholderAlignment.aboveBaseline,
                            child: Icon(Icons.emergency_rounded, size: Dimension.radius.eight, color: theme.negative),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Text(
                      industry?.name.full ?? "not provided",
                      style: TextStyles.body(context: context, color: theme.textPrimary),
                    ),
                  ),
                  const Divider(thickness: .25, height: 8),
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 16,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    title: Text(
                      "Category",
                      style: TextStyles.caption(context: context, color: theme.textSecondary),
                    ),
                    subtitle: Text(
                      category?.name.full ?? "not provided",
                      style: TextStyles.body(
                        context: context,
                        color: category != null ? theme.textPrimary : theme.textSecondary,
                      ),
                    ),
                  ),
                  const Divider(thickness: .25, height: 8),
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 16,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    title: Text(
                      "Sub Category",
                      style: TextStyles.caption(context: context, color: theme.textSecondary),
                    ),
                    subtitle: Text(
                      subCategory?.name.full ?? "not provided",
                      style: TextStyles.body(
                        context: context,
                        color: subCategory != null ? theme.textPrimary : theme.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            SizedBox(height: Dimension.padding.vertical.ultraProMax),
            if (type != ListingType.product) ...[
              PhysicalModel(
                color: theme.backgroundSecondary,
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      dense: true,
                      horizontalTitleGap: 16,
                      contentPadding: EdgeInsets.symmetric(horizontal: Dimension.radius.sixteen).copyWith(
                        right: Dimension.radius.eight,
                      ),
                      leading: Icon(
                        Icons.place_rounded,
                        color: theme.textSecondary,
                      ),
                      title: Text(
                        "Location",
                        style: TextStyles.subTitle(context: context, color: theme.textSecondary),
                      ),
                      trailing: IconButton(
                        splashRadius: 12,
                        icon: Icon(Icons.drive_file_rename_outline_rounded, color: theme.link, size: Dimension.radius.twenty),
                        padding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        onPressed: onLocationEdit,
                      ),
                    ),
                    const Divider(thickness: 1, height: 1),
                    ListTile(
                      dense: true,
                      horizontalTitleGap: 16,
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        "Address",
                        style: TextStyles.caption(context: context, color: theme.textSecondary),
                      ),
                      subtitle: Text(
                        address.text.isNotEmpty ? address.text : "not provided",
                        style: TextStyles.body(
                          context: context,
                          color: address.text.isNotEmpty ? theme.textPrimary : theme.textSecondary,
                        ),
                      ),
                    ),
                    const Divider(thickness: .25, height: 8),
                    ListTile(
                      dense: true,
                      horizontalTitleGap: 16,
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        "Division",
                        style: TextStyles.caption(context: context, color: theme.textSecondary),
                      ),
                      subtitle: Text(
                        division?.text ?? "not provided",
                        style: TextStyles.body(
                          context: context,
                          color: division != null ? theme.textPrimary : theme.textSecondary,
                        ),
                      ),
                    ),
                    const Divider(thickness: .25, height: 8),
                    ListTile(
                      dense: true,
                      horizontalTitleGap: 16,
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        "District",
                        style: TextStyles.caption(context: context, color: theme.textSecondary),
                      ),
                      subtitle: Text(
                        district?.text ?? "not provided",
                        style: TextStyles.body(
                          context: context,
                          color: district != null ? theme.textPrimary : theme.textSecondary,
                        ),
                      ),
                    ),
                    const Divider(thickness: .25, height: 8),
                    ListTile(
                      dense: true,
                      horizontalTitleGap: 16,
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        "Thana",
                        style: TextStyles.caption(context: context, color: theme.textSecondary),
                      ),
                      subtitle: Text(
                        thana?.text ?? "not provided",
                        style: TextStyles.body(
                          context: context,
                          color: thana != null ? theme.textPrimary : theme.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

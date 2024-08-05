import '../shared.dart';

class PhotoPreviewPage extends StatelessWidget {
  static const String path = '/preview/:url';
  static const String name = 'PhotoPreviewPage';
  final String url;
  const PhotoPreviewPage({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: theme.primary,
            surfaceTintColor: theme.primary,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: theme.white),
              onPressed: context.pop,
            ),
            forceMaterialTransparency: true,
          ),
          extendBodyBehindAppBar: true,
          body: PhotoView(
            imageProvider: CachedNetworkImageProvider(url),
            initialScale: PhotoViewComputedScale.contained,
          ),
        );
      },
    );
  }
}

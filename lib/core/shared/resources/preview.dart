import '../shared.dart';

class PhotoPreviewPage extends StatefulWidget {
  static const String path = '/preview/:url';
  static const String name = 'PhotoPreviewPage';
  final List<String> url;
  final int index;
  const PhotoPreviewPage({
    super.key,
    required this.url,
    this.index = 0,
  });

  @override
  State<PhotoPreviewPage> createState() => _PhotoPreviewPageState();
}

class _PhotoPreviewPageState extends State<PhotoPreviewPage> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    index = widget.index;
  }

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
          body: widget.url.length == 1
              ? PhotoView(
                  imageProvider: CachedNetworkImageProvider(widget.url.first),
                  initialScale: PhotoViewComputedScale.contained,
                )
              : Stack(
                  children: [
                    Positioned.fill(
                      child: PhotoViewGallery.builder(
                        scrollPhysics: const BouncingScrollPhysics(),
                        builder: (BuildContext context, int index) {
                          return PhotoViewGalleryPageOptions(
                            imageProvider: CachedNetworkImageProvider(
                                widget.url.elementAt(index)),
                            initialScale: PhotoViewComputedScale.contained,
                            minScale: PhotoViewComputedScale.contained,
                            maxScale: PhotoViewComputedScale.covered,
                            tightMode: true,
                            heroAttributes: PhotoViewHeroAttributes(
                                tag: widget.url.elementAt(index)),
                          );
                        },
                        itemCount: widget.url.length,
                        loadingBuilder: (context, event) => Center(
                          child: SizedBox(
                            width: Dimension.size.horizontal.max,
                            height: Dimension.size.vertical.max,
                            child: CircularProgressIndicator(
                              value: event == null
                                  ? 0
                                  : event.cumulativeBytesLoaded /
                                      (event.expectedTotalBytes ?? 1),
                            ),
                          ),
                        ),
                        onPageChanged: (index) {
                          setState(() {
                            this.index = index;
                          });
                        },
                        pageController: PageController(initialPage: index),
                      ),
                    ),
                    Positioned(
                      bottom:
                          context.bottomInset + Dimension.padding.vertical.max,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: PhysicalModel(
                          color: theme.white,
                          borderRadius:
                              BorderRadius.circular(Dimension.radius.max),
                          child: DotsIndicator(
                            position: index,
                            dotsCount: widget.url.length,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            decorator: DotsDecorator(
                              size: Size.square(Dimension.radius.four),
                              activeSize: Size(
                                  Dimension.size.horizontal.twentyFour,
                                  Dimension.size.vertical.four),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimension.radius.four),
                              ),
                              color: theme.semiBlack,
                              activeColor: theme.primary,
                              spacing: EdgeInsets.symmetric(
                                horizontal: Dimension.padding.horizontal.small,
                                vertical: Dimension.padding.vertical.small,
                              ),
                            ),
                            onTap: (position) => setState(() {
                              index = position;
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

import 'dart:developer';

import 'package:e_book_app/index.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({super.key, required this.imagePath, required this.id});

  final String imagePath;
  final String id;

  static const String routeName = 'full_screen_image';
  static const String routePath = '/full_screen_image';

  static final route = GoRoute(
    path: routePath,
    name: routeName,
    builder: (context, state) => FullScreenImage(
      imagePath: state.queryParams['image_path'] ?? '',
      id: state.queryParams['tag'] ?? '',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dy > 20) {
                GoRouter.of(context).pop();
              } else if (details.delta.dy < -20) {
                GoRouter.of(context).pop();
              }
            },
            child: Center(
              child: PhotoView(
                disableGestures: true,
                imageProvider: Image.network(
                  AppData.imagePath(
                    posterPath: imagePath,
                  ),
                ).image,
                // heroAttributes: PhotoViewHeroAttributes(
                //   tag: id,
                // ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                icon: Icons.clear,
                color: Colors.white,
                onPressed: () => GoRouter.of(context).pop(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

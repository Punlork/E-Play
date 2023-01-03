import 'dart:developer';

import 'package:e_book_app/index.dart';

class ImageCardWidget extends StatelessWidget {
  const ImageCardWidget({
    super.key,
    required this.imgUrl,
    required this.rating,
  });

  final String imgUrl;
  final num? rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CachedNetworkImage(
          imageUrl: AppData.imagePath(posterPath: imgUrl),
          errorWidget: (context, url, error) => const AspectRatio(
            aspectRatio: .7,
            child: ColoredBox(color: AppColors.gray),
          ),
          memCacheHeight: 300,
          // memCacheWidth: 300,
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:e_book_app/index.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageCardWidget extends StatelessWidget {
  const ImageCardWidget({
    super.key,
    required this.imgUrl,
    required this.rating,
    this.cacheHeight,
  });

  final String imgUrl;
  final num? rating;
  final int? cacheHeight;

  @override
  Widget build(BuildContext context) {
    // debugInvertOversizedImages = true;

    return Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CachedNetworkImage(
          imageUrl: AppData.imagePath(posterPath: imgUrl),
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: AppColors.black,
            highlightColor: AppColors.gray,
            child: const SizedBox(),
          ),
          errorWidget: (context, url, error) => const AspectRatio(
            aspectRatio: .7,
            child: ColoredBox(color: AppColors.gray),
          ),
          memCacheHeight: cacheHeight,
          key: UniqueKey(),
        ),
      ),
    );
  }
}

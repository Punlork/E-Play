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
        child: Image.network(
          AppData.imagePath(posterPath: imgUrl),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const AspectRatio(
            aspectRatio: .7,
            child: ColoredBox(color: AppColors.gray),
          ),
        ),
      ),
    );
  }
}

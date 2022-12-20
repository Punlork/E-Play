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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(6),
          topLeft: Radius.circular(6),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(6),
          topLeft: Radius.circular(6),
        ),
        child: Banner(
          message: '$rating',
          color: AppColors.red,
          textStyle: Theme.of(context).textTheme.labelMedium!,
          location: BannerLocation.topEnd,
          child: Image.network(
            AppData.imagePath(
              posterPath: imgUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

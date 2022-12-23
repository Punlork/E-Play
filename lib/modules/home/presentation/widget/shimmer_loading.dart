import 'package:e_book_app/index.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray,
      highlightColor: AppColors.white,
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              width: 100,
            ),
          ),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 20,
        ),
      ),
    );
  }
}
import 'package:e_book_app/index.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray.withOpacity(.2),
      highlightColor: AppColors.black,
      period: const Duration(milliseconds: 700),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        height: 150,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 2 / 3,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 170,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    height: 15,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 20,
                        color: AppColors.white,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 30,
                        height: 20,
                        color: AppColors.white,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 20,
                        height: 20,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: AppPadding(
                      paddingOnly: true,
                      left: 0,
                      child: Container(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    // return const Center(
    //   child: SizedBox(
    //     height: 24,
    //     width: 24,
    //     child: CircularProgressIndicator(),
    //   ),
    // );
  }
}

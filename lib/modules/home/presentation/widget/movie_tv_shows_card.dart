import 'package:e_book_app/index.dart';

class MoviesTvShowCardBox extends StatelessWidget {
  const MoviesTvShowCardBox({
    super.key,
    required this.id,
    required this.imgUrl,
    this.rating,
    required this.title,
    required this.type,
  });

  final String id;
  final String imgUrl;
  final num? rating;
  final String title;
  final DetailType type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == DetailType.movie) {
          GoRouter.of(context).pushNamed(
            HomeDetailPage.routeName,
            queryParams: {
              'movie_id': id,
            },
          );
        }
        if (type == DetailType.tvShow) {
          GoRouter.of(context).pushNamed(
            HomeTvShowDetailPage.routeName,
            queryParams: {
              'tv_show_id': id,
            },
          );
        }
      },
      child: SizedBox.fromSize(
        size: const Size.fromWidth(150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.fromSize(
              size: const Size.fromHeight(200),
              child: ImageCardWidget(
                imgUrl: imgUrl,
                rating: rating,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 140,
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      letterSpacing: 2,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}

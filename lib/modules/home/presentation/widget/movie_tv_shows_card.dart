import 'package:e_book_app/index.dart';

class MoviesTvShowCardBox extends StatelessWidget {
  const MoviesTvShowCardBox({
    super.key,
    required this.id,
    required this.imgUrl,
    this.rating,
    required this.title,
    required this.type,
    this.cacheHeight = 300,
  });

  final int id;
  final String imgUrl;
  final num? rating;
  final String title;
  final DetailType type;
  final int cacheHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == DetailType.movie) {
          GoRouter.of(context).pushNamed(
            MovieDetailPage.routeName,
            queryParams: {
              'movie_id': '$id',
            },
          );
        }
        if (type == DetailType.tvShow) {
          GoRouter.of(context).pushNamed(
            SeriesDetailPage.routeName,
            queryParams: {
              'tv_show_id': '$id',
            },
          );
        }
      },
      child: ImageCardWidget(
        imgUrl: imgUrl,
        rating: rating,
        cacheHeight: cacheHeight,
      ),
    );
  }
}

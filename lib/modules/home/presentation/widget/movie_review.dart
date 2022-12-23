import 'package:e_book_app/index.dart';

class MovieReview {
  MovieReview._();
  static void showMovieReview(
    BuildContext context, {
    required DetailType type,
    ScrollController? tvShowController,
  }) {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      builder: (context) => type == DetailType.movie
          ? BlocBuilder<MovieReviewsBloc, MovieReviewsState>(
              builder: (context, state) {
                if (state is MovieReviewsFailed) {
                  return Text(state.message);
                }
                if (state is MovieReviewsLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is MovieReviewsLoaded) {
                  final movieReviews = state.movieReviews;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AppPadding(
                        vertical: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Movie Reviews',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            CustomIconWidget(
                              icon: Icons.clear,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      const AppPadding(child: Divider()),
                      if (movieReviews.isNotEmpty)
                        Flexible(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Divider(),
                            itemBuilder: (context, index) {
                              return _ReviewDetail(
                                imagePath: movieReviews[index].authorDetails.avatarPath,
                                name: movieReviews[index].authorDetails.name,
                                rating: movieReviews[index].authorDetails.rating,
                                reviews: movieReviews[index].content,
                              );
                              // return
                            },
                            itemCount: movieReviews.length,
                          ),
                        )
                      else
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'No Review',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                    ],
                  );
                }
                return const Text(AppData.somethingWentWrong);
              },
            )
          : BlocBuilder<TvShowReviewsBloc, TvShowReviewsState>(
              builder: (context, state) {
                if (state is TvShowReviewsLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is TvShowReviewsFailed) {
                  return Text(state.message);
                }
                if (state is TvShowReviewsLoaded) {
                  final tvShowReviews = state.tvShowReviews;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AppPadding(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Series Reviews',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            CustomIconWidget(
                              icon: Icons.clear,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      const AppPadding(child: Divider()),
                      if (tvShowReviews.isNotEmpty)
                        Flexible(
                          child: ListView.separated(
                            controller: tvShowController,
                            separatorBuilder: (context, index) => const Divider(),
                            itemBuilder: (context, index) {
                              return _ReviewDetail(
                                imagePath: tvShowReviews[index].authorDetails.avatarPath,
                                name: tvShowReviews[index].authorDetails.name,
                                rating: tvShowReviews[index].authorDetails.rating,
                                reviews: tvShowReviews[index].content,
                              );
                              // return
                            },
                            itemCount: tvShowReviews.length,
                          ),
                        )
                      else
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'No Review',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                    ],
                  );
                }
                return const Text(AppData.somethingWentWrong);
              },
            ),
    );
  }
}

class _ReviewDetail extends StatelessWidget {
  const _ReviewDetail({
    required this.imagePath,
    required this.name,
    required this.rating,
    required this.reviews,
  });

  final String? imagePath;
  final String name;
  final num? rating;
  final String reviews;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        foregroundImage: imagePath != null
            ? NetworkImage(
                AppData.imagePath(
                  posterPath: imagePath!,
                ),
              )
            : Image.asset(AppPath.userAvatar).image,
      ),
      // contentPadding: EdgeInsets.zero,
      minVerticalPadding: 12,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'User : ',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            '$name - $rating',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review : ',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Flexible(
            child: Text(
              reviews,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}

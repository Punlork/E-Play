import 'package:e_book_app/index.dart';

class MovieReview {
  MovieReview._();

  static void showMovieReview(
    BuildContext context, {
    required String url,
  }) {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
      ),
      builder: (context) {
        final controller = ScrollController();
        final bloc = context.read<MovieReviewsBloc>();
        // ignore: omit_local_variable_types
        int pageNumber = 1;

        controller.addListener(() {
          final maxExtent = controller.position.atEdge;

          if (maxExtent && !bloc.isReachedLimit) {
            pageNumber += 1;
            bloc.add(
              OnGetMovieReviewsNext(
                url: url,
                pageNumber: pageNumber,
              ),
            );
          }
        });

        return BlocBuilder<MovieReviewsBloc, MovieReviewsState>(
          builder: (context, state) {
            if (state is MovieReviewsFailed) {
              return Text(state.message);
            }
            if (state is MovieReviewsLoading) {
              return const CircularProgressIndicator();
            }
            if (state is MovieReviewsLoaded) {
              final movieReviews = state.movieReviews;

              final _listOfReviews = <Widget>[];

              for (final element in movieReviews) {
                _listOfReviews.add(
                  _ReviewDetail(
                    imagePath: element.authorDetails.avatarPath,
                    name: element.authorDetails.name,
                    rating: element.authorDetails.rating,
                    reviews: element.content,
                  ),
                );
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppPadding(
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
                  if (movieReviews.isNotEmpty) ...[
                    Flexible(
                      child: SingleChildScrollView(
                        controller: controller,
                        child: Column(
                          children: [
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => const Divider(),
                              itemBuilder: (context, index) => index >= movieReviews.length
                                  ? const BottomLoader()
                                  : _listOfReviews[index],
                              itemCount: state.hasReachLimit
                                  ? movieReviews.length
                                  : movieReviews.length + 1,
                            ),
                            if (state.status == PaginateStatus.empty)
                              AppPadding(
                                vertical: 20,
                                child: Text(
                                  'End',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ] else
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
        );
      },
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

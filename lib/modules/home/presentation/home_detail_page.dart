import 'dart:developer';

import 'package:e_book_app/common/app_data.dart';
import 'package:e_book_app/modules/component/index.dart';
import 'package:e_book_app/modules/home/application/movie_detail/movie_detail_bloc.dart';
import 'package:e_book_app/modules/home/application/movie_suggestion/movie_suggestion_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDetailPage extends StatefulWidget {
  const HomeDetailPage({super.key, required this.movieId});

  static const String routeName = 'home_detail_page';
  static const String routePath = '/home_detail_page';

  final String movieId;

  static final route = GoRoute(
    path: routePath,
    name: routeName,
    builder: (context, state) => HomeDetailPage(
      movieId: state.queryParams['movie_id'] ?? '',
    ),
  );

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  int movieIndex = 0;

  Future<void> _lanuchUrl(String ytTrailerCode) async {
    final uri = Uri.parse('${AppData.ytTrailerCode}$ytTrailerCode');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot lanuch';
    }
  }

  @override
  void initState() {
    super.initState();
    log(widget.movieId);
    BlocProvider.of<MovieDetailBloc>(context).add(
      OnGetMovieDetail(movieId: int.parse(widget.movieId)),
    );
    BlocProvider.of<MovieSuggestionBloc>(context).add(
      OnGetMovieSuggestion(int.parse(widget.movieId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconWidget(
              icon: Icons.arrow_back,
              onPressed: () => GoRouter.of(context).pop(),
            ),
            Row(
              children: [
                CustomIconWidget(
                  icon: Icons.favorite_border,
                  onPressed: () {},
                ),
                CustomIconWidget(
                  icon: Icons.ios_share,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MovieDetailLoaded) {
            final stateMovie = state.movieDetail.movie;
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AppPadding(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Image.network(
                            stateMovie.mediumCoverImage,
                            height: 250,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    stateMovie.titleEnglish,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          // letterSpacing: 3,
                                          height: 1.5,
                                        ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _CustomMovieDetailStatus(
                                        icon: Icons.download,
                                        title: NumberFormat.compact().format(
                                          int.parse(
                                            stateMovie.downloadCount.toString(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                        child: VerticalDivider(
                                          color: Colors.white,
                                        ),
                                      ),
                                      _CustomMovieDetailStatus(
                                        icon: Icons.thumb_up_outlined,
                                        title: stateMovie.likeCount.toString(),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                        child: VerticalDivider(
                                          color: Colors.white,
                                        ),
                                      ),
                                      _CustomMovieDetailStatus(
                                        icon: Icons.today,
                                        title: stateMovie.year.toString(),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  if (stateMovie.genres != null)
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: List.generate(
                                        stateMovie.genres!.length,
                                        (indexGenre) => GenreDescription(
                                          title: stateMovie.genres![indexGenre],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () => {
                                  if (stateMovie.ytTrailerCode == '')
                                    throw 'Not Yet Available'
                                  else
                                    {
                                      log("code: ${stateMovie.ytTrailerCode}"),
                                      _lanuchUrl(stateMovie.ytTrailerCode),
                                    }
                                },
                                child: Text(
                                  'Movie Trailer',
                                  style: Theme.of(context).textTheme.button,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppPadding(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Movie Description',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const Divider(),
                        _BookDescription(stateMovie.descriptionFull),
                        BlocBuilder<MovieSuggestionBloc, MovieSuggestionState>(
                          builder: (context, state) {
                            if (state is MovieSuggestionLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is MovieSuggestionFailed) {
                              return Center(child: Text(state.message));
                            }
                            if (state is MovieSuggestionLoaded) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Movie Suggestion',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  ...List.generate(
                                    state.movieSuggestion.movieCount,
                                    (index) {
                                      final movie = state.movieSuggestion.movies[index];
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: GestureDetector(
                                          onTap: () => GoRouter.of(context).pushNamed(
                                            HomeDetailPage.routeName,
                                            queryParams: {
                                              'movie_id': movie.id.toString(),
                                            },
                                          ),
                                          child: BookItemCard(
                                            description: movie.synopsis,
                                            imgurl: movie.mediumCoverImage,
                                            producer: movie.rating.toString(),
                                            title: movie.titleEnglish,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                            return const Center(
                              child: Text('Something went worng'),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is MovieDetailFailed) {
            return Text(state.message);
          }
          return const Center(
            child: Text('Something Went Worng'),
          );
        },
      ),
    );
  }
}

class _CustomMovieDetailStatus extends StatelessWidget {
  const _CustomMovieDetailStatus({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }
}

class _BookDescription extends StatefulWidget {
  const _BookDescription(String description) : _description = description;

  final String _description;

  @override
  State<_BookDescription> createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<_BookDescription> {
  bool isShowMore = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            widget._description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  letterSpacing: 2,
                  height: 2,
                  color: Colors.grey,
                ),
            maxLines: isShowMore ? null : 2,
            overflow: isShowMore ? null : TextOverflow.ellipsis,
          ),
          TextButton(
            onPressed: () {
              isShowMore = !isShowMore;
              setState(() {});
            },
            child: const Text('show more'),
          ),
        ],
      ),
    );
  }
}

class GenreDescription extends StatelessWidget {
  const GenreDescription({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

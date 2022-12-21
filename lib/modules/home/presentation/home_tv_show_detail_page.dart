import 'dart:developer';

import 'package:e_book_app/index.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeTvShowDetailPage extends StatefulWidget {
  const HomeTvShowDetailPage({
    super.key,
    required this.tvShowId,
  });

  static const String routeName = 'home_tv_show_detail_page';
  static const String routePath = '/home_tv_show_detail_page';

  final String tvShowId;

  static final GoRoute route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => HomeTvShowDetailPage(
      tvShowId: state.queryParams['tv_show_id'] ?? '',
    ),
  );

  @override
  State<HomeTvShowDetailPage> createState() => _HomeTvShowDetailPageState();
}

class _HomeTvShowDetailPageState extends State<HomeTvShowDetailPage> {
  int movieIndex = 0;
  String _title = '';
  String videoId = '';
  late ScrollController _scrollController;
  late YoutubePlayerController _youtubePlayerController;
  bool _showTitle = false;

  String _getTimeString(int value) {
    final hour = value ~/ 60;
    final minutes = value % 60;
    return '${hour.toString().padLeft(1, "0")}h:${minutes.toString().padLeft(2, "0")}m';
  }

  @override
  void initState() {
    super.initState();
    log(widget.tvShowId);

    _scrollController = ScrollController();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        forceHD: true,
      ),
    );
    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        _showTitle = true;
        setState(() {});
      } else {
        _showTitle = false;
        setState(() {});
      }
    });
    _onInit();
  }

  void _onInit() {
    BlocProvider.of<TvShowDetailBloc>(context).add(
      OnGetTvShowDetail(int.parse(widget.tvShowId)),
    );
    // BlocProvider.of<MovieSuggestionBloc>(context).add(
    //   OnGetMovieSuggestion(int.parse(widget.tvShowId)),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TvShowDetailBloc, TvShowDetailState>(
          listener: (context, state) {
            if (state is TvShowDetailLoaded) {
              if (state.tvShowDetail.isEmpty) {
                GoRouter.of(context).goNamed(
                  MainPage.routeName,
                );
              } else {
                _title = state.tvShowDetail.last.name ?? '';
                BlocProvider.of<TvShowVideoBloc>(context).add(
                  OnGetTvShowVideo(state.tvShowDetail.last.id!),
                );
              }
            }
          },
        ),
        BlocListener<TvShowVideoBloc, TvShowVideoState>(
          listener: (context, state) {
            if (state is TvShowVideoLoaded) {
              final videoOfficialId = state.tvShowVideos
                  .where(
                    (element) => element.official == true && element.type == 'Trailer',
                  )
                  .toList();

              if (videoOfficialId.isNotEmpty) {
                videoId = videoOfficialId.first.key;
                setState(() {});
              } else {
                videoId = state.tvShowVideos.first.key;
                setState(() {});
              }
            }
          },
        ),
      ],
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubePlayerController,
          showVideoProgressIndicator: true,
          onReady: () {
            _youtubePlayerController.load(videoId);
          },
        ),
        onExitFullScreen: () {
          // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        },
        builder: (_, player) => WillPopScope(
          onWillPop: () async {
            BlocListener<TvShowDetailBloc, TvShowDetailState>(
              listener: (context, state) {
                if (state is TvShowDetailLoaded) {
                  if (state.tvShowDetail.isEmpty) {
                    GoRouter.of(context).goNamed(
                      MainPage.routeName,
                    );
                  } else {
                    _title = state.tvShowDetail.last.name!;
                    BlocProvider.of<TvShowVideoBloc>(context)
                        .add(OnGetTvShowVideo(state.tvShowDetail.last.id!));
                  }
                }
              },
            );
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              titleSpacing: 0,
              title: Row(
                children: [
                  BlocSelector<TvShowDetailBloc, TvShowDetailState, TvShowDetailLoaded?>(
                    selector: (state) {
                      if (state is TvShowDetailLoaded) {
                        return state;
                      }
                      return null;
                    },
                    builder: (context, state) {
                      return CustomIconWidget(
                        icon: Icons.arrow_back,
                        onPressed: () {
                          if (state != null) {
                            GoRouter.of(context).pop();
                            BlocProvider.of<MovieDetailBloc>(context).add(
                              const OnRemoveMovieDetail(),
                            );
                          }
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: AnimatedOpacity(
                      opacity: _showTitle ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        _title,
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
            body: Column(
              children: <Widget>[
                BlocBuilder<TvShowVideoBloc, TvShowVideoState>(
                  builder: (context, state) {
                    if (state is TvShowVideoFailed) {
                      return Text(state.message);
                    }
                    if (state is TvShowVideoLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (state is TvShowVideoLoaded) {
                      return AppPadding(child: player);
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 10),
                BlocBuilder<TvShowDetailBloc, TvShowDetailState>(
                  builder: (context, state) {
                    if (state is TvShowDetailLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (state is TvShowDetailFailed) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is TvShowDetailLoaded) {
                      if (state.tvShowDetail.isNotEmpty) {
                        final stateTvShow = state.tvShowDetail.last;
                        // final runtime = _getTimeString(stateTvShow.numberOfSeasons!);
                        return Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: <Widget>[
                                AppPadding(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: Banner(
                                            message: '//${stateTvShow.voteAverage ?? ''}',
                                            location: BannerLocation.topEnd,
                                            child: Image.network(
                                              AppData.imagePath(
                                                posterPath: stateTvShow.posterPath ?? '',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
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
                                                  stateTvShow.name!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                        letterSpacing: 2,
                                                        height: 1.5,
                                                      ),
                                                ),
                                                const SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    CustomMovieTvDetailStatus(
                                                      icon: Icons.thumb_up_outlined,
                                                      title: NumberFormat.compact()
                                                          .format(stateTvShow.popularity),
                                                    ),
                                                    CustomMovieTvDetailStatus(
                                                      icon: Icons.movie,
                                                      title:
                                                          '${stateTvShow.numberOfEpisodes} Episode',
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                CustomMovieTvDetailStatus(
                                                  icon: Icons.today,
                                                  title: stateTvShow.firstAirDate!.split('-').first,
                                                ),
                                                const SizedBox(height: 20),
                                                if (stateTvShow.genres != null)
                                                  Wrap(
                                                    spacing: 10,
                                                    runSpacing: 10,
                                                    children: List.generate(
                                                      stateTvShow.genres!.length,
                                                      (indexGenre) => GenreDescription(
                                                        title:
                                                            stateTvShow.genres![indexGenre].name!,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            TextButton(
                                              onPressed: () {},
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
                                        'Series Description',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                      ),
                                      const Divider(),
                                      BookDescription(
                                        stateTvShow.overview!,
                                      ),
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
                                            // log(state.movieSuggestion.length.toString());
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Series Suggestion',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                        color:
                                                            Theme.of(context).colorScheme.primary,
                                                      ),
                                                ),
                                                const SizedBox(height: 10),
                                                const Divider(thickness: 2),
                                                const SizedBox(height: 10),
                                                if (state.movieSuggestion.isNotEmpty)
                                                  ...List.generate(
                                                    state.movieSuggestion.length,
                                                    (index) {
                                                      final movie = state.movieSuggestion[index];
                                                      return Container(
                                                        margin: const EdgeInsets.symmetric(
                                                          vertical: 10,
                                                        ),
                                                        height: 150,
                                                        child: GestureDetector(
                                                          onTap: () =>
                                                              GoRouter.of(context).pushNamed(
                                                            HomeDetailPage.routeName,
                                                            queryParams: {
                                                              'movie_id': movie.id.toString(),
                                                            },
                                                          ),
                                                          child: BookItemCard(
                                                            description: movie.overview,
                                                            isRRated: movie.adult,
                                                            imgUrl: movie.posterPath ??
                                                                movie.backdropPath ??
                                                                '',
                                                            producer: movie.voteAverage.toString(),
                                                            title: movie.title,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                else
                                                  Center(
                                                    child: Text(
                                                      'No Movie Suggestion',
                                                      style:
                                                          Theme.of(context).textTheme.labelMedium,
                                                    ),
                                                  )
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
                          ),
                        );
                      }
                    }
                    if (state is TvShowDetailFailed) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(
                      child: Text('Something Went Wrong'),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

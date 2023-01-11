import 'dart:developer';
import 'dart:ui';

import 'package:e_book_app/index.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class HomeDetailPage extends StatefulWidget {
  const HomeDetailPage({
    super.key,
    required this.url,
    required this.suggestionUrl,
    required this.reviewUrl,
    required this.videoUrl,
    this.onPressed,
    required this.type,
  });

  static const String routeName = 'home_detail_page';
  static const String routePath = '/home_detail_page';

  final String url;
  final String suggestionUrl;
  final String reviewUrl;
  final String videoUrl;
  final DetailType? type;
  final void Function(String)? onPressed;

  static final route = GoRoute(
    path: routePath,
    name: routeName,
    builder: (context, state) => HomeDetailPage(
      url: state.queryParams['url'] ?? '',
      suggestionUrl: state.queryParams['suggestion_url'] ?? '',
      reviewUrl: state.queryParams['review_url'] ?? '',
      videoUrl: state.queryParams['video_url'] ?? '',
      type: state.extra as DetailType?,
    ),
    pageBuilder: (context, state) => AppRouteTransition(
      context: context,
      state: state,
      child: HomeDetailPage(
        url: state.queryParams['url'] ?? '',
        suggestionUrl: state.queryParams['suggestion_url'] ?? '',
        reviewUrl: state.queryParams['review_url'] ?? '',
        videoUrl: state.queryParams['video_url'] ?? '',
        type: state.extra as DetailType?,
      ),
    ),
  );

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> with AutomaticKeepAliveClientMixin {
  int movieIndex = 2;
  String _title = '';
  String _trailerId = '';
  PaginateStatus _status = PaginateStatus.initial;
  late ScrollController _scrollController;
  late YoutubePlayerController _youtubePlayerController;
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: '',
      flags: const YoutubePlayerFlags(
        forceHD: true,
        autoPlay: false,
        disableDragSeek: true,
      ),
    );
    _onInit();
  }

  void _scrollListener() {
    final offset = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;

    if (offset > 100) {
      if (!_showTitle) {
        _showTitle = true;
        setState(() {});
      }
    } else {
      if (_showTitle) {
        _showTitle = false;
        setState(() {});
      }
    }

    if (offset == maxScroll && _status != PaginateStatus.empty) {
      BlocProvider.of<MovieSuggestionBloc>(context).add(
        OnGetMovieSuggestionNext(
          pageNumber: movieIndex,
          url: widget.suggestionUrl,
        ),
      );
      movieIndex += 1;
    }
  }

  void _onInit() {
    BlocProvider.of<MovieDetailBloc>(context).add(
      OnGetMovieDetail(url: widget.url),
    );
    BlocProvider.of<MovieSuggestionBloc>(context).add(
      OnGetMovieSuggestion(widget.suggestionUrl),
    );
    BlocProvider.of<MovieReviewsBloc>(context).add(
      OnGetMovieReviews(url: widget.reviewUrl),
    );
    BlocProvider.of<GetVideoInfoBloc>(context).add(
      OnGetVideoInfo(widget.videoUrl),
    );
  }

  @override
  void dispose() {
    _showTitle = false;
    // trailerId.removeLast();
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<MovieSuggestionBloc, MovieSuggestionState>(
          listener: (context, state) {
            if (state is MovieSuggestionLoaded) {
              _status = state.status;
            }
          },
        ),
        BlocListener<MovieDetailBloc, MovieDetailState>(
          listener: (context, state) {
            if (state is MovieDetailLoaded) {
              _title = state.movieDetail!.title!;
            }
          },
        ),
        BlocListener<GetVideoInfoBloc, GetVideoInfoState>(
          listener: (context, state) {
            late VideoModelResults videoOfficialId;
            if (state is GetVideoInfoLoaded) {
              videoOfficialId = state.videoInfo.firstWhere(
                (element) => element.official == true && element.type == 'Trailer',
              );
              _trailerId = videoOfficialId.key;
            }
            log('trailer id ============> ${_trailerId}');
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          BlocProvider.of<MovieDetailBloc>(context).add(
            const OnRemoveMovieDetail(),
          );
          // trailerId.removeLast();
          GoRouter.of(context).pop();
          return true;
        },
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _youtubePlayerController,
            bufferIndicator: const CircularProgressIndicator(),
            onReady: () => _youtubePlayerController.cue(_trailerId),
          ),
          onExitFullScreen: () => SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: SystemUiOverlay.values,
          ),
          builder: (_, player) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              titleSpacing: 0,
              title: _DetailAppBar(
                showTitle: _showTitle,
                title: _title,
              ),
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
                builder: (context, state) {
                  if (state is MovieDetailLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is MovieDetailLoaded) {
                    final stateMovie = state.movieDetail!;
                    return _MovieDetailLoadedSection(
                      url: widget.reviewUrl,
                      type: widget.type!,
                      player: player,
                      stateMovie: stateMovie,
                      onPressed: widget.onPressed,
                    );
                  }
                  if (state is MovieDetailFailed) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return const Center(
                    child: Text('Something Went Wrong'),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _MovieDetailLoadedSection extends StatelessWidget {
  const _MovieDetailLoadedSection({
    super.key,
    required this.stateMovie,
    this.onPressed,
    required this.url,
    required this.type,
    required this.player,
  });

  final MovieAndSeriesDetailResModel stateMovie;
  final void Function(String)? onPressed;
  final DetailType type;
  final String url;
  final Widget player;

  String _getTimeString(int value) {
    final hour = value ~/ 60;
    final minutes = value % 60;
    return '${hour.toString().padLeft(1, "0")}h:${minutes.toString().padLeft(2, "0")}m';
  }

  @override
  Widget build(BuildContext context) {
    final runtime = _getTimeString(stateMovie.runtime ?? 0);
    final isMovie = type == DetailType.movie;
    return Column(
      children: <Widget>[
        AppPadding(
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.red,
                width: 3,
              ),
            ),
            child: player,
          ),
        ),
        const SizedBox(height: 10),
        AppPadding(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Banner(
                    message: '${stateMovie.voteAverage!.round()}',
                    location: BannerLocation.topEnd,
                    child: GestureDetector(
                      onTap: () => GoRouter.of(context).pushNamed(
                        FullScreenImage.routeName,
                        queryParams: {
                          'id': stateMovie.id.toString(),
                          'image_path': stateMovie.posterPath.toString(),
                        },
                      ),
                      child: CachedNetworkImage(
                        imageUrl: AppData.imagePath(posterPath: stateMovie.posterPath ?? ''),
                        fit: BoxFit.cover,
                        memCacheHeight: 400,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: AppColors.gray,
                          highlightColor: AppColors.black,
                          child: const SizedBox(),
                        ),
                      ),
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
                          stateMovie.title ?? '',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                              title: NumberFormat.compact().format(stateMovie.popularity),
                            ),
                            CustomMovieTvDetailStatus(
                              icon: Icons.timelapse_outlined,
                              title: runtime,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomMovieTvDetailStatus(
                          icon: Icons.today,
                          title: stateMovie.releaseDate ?? ''.split('-').first,
                        ),
                        const SizedBox(height: 20),
                        if (stateMovie.genres != null)
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(
                              stateMovie.genres!.length,
                              (indexGenre) => GenreDescription(
                                title: stateMovie.genres![indexGenre].name,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      title: 'Reviews',
                      onPressed: () => MovieReview.showMovieReview(
                        context,
                        url: url,
                      ),
                    ),
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
            children: <Widget>[
              Text(
                '${isMovie ? 'Movie' : 'Series'} Description',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(thickness: 1),
              BookDescription(stateMovie.overview),
            ],
          ),
        ),
        _MovieSuggestionSection(
          onPressed: onPressed,
          isMovie: isMovie,
        ),
      ],
    );
  }
}

class _MovieSuggestionSection extends StatelessWidget {
  const _MovieSuggestionSection({
    required this.onPressed,
    required this.isMovie,
  });

  final void Function(String)? onPressed;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return AppPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BlocBuilder<MovieSuggestionBloc, MovieSuggestionState>(
            builder: (context, state) {
              if (state is MovieSuggestionFailed) {
                return Center(child: Text(state.message));
              }
              if (state is MovieSuggestionLoaded) {
                final listOfSuggestionMovies = <Widget>[];

                for (final element in state.movieSuggestion) {
                  listOfSuggestionMovies.add(
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      height: 150,
                      child: GestureDetector(
                        onTap: () => onPressed!(element.id.toString()),
                        child: BookItemCard(
                          description: element.overview,
                          isRRated: element.adult,
                          imgUrl: element.posterPath ?? element.backdropPath ?? '',
                          producer: element.voteAverage.toString(),
                          title: element.title,
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${isMovie ? 'Movie' : 'Series'} Suggestion',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const Divider(thickness: 2),
                    if (state.movieSuggestion.isNotEmpty) ...[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => index >= state.movieSuggestion.length
                            ? const BottomLoader()
                            : listOfSuggestionMovies[index],
                        itemCount: state.hasReachLimit
                            ? listOfSuggestionMovies.length
                            : listOfSuggestionMovies.length + 1,
                      ),
                      if (state.status == PaginateStatus.empty)
                        Center(
                          child: Text(
                            'No more suggestion',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                    ] else
                      Center(
                        child: Text(
                          'No Movie Suggestion',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      )
                  ],
                );
              }
              return const Center(
                child: Text(AppData.somethingWentWrong),
              );
            },
          )
        ],
      ),
    );
  }
}

class _DetailAppBar extends StatelessWidget {
  const _DetailAppBar({
    required bool showTitle,
    required String title,
  })  : _showTitle = showTitle,
        _title = title;

  final bool _showTitle;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconWidget(
          icon: Icons.arrow_back,
          onPressed: () {
            BlocProvider.of<MovieDetailBloc>(context).add(
              const OnRemoveMovieDetail(),
            );
            GoRouter.of(context).pop();
          },
        ),
        Expanded(
          child: AnimatedOpacity(
            opacity: _showTitle ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: Text(
              _title,
              style: Theme.of(context).textTheme.headlineLarge,
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
    );
  }
}

class GenreDescription extends StatelessWidget {
  const GenreDescription({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(),
      ),
    );
  }
}

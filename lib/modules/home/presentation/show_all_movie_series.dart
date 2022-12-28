import 'dart:developer';

import 'package:e_book_app/index.dart';

class ShowAllMovieSeries extends StatefulWidget {
  const ShowAllMovieSeries({
    super.key,
    required this.status,
    required this.title,
  });

  static const String routeName = 'show_all_movie_series';
  static const String routePath = '/show_all_movie_series';

  final ShowAllStatus status;
  final String title;

  static final GoRoute route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => ShowAllMovieSeries(
      status: state.extra! as ShowAllStatus,
      title: state.queryParams['title'] ?? '',
    ),
    pageBuilder: (context, state) => AppRouteTransition<ShowAllMovieSeries>(
      context: context,
      state: state,
      child: ShowAllMovieSeries(
        status: state.extra! as ShowAllStatus,
        title: state.queryParams['title'] ?? '',
      ),
    ),
  );

  @override
  State<ShowAllMovieSeries> createState() => _ShowAllMovieSeriesState();
}

class _ShowAllMovieSeriesState extends State<ShowAllMovieSeries> {
  int pageNumber = 1;
  late ScrollController _scrollController;
  bool _isShowButton = false;
  PaginateStatus status = PaginateStatus.initial;

  ShowAllStatus get _status => widget.status;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    switch (_status) {
      case ShowAllStatus.upcomingMovies:
        return BlocProvider.of<UpcomingMoviesBloc>(context).add(
          const OnGetUpcomingMovies(),
        );
      case ShowAllStatus.inTheater:
        return BlocProvider.of<NowPlayingMoviesBloc>(context).add(
          const OnGetNowPlayingMovies(),
        );
      case ShowAllStatus.popularMovies:
        return BlocProvider.of<UpcomingMoviesBloc>(context).add(
          const OnGetUpcomingMovies(),
        );
      case ShowAllStatus.popularSeries:
        return BlocProvider.of<UpcomingMoviesBloc>(context).add(
          const OnGetUpcomingMovies(),
        );
      case ShowAllStatus.topRatedMovies:
        return BlocProvider.of<UpcomingMoviesBloc>(context).add(
          const OnGetUpcomingMovies(),
        );
      case ShowAllStatus.topRatedSeries:
        return BlocProvider.of<UpcomingMoviesBloc>(context).add(
          const OnGetUpcomingMovies(),
        );
      default:
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
  }

  void _scrollListener() {
    final maxExtent = _scrollController.position.maxScrollExtent;
    final currentPosition = _scrollController.offset;

    if (currentPosition > 300) {
      _isShowButton = true;
      setState(() {});
    } else {
      _isShowButton = false;
      setState(() {});
    }

    if (currentPosition == maxExtent && status != PaginateStatus.empty) {
      _getPaginate();
    }
  }

  void _getPaginate() {
    pageNumber += 1;
    log('$pageNumber');
    switch (widget.status) {
      case ShowAllStatus.upcomingMovies:
        return BlocProvider.of<UpcomingMoviesBloc>(context).add(
          OnGetUpcomingMoviesPaginate(pageNumber),
        );
      case ShowAllStatus.inTheater:
        return BlocProvider.of<NowPlayingMoviesBloc>(context).add(
          OnGetNowPlayingMoviesPaginate(pageNumber),
        );
      case ShowAllStatus.popularMovies:
        return BlocProvider.of<UpcomingMoviesBloc>(context).add(
          OnGetUpcomingMoviesPaginate(pageNumber),
        );
      case ShowAllStatus.popularSeries:
        return BlocProvider.of<UpcomingMoviesBloc>(context).add(
          OnGetUpcomingMoviesPaginate(pageNumber),
        );
      case ShowAllStatus.topRatedMovies:
        return BlocProvider.of<UpcomingMoviesBloc>(context).add(
          OnGetUpcomingMoviesPaginate(pageNumber),
        );
      case ShowAllStatus.topRatedSeries:
        return BlocProvider.of<UpcomingMoviesBloc>(context).add(
          OnGetUpcomingMoviesPaginate(pageNumber),
        );
      default:
    }
  }

  bool _isGrid = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpcomingMoviesBloc, UpcomingMoviesState>(
          listener: (context, state) {
            if (state is UpcomingMoviesLoaded) {
              status = state.status;
            }
          },
        ),
        BlocListener<NowPlayingMoviesBloc, NowPlayingMoviesState>(
          listener: (context, state) {
            if (state is NowPlayingMoviesLoaded) {
              status = state.status;
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          leading: const AppLeadingButton(),
          actions: [
            AppAnimatedIcon(
              icon1: Icons.grid_on,
              icon2: Icons.view_day_outlined,
              onChanged: (value) => setState(() => _isGrid = value),
              animated: _isGrid,
            ),
          ],
        ),
        body: AppPadding(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                if (_status == ShowAllStatus.upcomingMovies) ...[
                  UpcomingMovieShowAll(isGrid: _isGrid)
                ],
                if (_status == ShowAllStatus.inTheater) ...[
                  NowPlayingMoviesShowAll(isGrid: _isGrid),
                ],
                if (_status == ShowAllStatus.upcomingMovies) ...[
                  UpcomingMovieShowAll(isGrid: _isGrid)
                ],
                if (_status == ShowAllStatus.upcomingMovies) ...[
                  UpcomingMovieShowAll(isGrid: _isGrid)
                ],
              ],
            ),
          ),
        ),
        floatingActionButton: _isShowButton
            ? FloatingActionButton.small(
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceIn,
                  );
                },
                backgroundColor: Theme.of(context).iconTheme.color,
                child: const Icon(
                  Icons.arrow_upward,
                  color: AppColors.white,
                ),
              )
            : null,
      ),
    );
  }
}

class UpcomingMovieShowAll extends StatelessWidget {
  const UpcomingMovieShowAll({
    super.key,
    required bool isGrid,
  }) : _isGrid = isGrid;

  final bool _isGrid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
      builder: (context, state) {
        if (state is UpcomingMoviesFailed) {
          return const Text(AppData.somethingWentWrong);
        }
        if (state is UpcomingMoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is UpcomingMoviesLoaded) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _isGrid ? 3 : 1,
                  childAspectRatio: .75,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  final upcoming = state.upComingMovies[index];
                  return MoviesTvShowCardBox(
                    type: DetailType.movie,
                    id: '${upcoming.id}',
                    imgUrl: upcoming.posterPath ?? '',
                    title: upcoming.title,
                    rating: upcoming.popularity,
                  );
                },
                itemCount: state.upComingMovies.length,
              ),
              if (state.status == PaginateStatus.empty) ...[
                const Text('End'),
              ],
              if (state.status == PaginateStatus.loading) ...[
                const CircularProgressIndicator(),
              ],
              const SizedBox(height: 20),
            ],
          );
        }
        return const Text(AppData.somethingWentWrong);
      },
    );
  }
}

class NowPlayingMoviesShowAll extends StatelessWidget {
  const NowPlayingMoviesShowAll({
    super.key,
    required bool isGrid,
  }) : _isGrid = isGrid;

  final bool _isGrid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      builder: (context, state) {
        if (state is NowPlayingMoviesFailed) {
          return const Text(AppData.somethingWentWrong);
        }
        if (state is NowPlayingMoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is NowPlayingMoviesLoaded) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _isGrid ? 3 : 1,
                  childAspectRatio: .75,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  final nowPlaying = state.nowPlayingMovies[index];
                  return MoviesTvShowCardBox(
                    type: DetailType.movie,
                    id: '${nowPlaying.id}',
                    imgUrl: nowPlaying.posterPath ?? nowPlaying.backdropPath ?? '',
                    title: nowPlaying.title,
                    rating: nowPlaying.popularity,
                  );
                },
                itemCount: state.nowPlayingMovies.length,
              ),
              if (state.status == PaginateStatus.empty) ...[
                const Text('End'),
              ],
              if (state.status == PaginateStatus.loading) ...[
                const CircularProgressIndicator(),
              ],
              const SizedBox(height: 20),
            ],
          );
        }
        return const Text(AppData.somethingWentWrong);
      },
    );
  }
}

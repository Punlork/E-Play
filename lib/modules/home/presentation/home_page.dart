import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_book_app/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    bool isBacktoTop = false,
  }) : _isBacktoTop = isBacktoTop;

  static const String routeName = 'home_page';
  static const String routePath = '/home_page';

  final bool _isBacktoTop;

  static final route = GoRoute(
    path: routePath,
    name: routeName,
    builder: (context, state) => const HomePage(),
  );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  late final ScrollController _controller;
  int pageNumber = 1;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    onGetMovies();
  }

  void onGetMovies() {
    BlocProvider.of<PopularMoviesBloc>(context).add(
      OnGetPopularMovies(),
    );
    BlocProvider.of<UpcomingMoviesBloc>(context).add(
      const OnGetUpcomingMovies(),
    );
    BlocProvider.of<NowPlayingMoviesBloc>(context).add(
      const OnGetNowPlayingMovies(),
    );
    BlocProvider.of<PopularTvShowsBloc>(context).add(
      const OnGetPopularTvShow(1),
    );
    BlocProvider.of<GetTrendingBloc>(context).add(
      const OnGetTrending('movie'),
    );
    BlocProvider.of<TopRatedMoviesBloc>(context).add(
      const OnGetTopRatedMovies(1),
    );
    BlocProvider.of<TopRatedTvShowBloc>(context).add(
      const OnGetTopRatedTvShow(1),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie App',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BlocBuilder<GetTrendingBloc, GetTrendingState>(
              builder: (context, state) {
                if (state is GetTrendingFailed) {
                  return Text(state.message);
                }
                if (state is GetTrendingLoading) {
                  return Shimmer.fromColors(
                    baseColor: AppColors.gray,
                    highlightColor: AppColors.white,
                    child: CarouselSlider.builder(
                      itemCount: 10,
                      itemBuilder: (context, index, realIndex) {
                        return AppPadding(
                          horizontal: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 0.9,
                        aspectRatio: 2.5,
                      ),
                    ),
                  );
                }
                if (state is GetTrendingLoaded) {
                  final trending = state.trendingResult;
                  return CarouselSlider.builder(
                    itemCount: trending.length,
                    itemBuilder: (context, index, realIndex) {
                      return AppPadding(
                        horizontal: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                AppData.imagePath(
                                  posterPath: trending[index].backdropPath!,
                                ),
                              ),
                              // fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              trending[index].title ?? '',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.white,
                                  ),
                            ),
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 0.9,
                      aspectRatio: 2.5,
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            AppPadding(
              child: GestureDetector(
                onTap: () => GoRouter.of(context).pushNamed(
                  UpcomingMovieShowAll.routeName,
                ),
                child: Row(
                  children: [
                    Text(
                      'Upcoming Movies',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    CustomIconWidget(
                      icon: Icons.arrow_forward_sharp,
                      onPressed: () => GoRouter.of(context).pushNamed(
                        UpcomingMovieShowAll.routeName,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
              builder: (context, state) {
                if (state is UpcomingMoviesLoading) {
                  return const ShimmerLoading();
                }
                if (state is UpcomingMoviesLoaded) {
                  final upcomingMovie = state.upComingMovies;
                  return SizedBox.fromSize(
                    size: const Size.fromHeight(150),
                    child: ListView.builder(
                      itemBuilder: (context, index) => MoviesTvShowCardBox(
                        type: DetailType.movie,
                        id: upcomingMovie[index].id.toString(),
                        imgUrl: upcomingMovie[index].posterPath ?? '',
                        title: upcomingMovie[index].title,
                        rating: upcomingMovie[index].voteAverage,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: upcomingMovie.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      // controller: _controller,
                    ),
                  );
                }
                if (state is UpcomingMoviesFailed) {
                  return const Text('Failed to get Movie');
                }
                return const Text(
                  AppData.somethingWentWrong,
                );
              },
            ),
            AppPadding(
              child: GestureDetector(
                onTap: () => GoRouter.of(context).pushNamed(
                  ShowAllMovieSeries.routeName,
                  queryParams: {
                    'title': 'In Theater',
                  },
                  extra: ShowAllStatus.inTheater,
                ),
                child: Row(
                  children: [
                    Text(
                      'In Theater',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    CustomIconWidget(
                      icon: Icons.arrow_forward_sharp,
                      onPressed: () => GoRouter.of(context).pushNamed(
                        ShowAllMovieSeries.routeName,
                        queryParams: {
                          'title': 'In Theater',
                        },
                        extra: ShowAllStatus.inTheater,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
              builder: (context, state) {
                if (state is NowPlayingMoviesLoading) {
                  return const ShimmerLoading();
                }
                if (state is NowPlayingMoviesFailed) {
                  return Text(state.message);
                }
                if (state is NowPlayingMoviesLoaded) {
                  final nowPlaying = state.nowPlayingMovies;

                  return SizedBox.fromSize(
                    size: const Size.fromHeight(150),
                    child: ListView.builder(
                      itemBuilder: (context, index) => MoviesTvShowCardBox(
                        type: DetailType.movie,
                        id: nowPlaying[index].id.toString(),
                        imgUrl:
                            nowPlaying[index].posterPath ?? nowPlaying[index].backdropPath ?? '',
                        title: nowPlaying[index].title,
                        rating: nowPlaying[index].voteAverage,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: nowPlaying.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      // controller: _controller,
                    ),
                  );
                }

                return const Text(AppData.somethingWentWrong);
              },
            ),
            AppPadding(
              child: GestureDetector(
                onTap: () => GoRouter.of(context).pushNamed(
                  PopularMovieShowAll.routeName,
                ),
                child: Row(
                  children: [
                    Text(
                      'Popular Movies',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    CustomIconWidget(
                      icon: Icons.arrow_forward_sharp,
                      onPressed: () => GoRouter.of(context).pushNamed(
                        PopularMovieShowAll.routeName,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
              builder: (context, state) {
                if (state is PopularMoviesLoading) {
                  return const ShimmerLoading();
                }
                if (state is PopularMoviesFailure) {
                  return Text(state.message);
                }
                if (state is PopularMoviesLoaded) {
                  return SizedBox.fromSize(
                    size: const Size.fromHeight(150),
                    child: ListView.builder(
                      itemBuilder: (context, index) => MoviesTvShowCardBox(
                        type: DetailType.movie,
                        id: state.popularMovies[index].id.toString(),
                        imgUrl: state.popularMovies[index].posterPath,
                        title: state.popularMovies[index].title,
                        rating: state.popularMovies[index].voteAverage,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.popularMovies.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      // controller: _controller,
                    ),
                  );
                } else {
                  return const Text('Something went wrong');
                }
              },
            ),
            AppPadding(
              child: GestureDetector(
                onTap: () => GoRouter.of(context).pushNamed(
                  ShowAllMovieSeries.routeName,
                  queryParams: {
                    'title': 'Popular Series',
                  },
                  extra: ShowAllStatus.popularSeries,
                ),
                child: Row(
                  children: [
                    Text(
                      'Popular Series',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    CustomIconWidget(
                      icon: Icons.arrow_forward_sharp,
                      onPressed: () => GoRouter.of(context).pushNamed(
                        ShowAllMovieSeries.routeName,
                        queryParams: {
                          'title': 'Popular Series',
                        },
                        extra: ShowAllStatus.popularSeries,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<PopularTvShowsBloc, PopularTvShowsState>(
              builder: (context, state) {
                if (state is PopularTvShowsLoading) {
                  return const ShimmerLoading();
                }
                if (state is PopularTvShowsFailed) {
                  return Text(state.message);
                }
                if (state is PopularTvShowsLoaded) {
                  final popularTvShows = state.popularTvShows;
                  return SizedBox.fromSize(
                    size: const Size.fromHeight(150),
                    child: ListView.builder(
                      itemBuilder: (context, index) => MoviesTvShowCardBox(
                        type: DetailType.tvShow,
                        id: popularTvShows[index].id.toString(),
                        imgUrl: popularTvShows[index].posterPath,
                        title: popularTvShows[index].name,
                        rating: popularTvShows[index].voteAverage,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: popularTvShows.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      // controller: _controller,
                    ),
                  );
                }
                return const Text(AppData.somethingWentWrong);
              },
            ),
            AppPadding(
              child: GestureDetector(
                onTap: () => GoRouter.of(context).pushNamed(
                  ShowAllMovieSeries.routeName,
                  queryParams: {
                    'title': 'Top Rated Movies',
                  },
                  extra: ShowAllStatus.topRatedMovies,
                ),
                child: Row(
                  children: [
                    Text(
                      'Top Rated Movies',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    CustomIconWidget(
                      icon: Icons.arrow_forward_sharp,
                      onPressed: () => GoRouter.of(context).pushNamed(
                        ShowAllMovieSeries.routeName,
                        queryParams: {
                          'title': 'Top Rated Movies',
                        },
                        extra: ShowAllStatus.topRatedMovies,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
              builder: (context, state) {
                if (state is TopRatedMoviesFailed) {
                  return Text(state.message);
                }
                if (state is TopRatedMoviesLoading) {
                  return const ShimmerLoading();
                }
                if (state is TopRatedMoviesLoaded) {
                  final topRatedMovies = state.topRatedMovies;
                  return SizedBox.fromSize(
                    size: const Size.fromHeight(150),
                    child: ListView.builder(
                      itemBuilder: (context, index) => MoviesTvShowCardBox(
                        type: DetailType.movie,
                        id: topRatedMovies[index].id.toString(),
                        imgUrl: topRatedMovies[index].posterPath,
                        title: topRatedMovies[index].title,
                        rating: topRatedMovies[index].voteAverage,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: topRatedMovies.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      // controller: _controller,
                    ),
                  );
                }
                return const Text(AppData.somethingWentWrong);
              },
            ),
            AppPadding(
              child: GestureDetector(
                onTap: () => GoRouter.of(context).pushNamed(
                  ShowAllMovieSeries.routeName,
                  queryParams: {
                    'title': 'Top Rated Series',
                  },
                  extra: ShowAllStatus.topRatedSeries,
                ),
                child: Row(
                  children: [
                    Text(
                      'Top Rated Series',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    CustomIconWidget(
                      icon: Icons.arrow_forward_sharp,
                      onPressed: () => GoRouter.of(context).pushNamed(
                        ShowAllMovieSeries.routeName,
                        queryParams: {
                          'title': 'Top Rated Series',
                        },
                        extra: ShowAllStatus.topRatedSeries,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<TopRatedTvShowBloc, TopRatedTvShowState>(
              builder: (context, state) {
                if (state is TopRatedTvShowFailed) {
                  return Text(state.message);
                }
                if (state is TopRatedTvShowLoading) {
                  return const ShimmerLoading();
                }
                if (state is TopRatedTvShowLoaded) {
                  final topRatedTvShow = state.topRatedTvShow;
                  return SizedBox.fromSize(
                    size: const Size.fromHeight(150),
                    child: ListView.builder(
                      itemBuilder: (context, index) => MoviesTvShowCardBox(
                        type: DetailType.tvShow,
                        id: topRatedTvShow[index].id.toString(),
                        imgUrl: topRatedTvShow[index].posterPath,
                        title: topRatedTvShow[index].name,
                        rating: topRatedTvShow[index].voteAverage,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: topRatedTvShow.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      // controller: _controller,
                    ),
                  );
                }
                return const Text(AppData.somethingWentWrong);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.title, this.onPressed});

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: Theme.of(context).textTheme.button?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}

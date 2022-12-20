import 'dart:developer';

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

class _HomePageState extends State<HomePage> {
  late final ScrollController _controller;
  int pageNumber = 1;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(
      () {
        // if (_controller.offset == _controller.position.maxScrollExtent) {
        //   print('Offset: ${_controller.offset}');
        //   print('Position: ${_controller.position.maxScrollExtent}');
        //   BlocProvider.of<MovieBloc>(context).add(
        //     OnGetMoviesNextPage(pageNumber: pageNumber++),
        //   );
        // }
      },
    );
    onGetMovies();
  }

  void onGetMovies() {
    // BlocProvider.of<MovieBloc>(context).add(OnGetMovies());
    BlocProvider.of<PopularMoviesBloc>(context).add(OnGetPopularMovies());
    BlocProvider.of<UpcomingMoviesBloc>(context).add(
      const OnGetUpcomingMovies(1),
    );
    BlocProvider.of<NowPlayingMoviesBloc>(context).add(
      const OnGetNowPlayingMovies(1),
    );
    BlocProvider.of<PopularTvShowsBloc>(context).add(
      const OnGetPopularTvShow(1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onGetMovies();
      },
      child: Scaffold(
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
              AppPadding(
                child: Text(
                  'Upcoming Movies',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
                builder: (context, state) {
                  if (state is UpcomingMoviesLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is UpcomingMoviesLoaded) {
                    final upcomingMovie = state.upComingMovies;
                    return SizedBox.fromSize(
                      size: const Size.fromHeight(250),
                      child: ListView.builder(
                        itemBuilder: (context, index) => MoviesTvShowCardBox(
                          id: upcomingMovie[index].id.toString(),
                          imgUrl: upcomingMovie[index].posterPath,
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
                child: Text(
                  'In Theater',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingMoviesLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is NowPlayingMoviesFailed) {
                    return Text(state.message);
                  }
                  if (state is NowPlayingMoviesLoaded) {
                    final nowPlaying = state.nowPlayingMovies;

                    return SizedBox.fromSize(
                      size: const Size.fromHeight(250),
                      child: ListView.builder(
                        itemBuilder: (context, index) => MoviesTvShowCardBox(
                          id: nowPlaying[index].id.toString(),
                          imgUrl: nowPlaying[index].posterPath,
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

                  return const Text(
                    AppData.somethingWentWrong,
                  );
                },
              ),
              AppPadding(
                child: Text(
                  'Popular Movies',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is PopularMoviesFailure) {
                    return Text(state.message);
                  }
                  if (state is PopularMoviesLoaded) {
                    return SizedBox.fromSize(
                      size: const Size.fromHeight(250),
                      child: ListView.builder(
                        itemBuilder: (context, index) => MoviesTvShowCardBox(
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
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

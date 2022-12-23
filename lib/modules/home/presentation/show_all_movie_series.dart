import 'package:e_book_app/index.dart';

class ShowAllMovieSeries extends StatefulWidget {
  const ShowAllMovieSeries({
    super.key,
    required this.title,
  });

  static const String routeName = 'show_all_movie_series';
  static const String routePath = '/show_all_movie_series';

  final String title;

  static final GoRoute route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => ShowAllMovieSeries(
      title: state.queryParams['title'] ?? '',
    ),
    pageBuilder: (context, state) => AppRouteTransition<ShowAllMovieSeries>(
      context: context,
      state: state,
      child: ShowAllMovieSeries(
        title: state.queryParams['title'] ?? '',
      ),
    ),
  );

  @override
  State<ShowAllMovieSeries> createState() => _ShowAllMovieSeriesState();
}

class _ShowAllMovieSeriesState extends State<ShowAllMovieSeries> {
  bool _isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _isGrid ? 2 : 1,
            childAspectRatio: .75,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) => const MoviesTvShowCardBox(
            type: DetailType.movie,
            id: 'sa',
            imgUrl: "https://www.themoviedb.org/t/p/original/6XM6VvqKueRI9kITnxe0CU1jGkH.jpg",
            title: 'Hameing',
            rating: 10,
          ),
          itemCount: 30,
        ),
      ),
    );
  }
}

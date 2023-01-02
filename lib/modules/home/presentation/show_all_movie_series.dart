import 'dart:developer';

import 'package:e_book_app/index.dart';

class ShowAllMovieSeries extends StatefulWidget {
  const ShowAllMovieSeries({
    super.key,
    required this.url,
    required this.title,
  });

  static const String routeName = 'show_all_movie_series';
  static const String routePath = '/show_all_movie_series';

  final String url;
  final String title;

  static final GoRoute route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => ShowAllMovieSeries(
      title: state.queryParams['title'] ?? '',
      url: state.queryParams['url'] ?? '',
    ),
  );

  @override
  State<ShowAllMovieSeries> createState() => _ShowAllMovieSeriesState();
}

class _ShowAllMovieSeriesState extends State<ShowAllMovieSeries> {
  late ScrollController _scrollController;
  bool _isShowButton = false;
  PaginateStatus status = PaginateStatus.initial;
  int _pageNumber = 1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    BlocProvider.of<ShowAllBloc>(context).add(
      ShowAllFetched(widget.url),
    );
  }

  @override
  void dispose() {
    _pageNumber = 1;
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  void _scrollListener() {
    final maxScroll = _scrollController.position.atEdge;
    final currentPosition = _scrollController.offset;

    if (currentPosition > 300) {
      if (!_isShowButton) {
        _isShowButton = true;
        setState(() {});
      }
    } else {
      if (_isShowButton) {
        _isShowButton = false;
        setState(() {});
      }
    }

    if (maxScroll && status != PaginateStatus.empty) {
      _pageNumber += 1;
      BlocProvider.of<ShowAllBloc>(context).add(
        ShowAllFetchedPaginate(
          url: widget.url,
          pageNumber: _pageNumber,
        ),
      );
    }
  }

  bool _isGrid = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShowAllBloc, ShowAllState>(
      listener: (context, state) {
        if (state is ShowAllLoaded) {
          status = state.status;
        }
      },
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
          child: Center(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: BlocBuilder<ShowAllBloc, ShowAllState>(
                builder: (context, state) {
                  if (state is ShowAllFailed) {
                    return const Text(AppData.somethingWentWrong);
                  }
                  if (state is ShowAllLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is ShowAllLoaded) {
                    final listOfShowAll = <Widget>[];

                    for (final element in state.showAll) {
                      listOfShowAll.add(
                        MoviesTvShowCardBox(
                          type: DetailType.movie,
                          id: element.id,
                          imgUrl: element.posterPath,
                          title: element.title,
                          rating: element.popularity,
                        ),
                      );
                    }

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
                          itemBuilder: (context, index) => index >= state.showAll.length
                              ? const BottomLoader()
                              : listOfShowAll[index],
                          itemCount:
                              state.hasReachLimit ? state.showAll.length : state.showAll.length + 1,
                        ),
                        if (state.status == PaginateStatus.empty) ...[
                          const Text('End'),
                        ],
                        const SizedBox(height: 20),
                      ],
                    );
                  }
                  return const Text(AppData.somethingWentWrong);
                },
              ),
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

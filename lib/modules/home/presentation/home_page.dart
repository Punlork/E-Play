import 'dart:developer';

import 'package:e_book_app/modules/component/index.dart';
import 'package:e_book_app/modules/home/application/movie/movie_bloc.dart';
import 'package:e_book_app/modules/home/presentation/home_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  // late MovieLoaded loadedSatate;
  int pageNumber = 2;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(
      () {
        if (_controller.offset == _controller.position.maxScrollExtent) {
          print('Offset: ${_controller.offset}');
          print('Position: ${_controller.position.maxScrollExtent}');
          BlocProvider.of<MovieBloc>(context).add(
            OnGetMoviesNextPage(pageNumber: pageNumber++),
          );
        }
      },
    );
    onGetMovies();
  }

  void onGetMovies() {
    BlocProvider.of<MovieBloc>(context).add(OnGetMovies());
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
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  letterSpacing: 5,
                  // wordSpacing: 5,
                  fontWeight: FontWeight.bold,
                ),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MovieLoaded) {
              // if (state.status == MovieStatus.ended) {
              //   Text(
              //     'Ended',
              //     style: Theme.of(context).textTheme.titleMedium,
              //   );
              // }
              if (state.status == MovieStatus.loading) const CircularProgressIndicator();
              return SingleChildScrollView(
                // physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox.fromSize(
                      size: const Size.fromHeight(150),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) => ImageCardWidget(
                                imgurl: state.movie![index].mediumCoverImage,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: state.movie!.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              // controller: _controller,
                            ),
                          ),
                          if (state.status == MovieStatus.loading)
                            const CircularProgressIndicator(),
                          if (state.status == MovieStatus.ended)
                            Text(
                              'Ended',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    AppPadding(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'All Movie',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'See All',
                              style: Theme.of(context).textTheme.button?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Flexible(
                      child: ListView.builder(
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: AppPadding(
                            child: GestureDetector(
                              onTap: () => {
                                GoRouter.of(context).pushNamed(
                                  HomeDetailPage.routeName,
                                  queryParams: {
                                    'movie_id': state.movie![index].id.toString(),
                                  },
                                ),
                              },
                              child: BookItemCard(
                                description: state.movie![index].synopsis,
                                imgurl: state.movie![index].largeCoverImage,
                                producer: state.movie![index].rating.toString(),
                                title: state.movie![index].titleEnglish,
                              ),
                            ),
                          ),
                        ),
                        itemCount: state.movie!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ),
                    // Column(
                    //   children: List.generate(
                    //     10,
                    //     (index) => Container(
                    //       margin: const EdgeInsets.symmetric(vertical: 10),
                    //       child: AppPadding(
                    //         child: GestureDetector(
                    //           onTap: () => GoRouter.of(context).pushNamed(
                    //             HomeDetailPage.routeName,
                    //           ),
                    //           child: const BookItemCard(),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            }
            if (state is MovieFailed) {
              return Center(
                child: Text(state.message),
              );
            }
            return const Center(
              child: Text('Something went worng'),
            );
          },
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

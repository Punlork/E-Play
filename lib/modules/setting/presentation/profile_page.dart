import 'dart:developer';
import 'dart:math' as math;
import 'package:e_book_app/index.dart';
import 'package:e_book_app/modules/setting/infrastructure/profile_repository.dart';
import 'package:loading_more_list/loading_more_list.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const String routeName = 'profile_page';
  static const String routePath = '/profile_page';

  static final route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => const ProfilePage(),
  );

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TuChangRepository listSourceRepository;
  late final TuChangRepository listSourceRepository1;

  @override
  void initState() {
    listSourceRepository = TuChangRepository(AppData.getUpcomingMovies);
    listSourceRepository1 = TuChangRepository(AppData.getTopRatedMovies);

    super.initState();
  }

  @override
  void dispose() {
    listSourceRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              leading: CustomIconWidget(
                icon: Icons.arrow_back,
                onPressed: () => GoRouter.of(context).pop(),
              ),
              expandedHeight: MediaQuery.of(context).size.width * .7,
              title: Text(
                'Profile Page',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 60,
                      foregroundImage: Image.network(
                        'https://i.ytimg.com/vi/OniwxuEJ9LI/maxresdefault.jpg',
                      ).image,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: <Widget>[
                              Text(
                                'Name',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 10),
                              const Text('Slime'),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Age',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 10),
                              const Text('19'),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Status',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 10),
                              const Text('World Class'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverPersistentHeader(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const TabBar(
                    tabs: [
                      Text('Tab 1'),
                      Text('Tab 2'),
                    ],
                  ),
                ),
                maxHeight: kToolbarHeight,
                minHeight: kToolbarHeight,
              ),
            ),
          ],
          body: TabBarView(
            children: [
              LoadingMoreList<ShowAllModel>(
                ListConfig<ShowAllModel>(
                  itemBuilder: (context, item, index) {
                    final element = item.results;
                    return Column(
                      children: <Widget>[
                        ...List.generate(
                          element.length,
                          (index) => AppPadding(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              height: 150,
                              child: GestureDetector(
                                onTap: () {},
                                child: BookItemCard(
                                  description: element[index].overview,
                                  isRRated: element[index].adult ?? false,
                                  imgUrl: element[index].posterPath,
                                  producer: element[index].voteAverage.toString(),
                                  title: element[index].title,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  sourceList: listSourceRepository,
                ),
              ),
              LoadingMoreList<ShowAllModel>(
                ListConfig<ShowAllModel>(
                  itemBuilder: (context, item, index) {
                    final element = item.results;
                    return Column(
                      children: <Widget>[
                        ...List.generate(
                          element.length,
                          (index) => AppPadding(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              height: 150,
                              child: GestureDetector(
                                onTap: () {},
                                child: BookItemCard(
                                  description: element[index].overview,
                                  isRRated: element[index].adult ?? false,
                                  imgUrl: element[index].posterPath,
                                  producer: element[index].voteAverage.toString(),
                                  title: element[index].title,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  sourceList: listSourceRepository1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverPersistentHeader extends SliverPersistentHeaderDelegate {
  _SliverPersistentHeader({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  final Widget child;
  final double maxHeight;
  final double minHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant _SliverPersistentHeader oldDelegate) {
    return child != oldDelegate.child ||
        maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minExtent;
  }
}

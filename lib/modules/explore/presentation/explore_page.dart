import 'package:e_book_app/modules/component/app_padding.dart';
import 'package:e_book_app/modules/component/icon_widget.dart';
import 'package:e_book_app/modules/component/image_card.dart';
import 'package:e_book_app/modules/explore/presentation/explore_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  static const String routeName = 'explore_page';
  static const String routePath = '/explore_page';

  static final route = GoRoute(
    path: routePath,
    name: routeName,
    builder: (context, state) => const ExplorePage(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        // iconTheme: IconThemeData(
        //   color: Colors.black,
        // ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,

        title: Text(
          'Explore',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            10,
            (index) => _CustomExploreSection(
              onPressed: () => GoRouter.of(context).pushNamed(
                ExploreDetailPage.routeName,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomExploreSection extends StatelessWidget {
  const _CustomExploreSection({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppPadding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Short Stories',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: onPressed,
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: AppPadding(
            child: Row(
              children: List.generate(
                20,
                (index) => const ImageCardWidget(imgurl: '',),
              ),
            ),
          ),
        )
      ],
    );
  }
}

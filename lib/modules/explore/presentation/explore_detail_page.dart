import 'package:e_book_app/modules/component/app_padding.dart';
import 'package:e_book_app/modules/component/book_card.dart';
import 'package:e_book_app/modules/component/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExploreDetailPage extends StatelessWidget {
  const ExploreDetailPage({super.key});

  static const String routeName = 'explore_detail_page';
  static const String routePath = '/explore_detail_page';

  static final route = GoRoute(
    path: routePath,
    name: routeName,
    builder: (context, state) => const ExploreDetailPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: CustomIconWidget(
          icon: Icons.arrow_back,
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(
          'Short Stories',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            20,
            (index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const AppPadding(
                child: SizedBox(), // BookItemCard(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

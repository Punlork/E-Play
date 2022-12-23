import 'package:e_book_app/index.dart';

class AppRouteTransition<T> extends CustomTransitionPage<T> {
  AppRouteTransition({
    required this.context,
    required this.state,
    required this.child,
  }) : super(
          child: child,
          key: state.pageKey,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

  @override
  final Widget child;
  final BuildContext context;
  final GoRouterState state;
}

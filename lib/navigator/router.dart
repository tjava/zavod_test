import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: HomeRoute.page,
      path: '/home',
      initial: true,
    ),
    AutoRoute(
      page: DetailsRoute.page,
      path: '/details',
    ),
    AutoRoute(
      page: ProfileRoute.page,
      path: '/Profile',
    ),
    AutoRoute(
      page: SupportRoute.page,
      path: '/support',
    ),
    AutoRoute(
      page: HistoryRoute.page,
      path: '/history',
    ),
  ];
}

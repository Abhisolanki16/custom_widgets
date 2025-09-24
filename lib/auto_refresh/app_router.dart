import 'package:auto_route/auto_route.dart'; // for AutoRoute class
import 'package:auto_route/annotations.dart'; // ✅ required for @MaterialAutoRouter
import 'first_screen.dart';
import 'second_screen.dart';

part 'app_router.gr.dart'; // generated file

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: FirstRoute.page, initial: true),
    AutoRoute(page: SecondRoute.page),
  ];
}

final appRouter = AppRouter();

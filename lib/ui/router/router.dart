import 'package:alexeys_returning/ui/pages/home_page.dart';
import 'package:alexeys_returning/ui/pages/main_page.dart';
import 'package:alexeys_returning/ui/pages/make_event_page.dart';
import 'package:alexeys_returning/ui/pages/pick_map_point_page.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => const HomePage()),
    GoRoute(path: "/main", builder: (context, state) => const MainPage()),
    GoRoute(
      path: "/make_event",
      builder: (context, state) => const MakeEventPage(),
    ),
    GoRoute(
      path: "/pick_map_point",
      builder: (context, state) => const PickMapPointPage(),
    ),
  ],
);

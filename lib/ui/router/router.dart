import 'package:alexeys_returning/ui/pages/home_page.dart';
import 'package:alexeys_returning/ui/pages/page1.dart';
import 'package:alexeys_returning/ui/pages/page2.dart';
import 'package:alexeys_returning/ui/router/extra_data_model.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => const HomePage()),
    GoRoute(
      path: "/page1",
      builder: (context, state) => const Page1(),
      routes: [
        GoRoute(
          path: "/page2",
          builder: (context, state) {
            final extraData = state.extra as ExtraDataModel;
            return Page2(title: extraData.title!);
          },
        ),
      ],
    ),
  ],
);

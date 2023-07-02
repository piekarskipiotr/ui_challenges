import 'package:go_router/go_router.dart';
import 'package:ui_challenges/home/home.dart';

class AppRouter {
  static final instance = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}

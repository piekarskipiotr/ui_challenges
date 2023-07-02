import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_challenges/home/cubit/home_cubit.dart';
import 'package:ui_challenges/home/cubit/home_state.dart';
import 'package:ui_challenges/home/home.dart';

class AppRouter {
  static final instance = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider(
          create: (_) => HomeCubit(HomeInitial())..loadChallenges(),
          child: const HomePage(),
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_challenges/home/cubit/home_cubit.dart';
import 'package:ui_challenges/home/cubit/home_state.dart';
import 'package:ui_challenges/home/view/challenge_card_view.dart';
import 'package:ui_challenges/l10n/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.homeAppBarTitle)),
      body: BlocBuilder(
        bloc: context.read<HomeCubit>(),
        builder: (context, state) {
          if (state is LoadingChallenges) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is LoadingChallengesSucceeded) {
            final challenges = state.challenges;

            return ListView.builder(
              itemCount: challenges.length,
              itemBuilder: (context, index) => ChallengeCardView(
                challenge: challenges[index],
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(l10n.something_went_wrong),
                ElevatedButton(
                  onPressed: context.read<HomeCubit>().loadChallenges,
                  child: Text(l10n.load_challenges),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

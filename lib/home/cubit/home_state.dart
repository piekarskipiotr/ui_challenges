import 'package:ui_challenges/models/challenge.dart';

abstract class HomeState {
  @override
  String toString() => runtimeType.toString();
}

class HomeInitial extends HomeState {}

class LoadingChallenges extends HomeState {}

class LoadingChallengesFailed extends HomeState {}

class LoadingChallengesSucceeded extends HomeState {
  LoadingChallengesSucceeded(this.challenges);

  final List<Challenge> challenges;
}

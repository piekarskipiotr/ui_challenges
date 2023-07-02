import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ui_challenges/home/cubit/home_state.dart';
import 'package:ui_challenges/models/challenge.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(super.initialState);

  Future<dynamic> loadChallenges() async {
    try {
      emit(LoadingChallenges());
      final json = await rootBundle.loadString('assets/data/challenges.json');
      final decodedData = jsonDecode(json) as List<dynamic>;
      final challenges = decodedData
          .map((e) => Challenge.fromJson(e as Map<String, dynamic>))
          .toList();

      emit(LoadingChallengesSucceeded(challenges));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(LoadingChallengesFailed());
    }
  }
}

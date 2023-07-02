import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge.freezed.dart';

part 'challenge.g.dart';

@freezed
class Challenge with _$Challenge {
  const factory Challenge({
    required String title,
    required String description,
    @JsonKey(name: 'image_url') required String imageUrl,
    required String route,
  }) = _Challenge;

  factory Challenge.fromJson(Map<String, Object?> json) =>
      _$ChallengeFromJson(json);
}

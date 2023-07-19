import 'package:freezed_annotation/freezed_annotation.dart';

part 'tiktok.freezed.dart';

part 'tiktok.g.dart';

@freezed
class TikTok with _$TikTok {
  const factory TikTok({
    @JsonKey(name: 'author_name') required String authorName,
    @JsonKey(name: 'author_avatar') required String authorAvatar,
    required String url,
    @JsonKey(name: 'music_name') required String musicName,
    @JsonKey(name: 'music_image') required String musicImage,
    required String description,
    required List<String> tags,
    required int likes,
    required int comments,
    required int saves,
    required int shares,
  }) = _TikTok;
  const TikTok._();

  factory TikTok.fromJson(Map<String, Object?> json) => _$TikTokFromJson(json);

  String getPrettyTags() => tags.map((tag) => '#$tag').join(' ');
}

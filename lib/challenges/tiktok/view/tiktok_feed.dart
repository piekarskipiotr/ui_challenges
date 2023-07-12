import 'package:flutter/material.dart';
import 'package:ui_challenges/challenges/tiktok/view/tiktok_video.dart';

class TikTokFeed extends StatefulWidget {
  const TikTokFeed({super.key});

  @override
  State<TikTokFeed> createState() => _TikTokFeedState();
}

class _TikTokFeedState extends State<TikTokFeed> {
  int _currentPage = 0;
  final videos = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      onPageChanged: (index) => setState(() => _currentPage = index),
      itemBuilder: (context, index) => TikTokVideo(
        url: videos[index],
        isPlaying: index == _currentPage,
      ),
      itemCount: videos.length,
    );
  }
}

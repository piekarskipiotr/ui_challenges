import 'package:flutter/material.dart';
import 'package:ui_challenges/challenges/tiktok/models/tiktok.dart';
import 'package:ui_challenges/challenges/tiktok/view/tiktok_video.dart';

class TikTokFeed extends StatefulWidget {
  const TikTokFeed({super.key});

  @override
  State<TikTokFeed> createState() => _TikTokFeedState();
}

class _TikTokFeedState extends State<TikTokFeed> {
  int _currentPage = 0;
  final _tiktoks = [
    const TikTok(
      authorName: 'xazai',
      authorAvatar: 'https://github.com/piekarskipiotr.png',
      url:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      musicName: 'schafter - hot coffee',
      musicImage: 'https://ecsmedia.pl/c/audiotele-b-iext109772459.jpg',
      description: 'This is cool video with schafter music playing, chill 👽',
      tags: ['cool', 'video', 'ui', 'challenge', 'music'],
      likes: 419,
      comments: 55,
      saves: 0,
      shares: 12,
    ),
    const TikTok(
      authorName: 'notXazai',
      authorAvatar: 'https://github.com/piekarskipiotr.png',
      url:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      musicName: 'kanye west - off the grid',
      musicImage:
          'https://media.pitchfork.com/photos/612d1c804632028e7819078b/1:1/w_675,h_675,c_limit/Kanye-West.jpeg',
      description: 'Another amazing video from notXazai 🤣',
      tags: ['north', 'west', 'ui', 'challenge', 'bugs'],
      likes: 2000,
      comments: 47,
      saves: 21,
      shares: 15,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      onPageChanged: (index) => setState(() => _currentPage = index),
      itemBuilder: (context, index) => TikTokVideo(
        tiktok: _tiktoks[index],
        isPlaying: index == _currentPage,
      ),
      itemCount: _tiktoks.length,
    );
  }
}

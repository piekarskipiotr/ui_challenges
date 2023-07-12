import 'package:flutter/material.dart';
import 'package:ui_challenges/challenges/tiktok/view/tiktok_app_bar.dart';
import 'package:ui_challenges/challenges/tiktok/view/tiktok_feed.dart';

class TikTokPage extends StatefulWidget {
  const TikTokPage({super.key});

  @override
  State<TikTokPage> createState() => _TikTokPageState();
}

class _TikTokPageState extends State<TikTokPage> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: TikTokAppBar(),
        body: TabBarView(
          children: [
            TikTokFeed(),
            Center(child: Text('For you page')),
          ],
        ),
      ),
    );
  }
}

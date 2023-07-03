import 'package:flutter/material.dart';

class TikTokPage extends StatefulWidget {
  const TikTokPage({super.key});

  @override
  State<TikTokPage> createState() => _TikTokPageState();
}

class _TikTokPageState extends State<TikTokPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TikTok'),
      ),
    );
  }
}

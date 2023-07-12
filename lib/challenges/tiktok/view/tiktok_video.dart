import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TikTokVideo extends StatefulWidget {
  const TikTokVideo({
    required this.url,
    required this.isPlaying,
    super.key,
  });

  final String url;
  final bool isPlaying;

  @override
  State<TikTokVideo> createState() => _TikTokVideoState();
}

class _TikTokVideoState extends State<TikTokVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {
          _controller.setLooping(true);
          widget.isPlaying ? _controller.play() : _controller.pause();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TikTokVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.isPlaying ? _controller.play() : _controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    return (_controller.value.isInitialized)
        ? GestureDetector(
            onTap: () => _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play(),
            child: Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator.adaptive());
  }
}

import 'package:flutter/material.dart';
import 'package:ui_challenges/challenges/tiktok/models/tiktok.dart';
import 'package:ui_challenges/l10n/l10n.dart';
import 'package:video_player/video_player.dart';

class TikTokVideo extends StatefulWidget {
  const TikTokVideo({
    required this.tiktok,
    required this.isPlaying,
    super.key,
  });

  final TikTok tiktok;
  final bool isPlaying;

  @override
  State<TikTokVideo> createState() => _TikTokVideoState();
}

class _TikTokVideoState extends State<TikTokVideo> {
  late TikTok _tiktok;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _tiktok = widget.tiktok;
    _controller = VideoPlayerController.networkUrl(Uri.parse(_tiktok.url))
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
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: () {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
              setState(() {});
            },
            child: Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                    opacity: _controller.value.isPlaying ? 0 : .6,
                    duration: const Duration(milliseconds: 50),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 84,
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _TextInfo(tiktok: _tiktok),
                            _ColumnInfo(tiktok: _tiktok),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator.adaptive());
  }
}

class _TextInfo extends StatefulWidget {
  const _TextInfo({required this.tiktok});

  final TikTok tiktok;

  @override
  State<_TextInfo> createState() => _TextInfoState();
}

class _TextInfoState extends State<_TextInfo> {
  late TikTok _tiktok;
  bool _showMore = false;

  @override
  void initState() {
    super.initState();
    _tiktok = widget.tiktok;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _tiktok.authorName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _description(),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.music_note, color: Colors.white, size: 14),
              Text(
                _tiktok.musicName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _description() {
    final l10n = context.l10n;
    return LayoutBuilder(
      builder: (context, constraints) {
        String? formattedDesc;
        final desc = '${_tiktok.description} ${_tiktok.getPrettyTags()}';
        final textPainter = TextPainter(
          text: TextSpan(
            text: desc,
            style: const TextStyle(
              height: 1.3,
            ),
          ),
          maxLines: _showMore ? null : 2,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);
        final isPrimaryTextTruncated = textPainter.didExceedMaxLines;

        if (isPrimaryTextTruncated) {
          final lastIndex = desc.length - 14;
          formattedDesc = '${desc.substring(0, lastIndex)}...';
        }

        if (_showMore) {
          formattedDesc = '$desc\n';
        }

        final descTextSpan = TextSpan(
          text: formattedDesc ?? desc,
          style: const TextStyle(
            height: 1.3,
          ),
        );

        return Stack(
          children: [
            AnimatedCrossFade(
              firstChild: RichText(
                text: descTextSpan,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              secondChild: RichText(
                text: descTextSpan,
              ),
              duration: const Duration(milliseconds: 150),
              crossFadeState: _showMore
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            ),
            if (isPrimaryTextTruncated || _showMore)
              Positioned(
                bottom: -1,
                right: 0,
                child: GestureDetector(
                  onTap: () => setState(() => _showMore = !_showMore),
                  child: Text(
                    _showMore ? l10n.less : l10n.more,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ColumnInfo extends StatelessWidget {
  const _ColumnInfo({required this.tiktok});

  final TikTok tiktok;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _AuthorIcon(tiktok: tiktok),
          const SizedBox(height: 24),
          _LikeIcon(tiktok: tiktok),
          const SizedBox(height: 16),
          _CommentsIcon(tiktok: tiktok),
          const SizedBox(height: 16),
          _SavesIcon(tiktok: tiktok),
          const SizedBox(height: 16),
          _SharesIcon(tiktok: tiktok),
          const SizedBox(height: 16),
          _MusicIcon(tiktok: tiktok),
        ],
      ),
    );
  }
}

class _AuthorIcon extends StatefulWidget {
  const _AuthorIcon({required this.tiktok});

  final TikTok tiktok;

  @override
  State<_AuthorIcon> createState() => _AuthorIconState();
}

class _AuthorIconState extends State<_AuthorIcon> {
  late TikTok tiktok;

  @override
  void initState() {
    super.initState();
    tiktok = widget.tiktok;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(1),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  tiktok.authorAvatar,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, 8),
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink,
            ),
            child: const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _LikeIcon extends StatefulWidget {
  const _LikeIcon({required this.tiktok});

  final TikTok tiktok;

  @override
  State<_LikeIcon> createState() => _LikeIconState();
}

class _LikeIconState extends State<_LikeIcon> {
  late TikTok tiktok;

  @override
  void initState() {
    super.initState();
    tiktok = widget.tiktok;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          const Icon(
            Icons.favorite,
            color: Colors.white,
            size: 32,
          ),
          Text(
            '${tiktok.likes}',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentsIcon extends StatefulWidget {
  const _CommentsIcon({required this.tiktok});

  final TikTok tiktok;

  @override
  State<_CommentsIcon> createState() => _CommentsIconState();
}

class _CommentsIconState extends State<_CommentsIcon> {
  late TikTok tiktok;

  @override
  void initState() {
    super.initState();
    tiktok = widget.tiktok;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          const Icon(
            Icons.comment,
            color: Colors.white,
            size: 32,
          ),
          Text(
            '${tiktok.comments}',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _SavesIcon extends StatefulWidget {
  const _SavesIcon({required this.tiktok});

  final TikTok tiktok;

  @override
  State<_SavesIcon> createState() => _SavesIconState();
}

class _SavesIconState extends State<_SavesIcon> {
  late TikTok tiktok;

  @override
  void initState() {
    super.initState();
    tiktok = widget.tiktok;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          const Icon(
            Icons.bookmark,
            color: Colors.white,
            size: 32,
          ),
          Text(
            '${tiktok.saves}',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _SharesIcon extends StatefulWidget {
  const _SharesIcon({required this.tiktok});

  final TikTok tiktok;

  @override
  State<_SharesIcon> createState() => _SharesIconState();
}

class _SharesIconState extends State<_SharesIcon> {
  late TikTok tiktok;

  @override
  void initState() {
    super.initState();
    tiktok = widget.tiktok;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          const Icon(
            Icons.send,
            color: Colors.white,
            size: 32,
          ),
          Text(
            '${tiktok.shares}',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _MusicIcon extends StatelessWidget {
  const _MusicIcon({required this.tiktok});

  final TikTok tiktok;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            'https://w7.pngwing.com/pngs/405/284/png-transparent-phonograph-record-lp-record-record-press-graphy-music-vinyl-miscellaneous-photography-sound-recording-and-reproduction.png',
          ),
        ),
      ),
      padding: const EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(
              tiktok.musicImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

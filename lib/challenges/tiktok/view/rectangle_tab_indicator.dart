import 'package:flutter/material.dart';

class RectangleTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _RectangleTabIndicatorPainter(this, onChanged);
  }
}

class _RectangleTabIndicatorPainter extends BoxPainter {
  _RectangleTabIndicatorPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);
  final RectangleTabIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const indicatorHeight = 4.0;
    final indicatorWidth = rect.width / 2;
    final dx = rect.left + (rect.width - indicatorWidth) / 2;
    final dy = rect.bottom - indicatorHeight;

    final indicatorRect = Rect.fromLTWH(
      dx,
      dy,
      indicatorWidth,
      indicatorHeight,
    );

    canvas.drawRect(indicatorRect, paint);
  }
}

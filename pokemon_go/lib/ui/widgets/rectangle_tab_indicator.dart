import 'package:flutter/material.dart';

class CurvedRectangleIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;

  const CurvedRectangleIndicator(
      {required this.indicatorHeight,
        required this.indicatorColor,});

  @override
  CurvedRectanglePainter createBoxPainter([  VoidCallback? onChanged]) {
    return CurvedRectanglePainter(this, onChanged!);
  }
}

class CurvedRectanglePainter extends BoxPainter {
  final CurvedRectangleIndicator decoration;

  CurvedRectanglePainter(this.decoration, VoidCallback onChanged) :super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {

    Rect rect;
    rect = Offset(offset.dx ,
        (configuration.size!.height - decoration.indicatorHeight )) &
    Size(configuration.size!.width, decoration.indicatorHeight );

    final paint = Paint();
    paint.color = decoration.indicatorColor ;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndCorners(rect, topRight: const Radius.circular(8), topLeft: const Radius.circular(8)), paint);
  }
}

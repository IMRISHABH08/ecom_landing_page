import 'package:flutter/material.dart';
import '../../../../global/design_system/app_colors.dart';

class DotTexturePainter extends CustomPainter {
  const DotTexturePainter();

  static const double _spacing = 18.0;
  static const double _radius = 1.2;
  static const int _maxAlpha = 180;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final cols = (size.width / _spacing).ceil();
    final rows = (size.height / _spacing).ceil();

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final opacity = 1.0 - (r / rows);
        canvas.drawCircle(
          Offset(c * _spacing, r * _spacing),
          _radius,
          paint
            ..color = AppColors.dotTexture.withAlpha(
              (opacity * _maxAlpha).round(),
            ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

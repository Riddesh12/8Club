
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class WaveformPainter extends CustomPainter {
  final List<double> amplitudes;
  WaveformPainter(this.amplitudes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7C4DFF)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    // Layout constants
    const iconAreaSize = 40.0;
    const spacing = 12.0;

    final waveformStartX = iconAreaSize + spacing;
    final waveformEndX = size.width - iconAreaSize - spacing;
    final waveformWidth = waveformEndX - waveformStartX;

    final midY = size.height / 2;
    final barWidth = waveformWidth / amplitudes.length;
    final scale = size.height * 0.7;

    // Draw Mic Icon
    _drawMicIcon(canvas, size, iconAreaSize);

    // Draw Waveform Bars
    for (int i = 0; i < amplitudes.length; i++) {
      final amp = amplitudes[i].clamp(0.0, 1.0);
      final height = max(amp * scale, 3.0);
      final x = waveformStartX + (i * barWidth) + (barWidth / 2);

      final rect = Rect.fromLTWH(x - 2, midY - height / 2, 4, height);

      // Add soft shadow glow
      canvas.drawShadow(Path()..addRect(rect), Colors.purple.shade100, 3, false);

      canvas.drawLine(
        Offset(x, midY - height / 2),
        Offset(x, midY + height / 2),
        paint,
      );
    }

    // Draw Delete Icon
    _drawDeleteIcon(canvas, size, iconAreaSize);
  }

  void _drawMicIcon(Canvas canvas, Size size, double iconSize) {
    final centerX = iconSize / 2;
    final centerY = size.height / 2;

    final micPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final outline = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Mic capsule
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX, centerY - 4),
          width: 12,
          height: 18,
        ),
        const Radius.circular(6),
      ),
      micPaint,
    );

    // Mic stand
    canvas.drawLine(
      Offset(centerX, centerY + 5),
      Offset(centerX, centerY + 12),
      outline,
    );

    // Base curve
    canvas.drawArc(
      Rect.fromCenter(center: Offset(centerX, centerY + 12), width: 14, height: 8),
      0,
      pi,
      false,
      outline,
    );
  }

  void _drawDeleteIcon(Canvas canvas, Size size, double iconSize) {
    final centerX = size.width - (iconSize / 2);
    final centerY = size.height / 2;

    final bodyPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final outline = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Trash can body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(centerX, centerY + 2), width: 14, height: 12),
        const Radius.circular(2),
      ),
      bodyPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(centerX, centerY + 2), width: 14, height: 12),
        const Radius.circular(2),
      ),
      outline,
    );

    // Lid
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(centerX, centerY - 8), width: 18, height: 4),
        const Radius.circular(1),
      ),
      outline,
    );

    // Handle
    canvas.drawLine(
      Offset(centerX - 3, centerY - 10),
      Offset(centerX + 3, centerY - 10),
      outline,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
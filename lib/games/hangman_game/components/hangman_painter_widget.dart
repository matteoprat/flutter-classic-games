import 'package:flutter/material.dart';

class HangmanPainterWidget extends StatelessWidget {
  final int remainingAttempts;

  const HangmanPainterWidget({super.key, required this.remainingAttempts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 160,
      child: CustomPaint(
        painter: _HangmanPainter(errorCount: 6 - remainingAttempts),
      ),
    );
  }
}

class _HangmanPainter extends CustomPainter {
  final int errorCount;

  const _HangmanPainter({required this.errorCount});

  @override
  void paint(Canvas canvas, Size size) {
    final gallowsPaint = Paint()
      ..color = Colors.blueGrey[800]!
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final bodyPaint = Paint()
      ..color = Colors.indigo
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // GALLOWS

    // BOTTOM BASE
    canvas.drawLine(
      Offset(10, size.height - 10),
      Offset(size.width - 10, size.height - 10),
      gallowsPaint,
    );

    // VERTICAL POLE
    canvas.drawLine(Offset(30, size.height - 10), Offset(30, 10), gallowsPaint);

    // UPPER PART
    canvas.drawLine(Offset(30, 10), Offset(size.width - 40, 10), gallowsPaint);

    // ROPE
    canvas.drawLine(
      Offset(size.width - 40, 10),
      Offset(size.width - 40, 35),
      gallowsPaint..strokeWidth = 2.0,
    );

    gallowsPaint.strokeWidth = 4;

    // MAN PARTS
    // HEAD
    if (errorCount >= 1) {
      canvas.drawCircle(Offset(size.width - 40, 50), 15, bodyPaint);
    }

    // UPPER BODY
    if (errorCount >= 2) {
      canvas.drawLine(
        Offset(size.width - 40, 65),
        Offset(size.width - 40, 115),
        bodyPaint,
      );
    }

    // LEFT ARM
    if (errorCount >= 3) {
      canvas.drawLine(
        Offset(size.width - 40, 75),
        Offset(size.width - 65, 95),
        bodyPaint,
      );
    }

    // RIGHT ARM
    if (errorCount >= 4) {
      canvas.drawLine(
        Offset(size.width - 40, 75),
        Offset(size.width - 15, 95),
        bodyPaint,
      );
    }

    // LEFT LEG
    if (errorCount >= 5) {
      canvas.drawLine(
        Offset(size.width - 40, 115),
        Offset(size.width - 60, 150),
        bodyPaint,
      );
    }

    // RIGHT LEG
    if (errorCount >= 6) {
      canvas.drawLine(
        Offset(size.width - 40, 115),
        Offset(size.width - 20, 150),
        bodyPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HangmanPainter oldDelegate) {
    return oldDelegate.errorCount != errorCount;
  }
}

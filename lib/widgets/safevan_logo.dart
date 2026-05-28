import 'package:flutter/material.dart';

class SafeVanLogo extends StatelessWidget {
  final double size;
  const SafeVanLogo({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5BE00), width: 2.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: CustomPaint(
          size: Size(size, size),
          painter: _BusPainter(),
        ),
      ),
    );
  }
}

class _BusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // ── Road ──
    final roadPaint = Paint()..color = const Color(0xFFB0BEC5);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.76, w, h * 0.24), roadPaint);

    final roadLinePaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = h * 0.025;
    for (double x = w * 0.05; x < w; x += w * 0.28) {
      canvas.drawLine(
        Offset(x, h * 0.84),
        Offset(x + w * 0.15, h * 0.84),
        roadLinePaint,
      );
    }

    // ── Shadow ──
    final shadowPaint = Paint()
      ..color = const Color(0xFF90A4AE).withOpacity(0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.78), width: w * 0.7, height: h * 0.06),
      shadowPaint,
    );

    // ── Van body ──
    final bodyPaint = Paint()..color = const Color(0xFFFFD600);
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.1, h * 0.28, w * 0.8, h * 0.46),
      const Radius.circular(6),
    );
    canvas.drawRRect(bodyRect, bodyPaint);

    // ── Roof ──
    final roofPaint = Paint()..color = const Color(0xFFFFD600);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.16, h * 0.18, w * 0.68, h * 0.14),
        const Radius.circular(5),
      ),
      roofPaint,
    );
    final roofHighlight = Paint()..color = const Color(0xFFFFE033);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.18, h * 0.20, w * 0.64, h * 0.10),
        const Radius.circular(4),
      ),
      roofHighlight,
    );

    // ── White stripe ──
    canvas.drawRect(
      Rect.fromLTWH(w * 0.10, h * 0.50, w * 0.80, h * 0.06),
      Paint()..color = Colors.white.withOpacity(0.85),
    );

    // ── Windshield ──
    final glassPaint = Paint()..color = const Color(0xFFC8ECFF).withOpacity(0.9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.14, h * 0.22, w * 0.34, h * 0.20),
        const Radius.circular(4),
      ),
      glassPaint,
    );
    // divider line on windshield
    canvas.drawLine(
      Offset(w * 0.31, h * 0.22),
      Offset(w * 0.31, h * 0.42),
      Paint()
        ..color = const Color(0xFFA8D8F0)
        ..strokeWidth = 1,
    );
    // shine
    final shinePaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    final shinePath = Path()
      ..moveTo(w * 0.15, h * 0.23)
      ..lineTo(w * 0.26, h * 0.23)
      ..lineTo(w * 0.20, h * 0.36)
      ..lineTo(w * 0.15, h * 0.36)
      ..close();
    canvas.drawPath(shinePath, shinePaint);

    // ── Side windows ──
    final windowPaint = Paint()..color = const Color(0xFFC8ECFF).withOpacity(0.85);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.52, h * 0.22, w * 0.16, h * 0.15),
        const Radius.circular(3),
      ),
      windowPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.71, h * 0.22, w * 0.13, h * 0.15),
        const Radius.circular(3),
      ),
      windowPaint,
    );

    // ── Headlights ──
    final headlightPaint = Paint()..color = const Color(0xFFFFFDE0);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.11, h * 0.57, w * 0.13, h * 0.08),
        const Radius.circular(3),
      ),
      headlightPaint,
    );
    // Taillight
    final taillightPaint = Paint()..color = const Color(0xFFFF6B6B);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.76, h * 0.57, w * 0.12, h * 0.08),
        const Radius.circular(3),
      ),
      taillightPaint,
    );

    // ── Door ──
    final doorPaint = Paint()..color = const Color(0xFFE5BE00);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.54, h * 0.46, w * 0.22, h * 0.28),
        const Radius.circular(3),
      ),
      doorPaint,
    );
    final doorInnerPaint = Paint()..color = const Color(0xFFFFD600);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.555, h * 0.47, w * 0.19, h * 0.26),
        const Radius.circular(2),
      ),
      doorInnerPaint,
    );
    // door divider
    canvas.drawLine(
      Offset(w * 0.645, h * 0.47),
      Offset(w * 0.645, h * 0.73),
      Paint()
        ..color = const Color(0xFFE5BE00).withOpacity(0.5)
        ..strokeWidth = 1.2,
    );
    // door handle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.685, h * 0.595, w * 0.065, h * 0.025),
        const Radius.circular(2),
      ),
      Paint()..color = const Color(0xFFC8A000),
    );

    // ── Wheel arches ──
    final archPaint = Paint()..color = const Color(0xFFE5BE00);
    final archPath1 = Path();
    archPath1.moveTo(w * 0.10, h * 0.73);
    archPath1.quadraticBezierTo(w * 0.22, h * 0.64, w * 0.34, h * 0.73);
    canvas.drawPath(archPath1, archPaint);

    final archPath2 = Path();
    archPath2.moveTo(w * 0.56, h * 0.73);
    archPath2.quadraticBezierTo(w * 0.68, h * 0.64, w * 0.80, h * 0.73);
    canvas.drawPath(archPath2, archPaint);

    // ── Wheels ──
    void drawWheel(double cx, double cy) {
      canvas.drawCircle(Offset(cx, cy), w * 0.095, Paint()..color = const Color(0xFF2C2C2C));
      canvas.drawCircle(Offset(cx, cy), w * 0.065, Paint()..color = const Color(0xFF444444));
      canvas.drawCircle(Offset(cx, cy), w * 0.035, Paint()..color = const Color(0xFF888888));
      // spokes
      for (int i = 0; i < 4; i++) {
        final angle = i * 3.14159 / 2;
        canvas.drawLine(
          Offset(cx + w * 0.035 * _cos(angle), cy + w * 0.035 * _sin(angle)),
          Offset(cx + w * 0.065 * _cos(angle), cy + w * 0.065 * _sin(angle)),
          Paint()
            ..color = const Color(0xFF666666)
            ..strokeWidth = 1.5,
        );
      }
    }

    drawWheel(w * 0.22, h * 0.79);
    drawWheel(w * 0.68, h * 0.79);

    // ── SCHOOL VAN text ──
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'SCHOOL VAN',
        style: TextStyle(
          color: Color(0xFF3D2E00),
          fontSize: 7,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((w - textPainter.width) / 2, h * 0.625),
    );

    // ── Location pin ──
    final pinPaint = Paint()..color = const Color(0xFFFF3B30);
    final pinPath = Path();
    final pinCx = w * 0.80;
    final pinCy = h * 0.13;
    pinPath.addOval(Rect.fromCircle(center: Offset(pinCx, pinCy - h * 0.035), radius: w * 0.075));
    pinPath.moveTo(pinCx - w * 0.03, pinCy - h * 0.04);
    pinPath.lineTo(pinCx, pinCy + h * 0.035);
    pinPath.lineTo(pinCx + w * 0.03, pinCy - h * 0.04);
    canvas.drawPath(pinPath, pinPaint);
    canvas.drawCircle(
      Offset(pinCx, pinCy - h * 0.035),
      w * 0.03,
      Paint()..color = Colors.white,
    );
  }

  double _cos(double angle) => _mathCos(angle);
  double _sin(double angle) => _mathSin(angle);

  static double _mathCos(double r) {
    // simple lookup for 0, pi/2, pi, 3pi/2
    if (r == 0) return 1;
    if (r == 1.5708) return 0;
    if (r == 3.14159) return -1;
    if (r == 4.71239) return 0;
    return 1;
  }

  static double _mathSin(double r) {
    if (r == 0) return 0;
    if (r == 1.5708) return 1;
    if (r == 3.14159) return 0;
    if (r == 4.71239) return -1;
    return 0;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

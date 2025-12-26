import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pulse_flow/shared/app_color.dart';

class StarBackground extends StatefulWidget {
  const StarBackground({
    super.key,
    this.starCount = 90,
    this.speed = 0.25,
  });

  final int starCount;
  final double speed;

  @override
  State<StarBackground> createState() => _StarBackgroundState();
}

class _StarBackgroundState extends State<StarBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late List<_Star> _stars;
  Size _lastSize = Size.zero;
  final _rand = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16000),
    )..repeat();
    _stars = <_Star>[];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initStarsIfNeeded(Size size) {
    if (size == _lastSize && _stars.isNotEmpty) return;
    _lastSize = size;

    _stars = List.generate(widget.starCount, (_) {
      return _Star(
        x: _rand.nextDouble() * size.width,
        y: _rand.nextDouble() * size.height,
        r: 0.6 + _rand.nextDouble() * 1.8,
        v: 0.15 + _rand.nextDouble() * 0.85,
        a: 0.15 + _rand.nextDouble() * 0.55,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _initStarsIfNeeded(size);

        return AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            final t = _controller.value;
            return CustomPaint(
              painter: _StarPainter(
                stars: _stars,
                t: t,
                speed: widget.speed,
              ),
              size: size,
            );
          },
        );
      },
    );
  }
}

class _Star {
  _Star({
    required this.x,
    required this.y,
    required this.r,
    required this.v,
    required this.a,
  });

  double x;
  double y;
  final double r;
  final double v;
  final double a;
}

class _StarPainter extends CustomPainter {
  _StarPainter({
    required this.stars,
    required this.t,
    required this.speed,
  });

  final List<_Star> stars;
  final double t;
  final double speed;

  @override
  void paint(Canvas canvas, Size size) {
    // Background fill
    final bgPaint = Paint()..color = AppColor.backgroundDark;
    canvas.drawRect(Offset.zero & size, bgPaint);

    final starPaint = Paint()..style = PaintingStyle.fill;

    // Move downward slowly, wrap around
    for (final s in stars) {
      final dy = (t * size.height * s.v * speed);
      final y = (s.y + dy) % size.height;

      starPaint.color = AppColor.textPrimary;
      canvas.drawCircle(Offset(s.x, y), s.r, starPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarPainter oldDelegate) {
    return oldDelegate.t != t ||
        oldDelegate.speed != speed ||
        oldDelegate.stars.length != stars.length;
  }
}

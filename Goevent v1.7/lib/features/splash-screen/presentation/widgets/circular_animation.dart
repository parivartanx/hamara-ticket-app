import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularAnimation extends StatelessWidget {
  final Animation<double> animation;
  final ColorScheme colorScheme;

  const CircularAnimation({
    Key? key,
    required this.animation,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Large primary circle
        Positioned(
          top: -screenSize.height * 0.15,
          right: -screenSize.width * 0.3,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: animation.value * 0.5,
                child: child,
              );
            },
            child: Container(
              width: screenSize.width * 0.8,
              height: screenSize.width * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.primary.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),

        // Medium secondary circle
        Positioned(
          bottom: -screenSize.height * 0.1,
          left: -screenSize.width * 0.2,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: -animation.value * 0.3,
                child: child,
              );
            },
            child: Container(
              width: screenSize.width * 0.6,
              height: screenSize.width * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary.withOpacity(0.6),
                    colorScheme.primary.withOpacity(0.3),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
        ),

        // Small decorative circles
        Positioned(
          top: screenSize.height * 0.1,
          left: screenSize.width * 0.1,
          child: _buildDecorativeCircle(
            size: screenSize.width * 0.12,
            color: colorScheme.primary.withOpacity(0.3),
            rotationFactor: 1.2,
          ),
        ),

        Positioned(
          bottom: screenSize.height * 0.15,
          right: screenSize.width * 0.15,
          child: _buildDecorativeCircle(
            size: screenSize.width * 0.08,
            color: colorScheme.primary.withOpacity(0.4),
            rotationFactor: 0.8,
          ),
        ),

        // Dotted circles
        Positioned(
          top: screenSize.height * 0.3,
          right: screenSize.width * 0.05,
          child: _buildDottedCircle(
            size: screenSize.width * 0.25,
            color: colorScheme.primary.withOpacity(0.3),
            rotationFactor: -0.7,
          ),
        ),

        Positioned(
          bottom: screenSize.height * 0.4,
          left: screenSize.width * 0.05,
          child: _buildDottedCircle(
            size: screenSize.width * 0.2,
            color: colorScheme.primary.withOpacity(0.2),
            rotationFactor: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDecorativeCircle({
    required double size,
    required Color color,
    required double rotationFactor,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: animation.value * rotationFactor,
          child: child,
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }

  Widget _buildDottedCircle({
    required double size,
    required Color color,
    required double rotationFactor,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: animation.value * rotationFactor,
          child: CustomPaint(
            size: Size(size, size),
            painter: DottedCirclePainter(color: color),
          ),
        );
      },
    );
  }
}

class DottedCirclePainter extends CustomPainter {
  final Color color;

  DottedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const dotCount = 18;
    const dotSize = 3.0;

    for (int i = 0; i < dotCount; i++) {
      final angle = 2 * math.pi * i / dotCount;
      final dotCenter = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );

      canvas.drawCircle(dotCenter, dotSize, paint);
    }
  }

  @override
  bool shouldRepaint(DottedCirclePainter oldDelegate) =>
      oldDelegate.color != color;
}

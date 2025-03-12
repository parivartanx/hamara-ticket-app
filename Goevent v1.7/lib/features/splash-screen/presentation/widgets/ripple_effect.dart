import 'package:flutter/material.dart';

class RippleEffect extends StatelessWidget {
  final double maxRadius;
  final Animation<double> animation;

  const RippleEffect({
    Key? key,
    required this.maxRadius,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -maxRadius/2,
      top: -maxRadius/2,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Container(
          width: maxRadius * animation.value,
          height: maxRadius * animation.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
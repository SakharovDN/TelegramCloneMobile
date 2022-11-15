import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    Key? key,
    required this.child,
    this.shakeOffset = 3,
    this.shakeCount = 1,
    this.shakeDuration = const Duration(milliseconds: 200),
  }) : super(key: key);
  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final Duration shakeDuration;

  @override
  ShakeWidgetState createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget> with SingleTickerProviderStateMixin {
  ShakeWidgetState() : super();
  late AnimationController animationController;
  late Animation<double> _sineAnimation;

  void shake() {
    animationController.forward();
    HapticFeedback.lightImpact();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: widget.shakeDuration);
    animationController.addStatusListener(_updateStatus);
    _sineAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: SineCurve(count: widget.shakeCount.toDouble()),
    ));
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sineAnimation,
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_sineAnimation.value * widget.shakeOffset, 0),
          child: child,
        );
      },
    );
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }
}

class SineCurve extends Curve {
  const SineCurve({this.count = 3});
  final double count;

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t);
  }
}

import 'package:flutter/material.dart';
import 'dart:ui';

class PSGlassWidget extends StatelessWidget {
  final Widget child;
  final double opacity;

  const PSGlassWidget({
    super.key,
    required this.child,
    this.opacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.white.withOpacity(opacity),
          child: child,
        ),
      ),
    );
  }
}

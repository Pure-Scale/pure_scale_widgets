import 'package:flutter/material.dart';

class PSBackgroundWidget extends StatelessWidget {
  final Widget child;
  final Color color;

  const PSBackgroundWidget({
    Key? key,
    required this.child,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: child,
    );
  }
}

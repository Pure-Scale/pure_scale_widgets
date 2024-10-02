import 'package:flutter/material.dart';

class PSGridShowWidget extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;

  const PSGridShowWidget({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      children: children,
    );
  }
}

import 'package:flutter/material.dart';

class PSGridShowWidget extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;

  const PSGridShowWidget({
    Key? key,
    required this.children,
    this.crossAxisCount = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      children: children,
    );
  }
}

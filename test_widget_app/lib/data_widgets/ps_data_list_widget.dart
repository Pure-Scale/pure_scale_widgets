import 'package:flutter/material.dart';

class PSListShowWidget extends StatelessWidget {
  final List<Widget> children;

  const PSListShowWidget({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: children,
    );
  }
}

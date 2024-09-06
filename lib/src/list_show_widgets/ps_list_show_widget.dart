import 'package:flutter/material.dart';

class PSListShowWidget extends StatelessWidget {
  final List<Widget> children;

  const PSListShowWidget({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: children,
    );
  }
}

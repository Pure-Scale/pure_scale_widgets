import 'package:flutter/material.dart';

class PSLoaderWidget extends StatelessWidget {
  final Color color;

  const PSLoaderWidget({
    super.key,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}

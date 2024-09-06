import 'package:flutter/material.dart';

class PSLoaderWidget extends StatelessWidget {
  final Color color;

  const PSLoaderWidget({
    Key? key,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}

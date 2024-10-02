part of '../../pure_scale_widgets.dart';

class PSBackgroundWidget extends StatelessWidget {
  final Widget child;
  final Color color;

  const PSBackgroundWidget({
    super.key,
    required this.child,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: child,
    );
  }
}

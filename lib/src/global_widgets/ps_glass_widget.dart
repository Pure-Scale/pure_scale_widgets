part of '../../pure_scale_widgets.dart';

class PSGlassWidget extends StatelessWidget {
  final Widget child;
  final double opacity;
  final bool show;
  final BorderRadiusGeometry borderRadius;

  const PSGlassWidget({
    Key? key,
    required this.child,
    this.opacity = 0.1,
    this.show = true,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return child;
    }
    return ClipRRect(
      borderRadius: borderRadius,
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

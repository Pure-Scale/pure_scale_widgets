part of '../../pure_scale_widgets.dart';

class PSShimmerLoaderWidget extends StatelessWidget {
  final Widget child;

  const PSShimmerLoaderWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }
}

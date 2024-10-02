part of '../../pure_scale_widgets.dart';

class PSLoaderWidget extends StatelessWidget {
  final Color color;
  final bool minimumSize;

  const PSLoaderWidget({
    Key? key,
    this.color = Colors.white,
    this.minimumSize = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: minimumSize ? 16 : 24,
      height: minimumSize ? 16 : 24,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: minimumSize ? 1 : 2,
      ),
    );
  }
}

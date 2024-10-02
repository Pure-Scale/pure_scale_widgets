part of '../../pure_scale_widgets.dart';

enum PsItemShimmerType { job, address, user, vendor, none }

class PsItemShimmer extends StatelessWidget {
  final PsItemShimmerType type;
  final Color baseColor;
  final Color highlightColor;

  const PsItemShimmer({
    super.key,
    this.type = PsItemShimmerType.none,
    this.baseColor = const Color.fromRGBO(224, 224, 224, 1),
    this.highlightColor = const Color.fromARGB(255, 245, 245, 245),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: getShimmerWidget(type, context),
        ),
      ),
    );
  }

  getShimmerWidget(PsItemShimmerType type, BuildContext context) {
    switch (type) {
      case PsItemShimmerType.job:
        return getJobShimmer(context);
      case PsItemShimmerType.address:
        return const SizedBox(
          height: 120,
          width: double.infinity,
        );
      case PsItemShimmerType.user:
        return const SizedBox(
          height: 120,
          width: double.infinity,
        );
      case PsItemShimmerType.vendor:
        return const SizedBox(
          height: 120,
          width: double.infinity,
        );
      default:
        return const SizedBox(
          height: 120,
          width: double.infinity,
        );
    }
  }

  Widget getJobShimmer(BuildContext context) {
    final lableFontSize = Theme.of(context).textTheme.titleLarge?.fontSize;
    final bodyFontSize = Theme.of(context).textTheme.bodyMedium?.fontSize;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: baseColor,
          height: lableFontSize,
          width: width * 0.1,
        ),
        const SizedBox(height: 8),
        Container(
          color: baseColor,
          height: bodyFontSize,
          width: width * 0.3,
        ),
        const SizedBox(height: 8),
        Container(
          color: baseColor,
          height: bodyFontSize,
          width: width * 0.45,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$--/hr',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            TextButton(
              onPressed: () {},
              child: Container(
                color: baseColor,
                height: bodyFontSize,
                width: 80,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

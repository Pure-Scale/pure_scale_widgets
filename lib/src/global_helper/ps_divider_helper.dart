part of '../../pure_scale_widgets.dart';

class PSDividerHelper {
  static Divider primaryDividerNormal(BuildContext context) => Divider(
        color: Theme.of(context).buttonTheme.colorScheme!.primary,
        height: 1,
        thickness: 1,
      );

  static Divider primaryDividerSmall(BuildContext context) => Divider(
        color:
            Theme.of(context).buttonTheme.colorScheme!.primary.withOpacity(0.5),
        height: 0.5,
        thickness: 0.5,
      );

  static Divider disabledDividerSmall(BuildContext context) => Divider(
        color: Theme.of(context).dividerColor.withOpacity(0.1),
        height: 0.5,
        thickness: 0.5,
      );
}

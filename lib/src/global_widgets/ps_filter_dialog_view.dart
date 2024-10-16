part of '../../pure_scale_widgets.dart';

class PSFilterDialogView extends StatelessWidget {
  // Filter properties
  final double filterWidth;
  final String filterText;
  final List<Widget> children;
  final Widget? dividerWidget;
  final int filterCount;
  final EdgeInsets? padding;

  // Filter actions
  final VoidCallback onApply;
  final VoidCallback onReset;
  final VoidCallback onClose;

  const PSFilterDialogView({
    super.key,
    required this.filterWidth,
    required this.filterText,
    required this.onApply,
    required this.onReset,
    required this.children,
    required this.filterCount,
    required this.onClose,
    this.dividerWidget,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      alignment: Alignment.topCenter,
      padding: padding ??
          const EdgeInsets.only(
            top: 48,
            right: 4,
          ),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Theme.of(context).buttonTheme.colorScheme!.primary,
            width: 1,
          ),
        ),
        type: MaterialType.card,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    filterText,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 22,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onClose,
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).buttonTheme.colorScheme!.primary,
                    ),
                  )
                ],
              ).marginSymmetric(horizontal: 16),
              PSDividerHelper.primaryDividerSmall(context).marginOnly(
                bottom: 8,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => children[index],
                separatorBuilder: (context, index) =>
                    dividerWidget ??
                    PSDividerHelper.disabledDividerSmall(context)
                        .marginSymmetric(
                      vertical: 6,
                    ),
                itemCount: children.length,
              ).marginSymmetric(horizontal: 16),
              PSDividerHelper.primaryDividerSmall(context).marginSymmetric(
                vertical: 8,
              ),
              Row(
                children: [
                  PSSecondaryButton(
                    text: 'Reset',
                    onPressed: filterCount == 0 ? null : onReset,
                  ),
                  const Spacer(),
                  PSPrimaryButton(
                    onPressed: filterCount == 0 ? null : onApply,
                    text: 'Apply filters ($filterCount)',
                  ),
                ],
              ).marginSymmetric(horizontal: 16),
            ],
          ).marginSymmetric(vertical: 16),
        ),
      ),
    );
  }
}

part of '../../pure_scale_widgets.dart';

class PSCustomSearchAppbarWidget extends StatelessWidget {
  final List<ActionModel> actions;

  // Search properties
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;
  final VoidCallback onClear;

  // Filter properties
  final bool showFilter;
  final VoidCallback? onFilter;
  final int Function()? filterCount;

  const PSCustomSearchAppbarWidget({
    super.key,
    required this.actions,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    required this.onClear,
    this.showFilter = true,
    this.onFilter,
    this.filterCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Badge(
            label: controller.text.isNotEmpty
                ? Icon(
                    Icons.check_circle_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  )
                : const SizedBox(),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: onClear,
                      )
                    : null,
                isDense: true,
              ),
              onChanged: onChanged,
            ),
          ),
        ),
        if (showFilter)
          filterCount != null && filterCount!() > 0
              ? Badge.count(
                  count: filterCount!(),
                  child: IconButton.outlined(
                    icon: const Icon(Icons.filter_list),
                    onPressed: onFilter,
                  ),
                )
              : IconButton.outlined(
                  icon: const Icon(Icons.filter_list),
                  onPressed: onFilter,
                ),
        Wrap(
          spacing: 8,
          children: actions
              .map(
                (action) => buildAction(action, context),
              )
              .toList(),
        )
      ],
    ).marginSymmetric(
      vertical: 16,
    );
  }

  Widget buildAction(ActionModel action, BuildContext context) {
    return action.isMinimal
        ? IconButton.outlined(
            icon: Icon(action.icon),
            onPressed: action.onTap,
          )
        : ElevatedButton.icon(
            onPressed: action.onTap,
            icon: Icon(action.icon),
            label: Text(action.title),
          );
  }
}

class ActionModel {
  final String title;
  final IconData icon;
  final bool isMinimal;
  final Function() onTap;

  ActionModel({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isMinimal = false,
  });
}

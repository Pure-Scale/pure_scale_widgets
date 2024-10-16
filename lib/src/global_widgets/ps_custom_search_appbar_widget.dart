part of '../../pure_scale_widgets.dart';

class PSCustomSearchAppbarWidget extends StatelessWidget {
  final List<ActionModel> actions;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;
  final VoidCallback onClear;

  const PSCustomSearchAppbarWidget({
    super.key,
    required this.actions,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
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

part of '../../pure_scale_widgets.dart';

class PsDropdownSelection<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final Function(T) onTap;
  final String Function(T) displayStringForOption;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? dropdownColor;
  final Color? iconColor;
  final BorderRadius? borderRadius;
  final String hintText;

  const PsDropdownSelection({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onTap,
    required this.displayStringForOption,
    required this.hintText,
    this.width,
    this.height,
    this.textStyle,
    this.dropdownColor,
    this.iconColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField<T>(
            decoration: InputDecoration(
              hintText: 'Please select an ${hintText}',
              hintStyle: textStyle ?? Theme.of(context).textTheme.bodyMedium,
              labelText: hintText,
            ),
            items: items.map<DropdownMenuItem<T>>((T value) {
              return DropdownMenuItem<T>(
                key: Key("Item${items.indexOf(value)}"),
                value: value,
                child: Text(
                  displayStringForOption(value),
                  style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }).toList(),
            value: selectedItem,
            onChanged: (T? newValue) {
              if (newValue != null) {
                onTap(newValue);
              }
            },
            style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
            dropdownColor: dropdownColor ?? Theme.of(context).cardColor,
            icon: Icon(Icons.arrow_drop_down, color: iconColor),
            isExpanded: true,
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

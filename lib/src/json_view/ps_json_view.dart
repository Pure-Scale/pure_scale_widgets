part of '../../pure_scale_widgets.dart';

enum PSJsonViewLayoutMode { Horizontal, Vertical }

class PSJsonView extends StatelessWidget {
  final Map<String, dynamic> json;
  final PSJsonViewLayoutMode layout;
  final bool subObject;

  const PSJsonView({
    Key? key,
    required this.json,
    this.layout = PSJsonViewLayoutMode.Vertical,
    this.subObject = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: layout == PSJsonViewLayoutMode.Horizontal
          ? Axis.horizontal
          : Axis.vertical,
      child: layout == PSJsonViewLayoutMode.Horizontal
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: json.entries
                  .map((entry) => _buildElement(entry.key, entry.value))
                  .toList(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: json.entries
                  .map((entry) => _buildElement(entry.key, entry.value))
                  .toList(),
            ),
    );
  }

  Widget _buildElement(String key, dynamic value) {
    final formattedKey = formatKeyToTitleCase(key);
    final keyWidget = Text(
      formattedKey,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
    final valueWidget = _buildValue(key, value);

    if (layout == PSJsonViewLayoutMode.Vertical) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            keyWidget,
            SizedBox(height: 4),
            valueWidget,
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            keyWidget,
            SizedBox(height: 4),
            valueWidget,
          ],
        ),
      );
    }
  }

  Widget _buildValue(String key, dynamic value) {
    // Add key parameter
    if (value is DateTime) {
      return Text(DateFormat('yyyy-MM-dd').format(value));
    } else if (value is num &&
        ['amount', 'balance', 'total', 'tax', 'tip']
            .any((term) => key.contains(term))) {
      return Text('\$${value.toStringAsFixed(2)}');
    } else if (value is Map<String, dynamic>) {
      return PSJsonView(json: value, layout: layout, subObject: true);
    } else {
      return Text(value.toString());
    }
  }

  String formatKeyToTitleCase(String key) {
    return key
        .replaceAll(RegExp(r'[-_]'), ' ')
        .split(' ')
        .map((word) =>
            word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }
}

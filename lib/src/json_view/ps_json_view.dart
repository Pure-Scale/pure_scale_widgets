import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class PSJsonView extends StatelessWidget {
  final Map<String, dynamic> json;

  const PSJsonView({Key? key, required this.json}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: json.entries
            .map((entry) => _buildElement(entry.key, entry.value))
            .toList(),
      ),
    );
  }

  Widget _buildElement(String key, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(key, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          _buildValue(key, value), // Pass the key here
        ],
      ),
    );
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
      return PSJsonView(json: value);
    } else {
      return Text(value.toString());
    }
  }
}

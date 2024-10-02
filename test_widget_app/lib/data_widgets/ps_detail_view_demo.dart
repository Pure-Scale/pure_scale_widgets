import 'package:flutter/material.dart';

import 'ps_detail_view.dart';

class PSJsonViewDemo extends StatelessWidget {
  const PSJsonViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Vertical Layout:',
              style: Theme.of(context).textTheme.titleLarge),
        ),
        PSJsonView(
          json: sampleJson,
          layout: PSJsonViewLayoutMode.Vertical,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Horizontal Layout:',
              style: Theme.of(context).textTheme.titleLarge),
        ),
        SizedBox(
          height: 200,
          child: PSJsonView(
            json: sampleJson,
            layout: PSJsonViewLayoutMode.Horizontal,
          ),
        ),
      ],
    );
  }

  static const sampleJson = {
    'date': "Feb-03-2024",
    'total_amount': 100.50,
    'name': 'John Doe',
    'details': {
      'age': 30,
      'city': 'New York',
    },
  };
}

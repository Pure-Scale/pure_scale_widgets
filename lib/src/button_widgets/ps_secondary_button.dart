import 'package:flutter/material.dart';
import 'package:pure_scale_widgets/pure_scale_widgets.dart';

class PSSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading; // New parameter for loading state

  const PSSecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed, // Disable button when loading
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      child: isLoading
          ? const PSLoaderWidget() // Show loader when isLoading is true
          : Text(text),
    );
  }
}

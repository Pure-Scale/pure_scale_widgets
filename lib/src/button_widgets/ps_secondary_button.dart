part of '../../pure_scale_widgets.dart';

class PSSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
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
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 16.0,
        ),
      ),
      child: isLoading
          ? const Padding(
              padding: EdgeInsets.all(4.0),
              child: PSLoaderWidget(),
            ) // Show loader when isLoading is true
          : Text(text),
    );
  }
}

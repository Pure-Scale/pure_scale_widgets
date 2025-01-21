part of '../../pure_scale_widgets.dart';

class PSPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading; // New parameter for loading state
  final Color? backgroundColor;
  final Size? minimumSize;

  const PSPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false, // Default to false
    this.backgroundColor,
    this.minimumSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed, // Disable button when loading
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 0.0,
        ),
        minimumSize: minimumSize,
      ),
      child: isLoading
          ? const Center(child: PSLoaderWidget(minimumSize: true))
          : Center(
              child: Text(
                text,
              ),
            ),
    );
  }
}

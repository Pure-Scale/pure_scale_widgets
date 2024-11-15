part of '../../pure_scale_widgets.dart';

class PSPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading; // New parameter for loading state

  const PSPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed, // Disable button when loading
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16.0,
          )),
      child: isLoading
          ? const Center(child: PSLoaderWidget(minimumSize: true))
          : Text(text),
    );
  }
}

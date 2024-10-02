part of '../../pure_scale_widgets.dart';

class PsPrivacyTermsWidget extends StatelessWidget {
  final String byAgreeText;
  final String termsText;
  final String andText;
  final String privacyText;

  final String termOfServiceUrl;
  final String privacyPolicyUrl;

  const PsPrivacyTermsWidget({
    super.key,
    this.byAgreeText = 'By signing up, you agree to our ',
    this.termsText = 'Terms of Service',
    this.andText = ' and ',
    this.privacyText = 'Privacy Policy',
    required this.termOfServiceUrl,
    required this.privacyPolicyUrl,
  });
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
        children: [
          TextSpan(text: byAgreeText),
          TextSpan(
            text: termsText,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchURL(termOfServiceUrl),
          ),
          TextSpan(text: andText),
          TextSpan(
            text: privacyText,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchURL(privacyPolicyUrl),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}

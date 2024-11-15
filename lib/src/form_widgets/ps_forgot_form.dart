part of '../../pure_scale_widgets.dart';

class PsForgotForm extends StatefulWidget {
  final Function(String email) resetAction;
  final Function()? backAction;

  final RxBool isLoading;

  final String resetText;
  final String resetActionText;
  final String emailText;
  final String emailEnterText;
  final String emailValidText;
  final String backText;
  final double width;

  const PsForgotForm({
    super.key,
    required this.resetAction,
    required this.backAction,
    this.resetText = "Forgot Password",
    this.resetActionText = "Reset Password",
    this.emailText = "Email",
    this.emailEnterText = 'Please enter your email',
    this.emailValidText = 'Please enter a valid email',
    this.backText = 'Back to Login',
    required this.isLoading,
    this.width = 300,
  });

  @override
  _PsForgotFormState createState() => _PsForgotFormState();
}

class _PsForgotFormState extends State<PsForgotForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  void onSubmitAction() {
    if (formKey.currentState!.validate()) {
      widget.resetAction(emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: PSCardWidget(
            width: widget.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.resetText,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: widget.emailEnterText,
                    labelText: widget.emailText,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return widget.emailEnterText;
                    }
                    if (!GetUtils.isEmail(value)) {
                      return widget.emailValidText;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: PSPrimaryButton(
                      text: widget.resetActionText,
                      isLoading: widget.isLoading.value,
                      onPressed: onSubmitAction,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: widget.backAction,
                  child: Text(widget.backText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

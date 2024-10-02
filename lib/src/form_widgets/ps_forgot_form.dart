part of '../../pure_scale_widgets.dart';

class PsForgotForm extends StatefulWidget {
  final Function({String email}) resetAction;
  final Function()? backAction;

  final RxBool isLoading;

  final String resetText;
  final String resetActionText;
  final String emailText;
  final String emailEnterText;
  final String emailValidText;
  final String backText;

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

  });

  @override
  _PsForgotFormState createState() => _PsForgotFormState();
}

class _PsForgotFormState extends State<PsForgotForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onSubmitAction() {
    widget.resetAction(
      email: emailController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: PSCardWidget(
            width: 300,
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
                    hintText: widget.emailText,
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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

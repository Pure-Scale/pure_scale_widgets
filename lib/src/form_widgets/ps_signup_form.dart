part of '../../pure_scale_widgets.dart';

class PsSignupForm extends StatefulWidget {
  final Function()? loginAction;
  final Function()? forgotPasswordAction;
  final Function({String name,String email, String password,}) signupAction;

  final RxBool isLoading;

  final String loginText;
  final String emailText;
  final String emailEnterText;
  final String emailValidText;
  final String passwordText;
  final String passwordEnterText;
  final String passwordValidText;
  final String forgotPasswordText;
  final String alreadyAccountText;
  final String signupText;

  final Widget privacyAndTermsWidget;

  const PsSignupForm({
    super.key,
    required this.loginAction,
    required this.forgotPasswordAction,
    required this.signupAction,
    this.loginText = "Login",
    this.emailText = "Email",
    this.emailEnterText = 'Please enter your email',
    this.emailValidText = 'Please enter a valid email',
    this.passwordText = 'Password',
    this.passwordEnterText = 'Please enter your password',
    this.passwordValidText = 'Password must be at least 6 characters long',
    this.forgotPasswordText = 'Forgot Password?',
    this.alreadyAccountText = 'Already have an account?',
    this.signupText = 'Sign Up',
    required this.isLoading,
    required this.privacyAndTermsWidget,

  });

  @override
  _PsSignupFormState createState() => _PsSignupFormState();
}

class _PsSignupFormState extends State<PsSignupForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onSubmitAction() {
    widget.signupAction(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
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
                  widget.loginText,
                  style: Theme.of(context).textTheme.headlineMedium,
                ).marginOnly(bottom: 20),
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
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
                ).marginOnly(bottom: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => onSubmitAction(),
                  decoration: InputDecoration(
                    hintText: widget.passwordText,
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return widget.passwordEnterText;
                    }
                    if (value.length < 6) {
                      return widget.passwordValidText;
                    }
                    return null;
                  },
                ).marginOnly(bottom: 20),
                TextButton(
                  onPressed: widget.forgotPasswordAction,
                  child: Text(widget.forgotPasswordText),
                ).marginOnly(bottom: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.alreadyAccountText),
                    TextButton(
                      onPressed: widget.loginAction,
                      child: Text(
                        widget.loginText,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .primary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ).marginOnly(bottom: 20),
                widget.privacyAndTermsWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

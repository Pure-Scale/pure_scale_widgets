part of '../../pure_scale_widgets.dart';

class PsLoginForm extends StatefulWidget {
  final Function(String email, String password) loginAction;
  final Function()? forgotPasswordAction;
  final Function()? signUpAction;

  final RxBool isLoading;

  final String loginText;
  final String emailText;
  final String emailEnterText;
  final String emailValidText;
  final String passwordText;
  final String passwordEnterText;
  final String passwordValidText;
  final String forgotPasswordText;
  final String dontHaveAccountText;
  final String signupText;

  final Widget privacyAndTermsWidget;

  const PsLoginForm({
    super.key,
    required this.loginAction,
    required this.forgotPasswordAction,
    required this.signUpAction,
    this.loginText = "Login",
    this.emailText = "Email",
    this.emailEnterText = 'Please enter your email',
    this.emailValidText = 'Please enter a valid email',
    this.passwordText = 'Password',
    this.passwordEnterText = 'Please enter your password',
    this.passwordValidText = 'Password must be at least 6 characters long',
    this.forgotPasswordText = 'Forgot Password?',
    this.dontHaveAccountText = "Don't have an account yet? ",
    this.signupText = 'Sign Up',
    required this.isLoading,
    required this.privacyAndTermsWidget,
  });

  @override
  _PsLoginFormState createState() => _PsLoginFormState();
}

class _PsLoginFormState extends State<PsLoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onSubmitAction() {
    widget.loginAction(
      emailController.text,
      passwordController.text,
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
                ).marginOnly(bottom: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => onSubmitAction(),
                  decoration: InputDecoration(
                    hintText: widget.passwordEnterText,
                    labelText: widget.passwordText,
                    prefixIcon: const Icon(Icons.lock),
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
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: PSPrimaryButton(
                      isLoading: widget.isLoading.value,
                      text: widget.loginText,
                      onPressed: onSubmitAction,
                    ),
                  ),
                ).marginOnly(bottom: 10),
                if (widget.forgotPasswordAction != null)
                  TextButton(
                    onPressed: widget.forgotPasswordAction,
                    child: Text(widget.forgotPasswordText),
                  ).marginOnly(bottom: 10),
                if (widget.signUpAction != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.dontHaveAccountText),
                      TextButton(
                        onPressed: widget.signUpAction,
                        child: Text(
                          widget.signupText,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
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

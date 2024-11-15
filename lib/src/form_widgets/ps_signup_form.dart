part of '../../pure_scale_widgets.dart';

class PsSignupForm extends StatefulWidget {
  final Function()? loginAction;
  final Function(String fName, String lName, String email, String password)
      signupAction;

  final RxBool isLoading;

  final String loginText;
  final String emailText;
  final String emailEnterText;
  final String emailValidText;
  final String fNameText;
  final String fNameEnterText;
  final String fNameValidText;
  final String lNameText;
  final String lNameEnterText;
  final String lNameValidText;
  final String passwordText;
  final String passwordEnterText;
  final String passwordValidText;
  final String alreadyAccountText;
  final String signupText;

  final Widget privacyAndTermsWidget;
  final double width;

  const PsSignupForm({
    super.key,
    required this.loginAction,
    required this.signupAction,
    this.loginText = "Login",
    this.emailText = "Email",
    this.emailEnterText = 'Please enter your email',
    this.emailValidText = 'Please enter a valid email',
    this.fNameText = "First Name",
    this.fNameEnterText = 'Please enter your First Name',
    this.fNameValidText = 'Please enter a valid First Name',
    this.lNameText = "Last Name",
    this.lNameEnterText = 'Please enter your Last Name',
    this.lNameValidText = 'Please enter a valid Last Name',
    this.passwordText = 'Password',
    this.passwordEnterText = 'Please enter your password',
    this.passwordValidText = 'Password must be at least 6 characters long',
    this.alreadyAccountText = 'Already have an account?',
    this.signupText = 'Sign Up',
    required this.isLoading,
    required this.privacyAndTermsWidget,
    this.width = 300,
  });

  @override
  _PsSignupFormState createState() => _PsSignupFormState();
}

class _PsSignupFormState extends State<PsSignupForm> {
  final formKey = GlobalKey<FormState>();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onSubmitAction() {
    if (formKey.currentState!.validate()) {
      widget.signupAction(
        fNameController.text,
        lNameController.text,
        emailController.text,
        passwordController.text,
      );
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
                  widget.signupText,
                  style: Theme.of(context).textTheme.headlineMedium,
                ).marginOnly(bottom: 20),
                TextFormField(
                  controller: fNameController,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.name],
                  decoration: InputDecoration(
                    hintText: widget.fNameEnterText,
                    labelText: widget.fNameText,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return widget.fNameEnterText;
                    }
                    return null;
                  },
                ).marginOnly(bottom: 10),
                TextFormField(
                  controller: lNameController,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.name],
                  decoration: InputDecoration(
                    hintText: widget.lNameEnterText,
                    labelText: widget.lNameText,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return widget.lNameEnterText;
                    }
                    return null;
                  },
                ).marginOnly(bottom: 10),
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
                      text: widget.signupText,
                      onPressed: onSubmitAction,
                    ),
                  ),
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

part of '../../pure_scale_widgets.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({
    super.key,
    this.initBuyerName = '',
    this.formKey,
    required this.onSubmit,
    required this.onCancel,
    this.submitLabel = 'Add Card',
  });

  final String initBuyerName;
  final GlobalKey<FormState>? formKey;
  final Function(CreditCardInfo) onSubmit;
  final Function() onCancel;
  final String submitLabel;

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  late final GlobalKey<FormState> _formKey; // = GlobalKey<FormState>();
  CardBrand brand = CardBrand.n_a;

  bool get isCvvFront => brand == CardBrand.amex;

  int chosenCountryIndex = 0;

  TextEditingController cCardNumber = TextEditingController();
  TextEditingController cExpiry = TextEditingController();
  TextEditingController cSecurity = TextEditingController();
  TextEditingController cName = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.formKey != null) {
      _formKey = widget.formKey!;
    } else {
      _formKey = GlobalKey<FormState>();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initBuyerName.isNotEmpty) {
      cName.text = widget.initBuyerName;
    }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(4, 16, 0, 4),
                child: Text('Card Information'),
              ),
            ],
          ),
          TextFormFieldWrapper(
            position: TextFormFieldPosition.top,
                  borderFocusedColor: Theme.of(context).colorScheme.primary,
            formField: TextFormField(
              controller: cName,
              keyboardType: TextInputType.name,
              autofillHints: [AutofillHints.name],
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              validator: (input) {
                if (input!.isNotEmpty &&
                    CreditNameSubmitRegexValidator().isValid(input)) {
                  return null;
                } else {
                  return 'Enter a valid name';
                }
              },
              decoration: const InputDecoration(
                hintText: 'Card Holder Name',
                counterText: '',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          TextFormFieldWrapper(
            position: TextFormFieldPosition.center,
            borderFocusedColor: Theme.of(context).colorScheme.primary,
            formField: TextFormField(
              controller: cCardNumber,
              keyboardType: TextInputType.number,
              autofillHints: [AutofillHints.creditCardNumber],
              validator: (value) {
                if (CreditNumberSubmitRegexValidator().isValid(value!)) {
                  return null;
                }
                return 'Enter a valid card number';
              },
              inputFormatters: [
                MaskedTextInputFormatter(
                  mask: brand == CardBrand.amex
                      ? 'xxxx xxxxxxx xxxx'
                      : 'xxxx xxxx xxxx xxxx',
                  separator: ' ',
                )
              ],
              decoration: const InputDecoration(
                hintText: '1234 1234 1234 1234',
                counterText: '',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              onChanged: (input) {
                CardBrand newBrand =
                    CardTypeRegs.findBrand(input.replaceAll(' ', ''));
                if (brand != newBrand) {
                  setState(() {
                    brand = newBrand;
                  });
                }
              },
            ),
            suffix: _BrandsDisplay(
              brand: brand,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormFieldWrapper(
                  position: TextFormFieldPosition.bottomLeft,
                  borderFocusedColor: Theme.of(context).colorScheme.primary,
                  formField: TextFormField(
                    scrollPadding: EdgeInsets.zero,
                    controller: cExpiry,
                    keyboardType: TextInputType.number,
                    autofillHints: [AutofillHints.creditCardExpirationDate],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Expiry Date is required';
                      }

                      final currentDate = DateTime.now();
                      final currentMonth = currentDate.month;
                      final currentYear = currentDate.year %
                          100; // Get last two digits of the year

                      final parts = value.split('/');
                      if (parts.length != 2) {
                        return 'Expiry Date must be in MM/YY format';
                      }

                      final month = int.tryParse(parts[0]);
                      final year = int.tryParse(parts[1]);

                      if (month == null || month < 1 || month > 12) {
                        return 'Month must be between 01 and 12';
                      }

                      if (year == null ||
                          year < currentYear ||
                          (year == currentYear && month < currentMonth)) {
                        return 'Expiry Date must be in the future';
                      }

                      if (year > currentYear + 5) {
                        return 'Expiry Date cannot be more than 5 years in the future';
                      }

                      if (CreditExpirySubmitRegexValidator().isValid(value)) {
                        return null;
                      }
                      return "Invalid";
                    },
                    inputFormatters: [
                      MaskedTextInputFormatter(
                        mask: 'xx/xx',
                        separator: '/',
                      )
                    ],
                    decoration: const InputDecoration(
                      hintText: 'MM / YY',
                      counterText: '',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextFormFieldWrapper(
                  position: TextFormFieldPosition.bottomRight,
                  borderFocusedColor: Theme.of(context).colorScheme.primary,
                  formField: TextFormField(
                    scrollPadding: EdgeInsets.zero,
                    controller: cSecurity,
                    maxLength: 3,
                    autofillHints: [AutofillHints.creditCardSecurityCode],
                    validator: (value) {
                      if (CreditCvvSubmitRegexValidator().isValid(value!)) {
                        return null;
                      }
                      return "Invalid";
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      MaskedTextInputFormatter(
                        mask: brand == CardBrand.amex ? 'xxxx' : 'xxx',
                        separator: '',
                      )
                    ],
                    decoration: const InputDecoration(
                      hintText: 'CVC',
                      counterText: '',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                  suffix: SizedBox(
                    height: 30,
                    width: 30,
                    child: isCvvFront
                        ? Image.asset('assets/images/cvv_front.png')
                        : Image.asset('assets/images/cvv_back.png'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              PSSecondaryButton(
                onPressed: widget.onCancel,
                text: 'Cancel',
              ),
              PSPrimaryButton(
                text: widget.submitLabel,
                onPressed: () {
                  bool result = _formKey.currentState!.validate();
                  if (result) {
                    _formKey.currentState!.save();
                    widget.onSubmit(
                      CreditCardInfo(
                        cardBrand: brand,
                        cardNumber: cCardNumber.text.replaceAll(' ', ''),
                        expiryDate: cExpiry.text,
                        cvv: cSecurity.text,
                        cardHolderName: cName.text,
                        cardIcon: _BrandsDisplay(
                          brand: brand,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: constant_identifier_names
enum CardBrand { n_a, visa, masterCard, discover, amex, diners, jcb, union }

class CardTypeRegs {
  static final RegExp _visa = RegExp(r'^4[0-9]{0,}$');
  static final RegExp _master =
      RegExp(r'^(5[1-5]|222[1-9]|22[3-9]|2[3-6]|27[01]|2720)[0-9]{0,}$');
  static final RegExp _discover = RegExp(
      r'^(6011|65|64[4-9]|62212[6-9]|6221[3-9]|622[2-8]|6229[01]|62292[0-5])[0-9]{0,}$');
  static final RegExp _amex = RegExp(r'^3[47][0-9]{0,}$');
  static final RegExp _diners = RegExp(r'^3(?:0[0-59]{1}|[689])[0-9]{0,}$');
  static final RegExp _jcb = RegExp(r'^(?:2131|1800|35)[0-9]{0,}$');
  static final RegExp _union = RegExp(r'^(62|88)\d+$');

  static CardBrand findBrand(String cardNUmber) {
    if (_visa.matchAsPrefix(cardNUmber) != null) return CardBrand.visa;
    if (_master.matchAsPrefix(cardNUmber) != null) return CardBrand.masterCard;
    if (_discover.matchAsPrefix(cardNUmber) != null) return CardBrand.discover;
    if (_diners.matchAsPrefix(cardNUmber) != null) return CardBrand.diners;
    if (_amex.matchAsPrefix(cardNUmber) != null) return CardBrand.amex;
    if (_jcb.matchAsPrefix(cardNUmber) != null) return CardBrand.jcb;
    if (_union.matchAsPrefix(cardNUmber) != null) return CardBrand.union;
    return CardBrand.n_a;
  }
}

class _BrandsDisplay extends StatefulWidget {
  const _BrandsDisplay({Key? key, this.brand = CardBrand.n_a})
      : super(key: key);
  final CardBrand brand;

  @override
  _BrandsDisplayState createState() => _BrandsDisplayState();
}

class _BrandsDisplayState extends State<_BrandsDisplay> {
  bool get displayAll => (widget.brand == CardBrand.n_a);
  int counter = 0;
  bool isVisible = true;

  Widget diners = SizedBox(
    height: 15,
    width: 30,
    child: Image.asset('assets/images/card_diners.png'),
  );
  Widget jcb = SizedBox(
    height: 15,
    width: 30,
    child: Image.asset('assets/images/card_jcb.png'),
  );
  Widget union = SizedBox(
    height: 15,
    width: 30,
    child: Image.asset('assets/images/card_union_pay.png'),
  );
  Widget discover = SizedBox(
    height: 15,
    width: 30,
    child: Image.asset('assets/images/card_discover.png'),
  );
  Widget visa = SizedBox(
    height: 15,
    width: 30,
    child: Image.asset('assets/images/card_visa.png'),
  );
  Widget master = SizedBox(
    height: 15,
    width: 30,
    child: Image.asset('assets/images/card_mastercard.png'),
  );
  Widget amex = SizedBox(
    height: 15,
    width: 30,
    child: Image.asset('assets/images/card_amex.png'),
  );

  Widget? image;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 3);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (timer.tick % 4 == 0) {
        setState(() {
          image = discover;
        });
      } else if (timer.tick % 4 == 1) {
        setState(() {
          image = jcb;
        });
      } else if (timer.tick % 4 == 2) {
        setState(() {
          image = diners;
        });
      } else if (timer.tick % 4 == 3) {
        setState(() {
          image = union;
        });
      }
    });
  }

  Widget get mainImage {
    switch (widget.brand) {
      case CardBrand.amex:
        return amex;
      case CardBrand.masterCard:
        return master;
      case CardBrand.discover:
        return discover;
      case CardBrand.diners:
        return diners;
      case CardBrand.jcb:
        return jcb;
      case CardBrand.union:
        return union;
      default:
        return visa;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (widget.brand != CardBrand.n_a)
        ? mainImage
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              visa,
              master,
              amex,
              Container(
                constraints: const BoxConstraints(maxWidth: 30, maxHeight: 15),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 700),
                  child: image ?? discover,
                ),
              ),
            ],
          );
  }
}

class FormValidator {
  String? validateName(String input) {
    const pattern = r'(^[a-zA-Z]{1,35}$)';
    final regExp = RegExp(pattern);

    if (input.isEmpty) {
      return 'Entry Required';
    } else if (input.length > 35) {
      return 'Maximum of 35 characters';
    } else if (!regExp.hasMatch(input)) {
      return 'Only alpha characters accepted';
    } else {
      return null;
    }
  }

  String? validatePhone(String input) {
    const pattern = r'(^[0-9]{10}$)'; // 2345678901
    final regExp = RegExp(pattern);
    const pattern2 = r'(^\d{3}-\d{3}-\d{4}$)'; //234-567-8901
    final regExp2 = RegExp(pattern2);

    if (input.isEmpty) {
      return 'Entry Required';
    } else if (input.length > 10) {
      return 'Maximum of 10 digits';
    } else if (!(regExp.hasMatch(input) || regExp2.hasMatch(input))) {
      return 'Only numeric digits accepted';
    } else {
      return null;
    }
  }

  static String getDisplayAmexNumberFormat(String input) {
    // amex   4-6-5

    input = input.replaceAll(RegExp("[^\\d]"), "");
    if (input.length >= 4) {
      input = '${input.substring(0, 4)} ${input.substring(4)}';
    }
    if (input.length >= 11) {
      input = '${input.substring(0, 9)} ${input.substring(9)}';
    }
    if (input.length >= 18) {
      input = input.substring(0, 18);
    }
    return input;
  }

  static String getDisplayCreditNumberFormat(String input) {
    // visa   4-4-4-4
    // disc   4-4-4-4
    // master 4-4-4-4
    // diners 4-4-4-4
    // jcb    4-4-4-4
    // union  4-4-4-4

    input = input.replaceAll(RegExp("[^\\d]"), "");
    if (input.length >= 4) {
      input = '${input.substring(0, 4)} ${input.substring(4)}';
    }
    if (input.length >= 9) {
      input = '${input.substring(0, 9)} ${input.substring(9)}';
    }
    if (input.length >= 14) {
      input = '${input.substring(0, 14)} ${input.substring(14)}';
    }
    if (input.length >= 19) {
      input = input.substring(0, 19);
    }
    return input;
  }

  static String getDisplayCreditExpFormat(String input) {
    input = input.replaceAll(RegExp("[^\\d]"), "");

    if (input.isNotEmpty &&
        (input.length == 1) &&
        (input[0] != '0' && input[0] != '1')) {
      input = '0$input';
    }
    if (input.length >= 2) {
      input = '${input.substring(0, 2)}/${input.substring(2)}';
    }
    if (input.length >= 5) {
      input = input.substring(0, 5);
    }
    return input;
  }
}

abstract class StringValidator {
  bool isValid(String value);
}

class RegexValidator implements StringValidator {
  RegexValidator({this.regexSource});
  final String? regexSource;

  /// value: the input string
  /// returns: true if the input string is a full match for regexSource
  @override
  bool isValid(String value) {
    try {
      final regex = RegExp(regexSource!);
      final matches = regex.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}

class ValidatorInputFormatter implements TextInputFormatter {
  ValidatorInputFormatter({this.editingValidator});
  final StringValidator? editingValidator;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueValid = editingValidator!.isValid(oldValue.text);
    final newValueValid = editingValidator!.isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }
}

class CreditNumberSubmitRegexValidator extends RegexValidator {
  CreditNumberSubmitRegexValidator()
      : super(regexSource: r'^\d{4}\s\d{4}\s\d{4}\s\d{4}$');
}

class CreditExpirySubmitRegexValidator extends RegexValidator {
  CreditExpirySubmitRegexValidator()
      : super(regexSource: r'^(0[1-9]|1[0-2])\/?[0-2][0-9]|3[0-1]$');
}

class CreditCvvSubmitRegexValidator extends RegexValidator {
  CreditCvvSubmitRegexValidator() : super(regexSource: r'^[0-9]{3,4}$');
}

class CreditNameSubmitRegexValidator extends RegexValidator {
  CreditNameSubmitRegexValidator() : super(regexSource: r'^[a-zA-Z\s]*$');
}

class PhoneRegexValidator extends RegexValidator {
  PhoneRegexValidator() : super(regexSource: r'^[0-9]{10}$');
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}

class CreditCardInfo {
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final Widget? cardIcon;
  final CardBrand? cardBrand;

  CreditCardInfo({
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    this.cardIcon,
    this.cardBrand,
  });

  String get maskedCardNumber {
    // Keep the last 4 digits and mask the rest with '*'
    if (cardNumber.length <= 4) {
      return cardNumber; // Return as is if the card number is 4 digits or less
    }
    String lastFourDigits = cardNumber.substring(cardNumber.length - 4);
    return cardBrand == CardBrand.amex
        ? 'xxxx xxxxxxx $lastFourDigits'
        : 'xxxx xxxx xxxx $lastFourDigits';
  }
}

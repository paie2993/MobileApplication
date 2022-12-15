import '../../../resources/forms/form_regex.dart';
import '../../../resources/forms/form_text.dart';

class FormValidators {
  static const int defaultPaidSumValue = 0;

  static String? validateTotalSum(String? value) =>
      (value == null || value.isEmpty || !FormRegex.numberRegex.hasMatch(value))
          ? FormText.invalidInputWarning
          : null;

  static String? validatePaidSum(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (FormRegex.numberRegex.hasMatch(value)) {
      return null;
    }
    return FormText.invalidInputWarning;
  }

  static String? validateReason(String? value) =>
      (value == null || value.isEmpty) ? FormText.invalidInputWarning : null;

  static String? validateAddress(String? value) =>
      (value == null || value.isEmpty) ? FormText.invalidInputWarning : null;

  static String? validateIban(String? value) => null;

// semantic validation
  static bool validateSums(int totalSum, int paidSum) => paidSum <= totalSum;
}

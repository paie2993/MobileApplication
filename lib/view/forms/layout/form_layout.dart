import 'package:flutter/material.dart';

import '../../../resources/forms/form_text.dart';

class FormLayout {
  static const double paddingValue = 16.00;
  static const EdgeInsetsGeometry padding = EdgeInsets.all(paddingValue);

  static const totalSumInputDecoration = InputDecoration(
    hintText: FormText.totalSumHint,
    helperText: FormText.totalSumHelper,
  );

  static const paidSumInputDecoration = InputDecoration(
    hintText: FormText.paidSumHint,
    helperText: FormText.paidSumHelper,
    counterText: FormText.paidSumHelper,
  );

  static const reasonInputDecoration = InputDecoration(
    hintText: FormText.reasonHint,
    helperText: FormText.reasonHelper,
  );

  static const addressInputDecoration = InputDecoration(
    hintText: FormText.addressHint,
    helperText: FormText.addressHelper,
  );

  static const ibanInputDecoration = InputDecoration(
    hintText: FormText.ibanHint,
    helperText: FormText.ibanHelper,
  );
}

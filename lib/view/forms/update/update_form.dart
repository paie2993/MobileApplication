import 'package:flutter/material.dart';
import 'package:flutter_crud/view/forms/payment_form.dart';

import '../../../database/database.dart';

class UpdateFormWidget extends StatefulWidget {
  const UpdateFormWidget({super.key});

  @override
  State<StatefulWidget> createState() => UpdatePaymentFormState();
}

class UpdatePaymentFormState extends PaymentFormState {
  Payments? selectedPayment;

  UpdatePaymentFormState() {
    selectedPayment = viewModel.selectedPayment;
  }

  @override
  void initState() {
    super.initState();
    _initializeTextFields();
  }

  @override
  String execute() => viewModel.updatePayment();

  void _initializeTextFields() {
    viewModel.totalSumController.text =
        selectedPayment != null ? selectedPayment!.totalSum.toString() : '';
    viewModel.paidSumController.text =
        selectedPayment != null ? selectedPayment!.paidSum.toString() : '';
    viewModel.reasonController.text =
        selectedPayment != null ? selectedPayment!.reason.toString() : '';
    viewModel.addressController.text =
        selectedPayment != null ? selectedPayment!.address.toString() : '';

    var iban = selectedPayment != null ? selectedPayment!.iban : '';
    viewModel.ibanController.text = iban ?? '';
  }
}

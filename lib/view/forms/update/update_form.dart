import 'package:flutter/material.dart';
import 'package:flutter_crud/resources/defaults/form_defaults.dart';
import 'package:flutter_crud/view/forms/payment_form.dart';
import 'dart:developer' as developer;
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

  // initializing the fields with values of the underlying payment (if possible)
  void _initializeTextFields() {
    developer.log("Was definitely here");
    _initializeTotalSum();
    _initializePaidSum();
    _initializeReason();
    _initializeAddress();
    _initializeIban();
  }

  void _initializeTotalSum() {
    viewModel.totalSumController.text = selectedPayment != null
        ? selectedPayment!.totalSum.toString()
        : FormDefaults.empty;
  }

  void _initializePaidSum() {
    viewModel.paidSumController.text = selectedPayment != null
        ? selectedPayment!.paidSum.toString()
        : FormDefaults.empty;
  }

  void _initializeReason() {
    viewModel.reasonController.text = selectedPayment != null
        ? selectedPayment!.reason.toString()
        : FormDefaults.empty;
  }

  void _initializeAddress() {
    viewModel.addressController.text = selectedPayment != null
        ? selectedPayment!.address.toString()
        : FormDefaults.empty;
  }

  void _initializeIban() {
    var iban = selectedPayment != null ? selectedPayment!.iban : '';
    viewModel.ibanController.text = iban ?? FormDefaults.empty;
  }
}

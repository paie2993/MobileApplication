import 'package:flutter/material.dart';
import 'package:flutter_crud/forms/payment_form.dart';
import 'package:flutter_crud/repository.dart';

import '../model.dart';

class UpdateFormWidget extends StatefulWidget {
  const UpdateFormWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return UpdatePaymentFormState();
  }
}

class UpdatePaymentFormState extends MyFormState {
  @override
  void initState() {
    super.initState();

    if (Repository.getToUpdate() == null) {
      _handleUpdateException();
    } else {
      _initializeTextFields();
    }
  }

  @override
  void execute() {
    Payment newPayment = Payment(
        double.parse(totalSumController.text),
        double.parse(paidSumController.text),
        reasonController.text,
        addressController.text,
        ibanController.text);
    Repository.add(newPayment);
  }

  void _handleUpdateException() {
    var snackBar = SnackBar(
      content: const Text('Could not identify payment to update'),
      action: SnackBarAction(
        label: 'Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _initializeTextFields() {
    final Payment payment = Repository.get(Repository.getToUpdate()!);
    totalSumController.text = payment.totalSum.toString();
    paidSumController.text = payment.paidSum.toString();
    reasonController.text = payment.reason;
    addressController.text = payment.address;
    ibanController.text = payment.iban != null ? payment.iban! : '';
  }
}

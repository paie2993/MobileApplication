import 'package:flutter/material.dart';
import 'package:flutter_crud/forms/payment_form.dart';

import '../model.dart';
import '../repository.dart';

class AddFormWidget extends StatefulWidget {
  const AddFormWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddPaymentFormState();
  }
}

class AddPaymentFormState extends MyFormState {
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
}

import 'package:flutter/material.dart';
import '../payment_form.dart';

class AddFormWidget extends StatefulWidget {
  const AddFormWidget({super.key});

  @override
  State<StatefulWidget> createState() => AddPaymentFormState();
}

class AddPaymentFormState extends PaymentFormState {
  AddPaymentFormState();

  @override
  String execute() => viewModel.add();
}

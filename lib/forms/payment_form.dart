import 'package:flutter/material.dart';
import 'package:flutter_crud/forms/form_fields.dart';

class ChangeRoute extends StatelessWidget {
  final String routeTitle;
  final StatefulWidget statefulWidget;

  const ChangeRoute(this.routeTitle, this.statefulWidget, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(routeTitle),
      ),
      body: statefulWidget,
    );
  }
}

abstract class MyFormState extends State<StatefulWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController totalSumController = TextEditingController();
  final TextEditingController paidSumController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ibanController = TextEditingController();

  @override
  void dispose() {
    totalSumController.dispose();
    paidSumController.dispose();
    reasonController.dispose();
    addressController.dispose();
    ibanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.00, bottom: 16.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormFields.getTotalSumField(totalSumController),
            FormFields.getPaidSumField(paidSumController),
            FormFields.getReasonField(reasonController),
            FormFields.getAddressField(addressController),
            FormFields.getIBANField(ibanController),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() => Padding(
        padding: const EdgeInsets.all(16.00),
        child: ElevatedButton(
          onPressed: () {
            if (!_sumsAreValid()) {
              _handleInvalidSums();
            } else {
              execute();
              Navigator.pop(context);
            }
          },
          child: const Text('Submit'),
        ),
      );

  bool _sumsAreValid() {
    double totalSum = double.parse(totalSumController.text);

    double paidSum;
    String paidSumString = paidSumController.text;
    if (paidSumString.isEmpty) {
      paidSum = 0;
    } else {
      paidSum = double.parse(paidSumString);
    }

    return paidSum <= totalSum;
  }

  void _handleInvalidSums() {
    const snackBar = SnackBar(
      content: Text('Paid Sum must be less than Total Sum'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void execute();
}

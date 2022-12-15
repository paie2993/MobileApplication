import 'package:flutter/material.dart';
import 'package:flutter_crud/view/forms/protocol/protocol.dart';
import 'package:flutter_crud/view/forms/validators/form_validators.dart';
import '../../view_model/form_view_model.dart';
import 'layout/form_layout.dart';

class PaymentForm extends StatelessWidget {
  final String routeTitle;
  final StatefulWidget statefulWidget;

  const PaymentForm(this.routeTitle, this.statefulWidget, {super.key});

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

abstract class PaymentFormState extends State<StatefulWidget> {
  // used for form validation
  final _formKey = GlobalKey<FormState>();

  // constants
  static const _formFieldsAlignment = CrossAxisAlignment.center;

  static const _submitButtonText = 'Submit';

  // the viewModel
  late final FormViewModel viewModel;

  // constructor
  PaymentFormState() {
    viewModel = FormViewModel.get();
  }

  // abstract method
  String execute();

  // view creation
  @override
  Widget build(BuildContext context) => _form();

  @override
  void dispose() {
    viewModel.clear();
    super.dispose();
  }

  Form _form() => Form(
        key: _formKey,
        child: _formFieldsWrapper(),
      );

  Padding _formFieldsWrapper() => Padding(
        padding: FormLayout.padding,
        child: _formWidgets(),
      );

  Column _formWidgets() => Column(
        crossAxisAlignment: _formFieldsAlignment,
        children: [
          TextFormField(
            decoration: FormLayout.totalSumInputDecoration,
            controller: viewModel.totalSumController,
            validator: FormValidators.validateTotalSum,
          ),
          TextFormField(
            decoration: FormLayout.paidSumInputDecoration,
            controller: viewModel.paidSumController,
            validator: FormValidators.validatePaidSum,
          ),
          TextFormField(
            decoration: FormLayout.reasonInputDecoration,
            controller: viewModel.reasonController,
            validator: FormValidators.validateReason,
          ),
          TextFormField(
            decoration: FormLayout.addressInputDecoration,
            controller: viewModel.addressController,
            validator: FormValidators.validateAddress,
          ),
          TextFormField(
            decoration: FormLayout.ibanInputDecoration,
            controller: viewModel.ibanController,
            validator: FormValidators.validateIban,
          ),
          _submitButtonWrapper(),
        ],
      );

  // the submit button with some padding
  Widget _submitButtonWrapper() => Padding(
        padding: FormLayout.padding,
        child: _submitButton(),
      );

  // the definition of the submit button
  ElevatedButton _submitButton() => ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            var result = execute();

            switch (result) {
              case FormProtocol.success:
                Navigator.pop(context);
                break;
              default:
                _handleFailure(result);
                break;
            }
          }
        },
        child: const Text(_submitButtonText),
      );

  void _handleFailure(final String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

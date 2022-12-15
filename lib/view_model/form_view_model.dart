import 'package:flutter/material.dart';
import 'package:observer/observer.dart';

import '../database/database.dart';
import '../repository/repository.dart';
import '../view/forms/protocol/protocol.dart';
import '../view/forms/validators/form_validators.dart';

class FormViewModel with Observer {
  final Repository repository;

  // for the update functionality
  Payments? selectedPayment;

  // the state that will be expose to the view
  // these are the binding offered by the viewModel to the view
  TextEditingController totalSumController = TextEditingController();
  TextEditingController paidSumController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ibanController = TextEditingController();

  // related to singleton implementation ...
  FormViewModel(this.repository) {
    repository.addObserver(this);
  }

  static FormViewModel? _instance;

  static void initialize(Repository repository) =>
      _instance ??= FormViewModel(repository);

  static FormViewModel get() {
    if (_instance == null) {
      throw Exception("Instance of FormViewModel not initialized");
    }
    return _instance!;
  }

  // ... until here

  // related to the observer-observable pattern
  @override
  void update(Observable observable, Object arg) {}

  // related to the operations allowed on a form: adding and updating
  String add() {
    if (!_checkSumsValidity()) {
      return FormProtocol.invalidSums;
    }

    var payment = _payment();
    repository.add(payment);

    return FormProtocol.success;
  }

  Payments? getById(int id) => repository.getById(id);

  String updatePayment() {
    if (!_checkSumsValidity()) {
      return FormProtocol.invalidSums;
    }

    var payment = _payment();
    repository.update(payment);

    return FormProtocol.success;
  }

  // creating payment from the form fields
  Payments _payment() {
    var totalSum = int.parse(totalSumController.text);

    var paidSum = paidSumController.text.isEmpty
        ? FormValidators.defaultPaidSumValue
        : int.parse(paidSumController.text);

    var reason = reasonController.text;
    var address = addressController.text;
    var iban = ibanController.text;

    var id = 0;
    if (selectedPayment != null) {
      id = selectedPayment!.id;
    } else {
      id = repository.lastId() + 1;
    }

    return Payments(
      id: id,
      totalSum: totalSum,
      paidSum: paidSum,
      reason: reason,
      address: address,
      iban: iban,
    );
  }

  // handling of sums validity
  bool _checkSumsValidity() {
    var totalSum = int.parse(totalSumController.text);

    var paidSum = paidSumController.text.isEmpty
        ? FormValidators.defaultPaidSumValue
        : int.parse(paidSumController.text);

    return FormValidators.validateSums(totalSum, paidSum);
  }

  // resetting the FormViewModel for further re-use
  void clear() {
    totalSumController = TextEditingController();
    paidSumController = TextEditingController();
    reasonController = TextEditingController();
    addressController = TextEditingController();
    ibanController = TextEditingController();
  }
}

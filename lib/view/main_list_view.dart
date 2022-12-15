import 'package:flutter/material.dart';
import 'package:flutter_crud/view/forms/update/update_form.dart';
import 'package:flutter_crud/view_model/main_list_viewmodel.dart';
import 'package:observer/observer.dart';
import 'dart:developer' as developer;

import '../database/database.dart';
import 'forms/payment_form.dart';
import 'forms/validators/form_validators.dart';

// the widget representing the list of payments
class MainListWidget extends StatefulWidget {
  const MainListWidget({super.key});

  @override
  State<StatefulWidget> createState() => MainListState();
}

// abstraction of the state of the payment list
// observes the MainListViewModel
class MainListState extends State<MainListWidget> implements Observer {
  static const MainAxisAlignment detailsAxisAlignment = MainAxisAlignment.start;

  static const IconData leadingItemIcon = Icons.cake_sharp;
  static const IconData trailingItemIcon = Icons.delete;

  static const String itemRemovedMessage = 'Payment removed';
  static const String undoRemoveMessage = 'Undo';

  late final MainListViewModel viewModel;

  List<Payments> list = <Payments>[];

  MainListState() {
    viewModel = MainListViewModel.get();
    viewModel.addObserver(this);
  }

  @override
  void initState() {
    super.initState();
    list = viewModel.read(); // gets the list of Payments through the viewModel
  }

  // effectively build the view
  @override
  Widget build(BuildContext context) {
    developer.log('Starting to build the list view',
        name: 'MainListState:build');
    return ListView.builder(
      itemCount: _getItemCount(),
      itemBuilder: (context, index) {
        var payment = _getItem(index);

        return _interactiveItem(payment, index);
      },
    );
  }

  // related to observing the viewModel
  @override
  void update(Observable observable, Object arg) {
    list = arg as List<Payments>;
    developer.log('Received update from observable: $list',
        name: 'MainListState:update');
    setState(() {});
  }

  // number of items in list
  int _getItemCount() {
    var count = list.length;
    developer.log('Got list item count from local list: $count',
        name: 'MainListState:_getItemCount');
    return count;
  }

  // returns item at specified index
  Payments _getItem(int index) {
    var item = list[index];
    developer.log('Got item from local list: $item',
        name: 'MainListState:_getItem');
    return item;
  }

  // adds interactivity with the item from the list
  GestureDetector _interactiveItem(Payments payment, int index) =>
      GestureDetector(
        child: _listItemWrapperView(payment),
        onLongPress: () => _handleLongPress(context, payment),
        onTap: () => _handleTap(context, payment),
      );

  // wraps the item view in a convenient format for the Gesture Detector
  Card _listItemWrapperView(Payments payment) => Card(
        child: Column(
          children: [
            listItemTile(payment),
          ],
        ),
      );

  // view of one item from the list
  ListTile listItemTile(Payments payment) => ListTile(
        leading: const Icon(leadingItemIcon),
        title: Text(payment.reason),
        subtitle: Text(
            "${payment.paidSum ?? FormValidators.defaultPaidSumValue} \$ / ${payment.totalSum} \$"),
        trailing: _deleteButton(payment),
      );

  // functionality related to deleting an item from the list
  FloatingActionButton _deleteButton(Payments payment) =>
      FloatingActionButton.small(
        onPressed: () => _onDeleteTap(payment),
        child: const Icon(trailingItemIcon),
      );

  void _onDeleteTap(Payments payment) {
    viewModel.remove(payment.id);
    _showUndoRemove(payment);
  }

  void _showUndoRemove(Payments payment) {
    var snackbar = SnackBar(
      content: const Text(itemRemovedMessage),
      action: SnackBarAction(
        label: undoRemoveMessage,
        onPressed: () => viewModel.add(payment),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  // functionality related to starting the update
  void _handleLongPress(BuildContext context, Payments payment) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const PaymentForm(
            'Update payment',
            UpdateFormWidget(),
          ),
        ),
      );

  // functionality related to details modal from bottom of screen
  void _handleTap(BuildContext context, Payments payment) =>
      showModalBottomSheet(
        context: context,
        builder: (context) => _detailsModalColumn(payment),
      );

  Column _detailsModalColumn(Payments payment) => Column(
        mainAxisAlignment: detailsAxisAlignment,
        children: [
          _totalSumTile(payment),
          _paidSumTile(payment),
          _reasonTile(payment),
          _addressTile(payment),
          _ibanTile(payment),
        ],
      );

  ListTile _totalSumTile(Payments payment) => ListTile(
        title: Text('${payment.totalSum} \$'),
        subtitle: const Text('Total Sum'),
      );

  ListTile _paidSumTile(Payments payment) => ListTile(
        subtitle: const Text('Paid Sum'),
        title:
            Text('${payment.paidSum ?? FormValidators.defaultPaidSumValue} \$'),
      );

  ListTile _reasonTile(Payments payment) => ListTile(
        title: Text(payment.reason),
        subtitle: const Text('Reason'),
      );

  ListTile _addressTile(Payments payment) => ListTile(
        title: Text(payment.address),
        subtitle: const Text('Address'),
      );

  ListTile _ibanTile(Payments payment) => ListTile(
        title: Text(payment.iban != null ? payment.iban! : ''),
        subtitle: const Text('IBAN'),
      );
}

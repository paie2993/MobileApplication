import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_crud/database/database.dart';
import 'package:flutter_crud/repository/repository.dart';
import 'package:flutter_crud/view/forms/add/add_form.dart';
import 'package:flutter_crud/view/forms/payment_form.dart';
import 'package:flutter_crud/view/main_list_view.dart';
import 'package:flutter_crud/view_model/form_view_model.dart';
import 'package:flutter_crud/view_model/main_list_viewmodel.dart';

void main() {
  developer.log('Application is starting', name: 'main_list_viewmodel.dart');

  var database = PaymentDatabase();
  WidgetsFlutterBinding.ensureInitialized();


  var repository = Repository(database);

  MainListViewModel.initialize(repository);
  FormViewModel.initialize(repository);

  runApp(const MaterialApp(title: 'Flutter', home: HomeListRoute()));
}

// represent the user-interactive application
class HomeListRoute extends StatelessWidget {
  const HomeListRoute({super.key});

  static const String title = 'YouPay TM';

  static const String addButtonTooltip = 'Add New Payment';
  static const IconData addButtonIcon = Icons.add;

  @override
  Widget build(BuildContext context) => _mainWidget(context);

  // defined the widget hierarchy displayed on the main screen
  Scaffold _mainWidget(BuildContext context) => Scaffold(
        appBar: _titleAppBar(),
        body: const MainListWidget(),
        floatingActionButton: _addButton(context),
      );

  // title bar of the application
  AppBar _titleAppBar() => AppBar(title: const Text(title));

  // the floating action button leading to the 'add payment' form
  FloatingActionButton _addButton(BuildContext context) => FloatingActionButton(
        child: _addButtonIcon(),
        onPressed: () => _onAddPressedHandler(context),
      );

  // the icon of the 'add button'
  Icon _addButtonIcon() => const Icon(addButtonIcon);

  // the action of the 'add button'
  // it leads to a new path/ redirects the user to the 'add form' screen
  void _onAddPressedHandler(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PaymentForm(
            addButtonTooltip,
            AddFormWidget(),
          ),
        ),
      );
}

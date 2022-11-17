import 'package:flutter/material.dart';

import 'forms/add_form.dart';
import 'forms/payment_form.dart';
import 'list.dart';

void main() {
  runApp(const MaterialApp(title: 'Attempt at flutter', home: HomeListRoute()));
}

class HomeListRoute extends StatelessWidget {
  const HomeListRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YouPay TM')),
      body: const ListWidget(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => onPressedHandler(context),
      ),
    );
  }

  void onPressedHandler(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChangeRoute(
          'Add New Payment',
          AddFormWidget(),
        ),
      ),
    );
  }
}

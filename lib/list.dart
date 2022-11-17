import 'package:flutter/material.dart';
import 'package:flutter_crud/forms/payment_form.dart';
import 'package:flutter_crud/forms/update_form.dart';
import 'package:flutter_crud/repository.dart';

import 'model.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListState();
  }
}

class ListState extends State<ListWidget> {
  @override
  void initState() {
    super.initState();
    Repository.subscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Repository.list.length,
      itemBuilder: (context, i) {
        final Payment payment = Repository.get(i);

        return GestureDetector(
            onHorizontalDragEnd: (details) => _handleHorizontalDrag(details, i),
            onLongPress: () => _handleLongPress(context, i),
            onTap: () => _handleTap(context, i),
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.cake_sharp),
                    title: Text(payment.reasonToString()),
                    subtitle: Text(payment.sumsToString()),
                  ),
                ],
              ),
            ));
      },
    );
  }

  void update() => setState(() {});

  void _handleHorizontalDrag(DragEndDetails details, int index) {
    if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
      _onSwipe(index);
    }
  }

  void _onSwipe(int index) {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        final Payment removedPayment = Repository.get(index);
        Repository.remove(index);

        var snackbar = SnackBar(
          content: const Text('Payment removed.'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => Repository.add(removedPayment),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
    );
  }

  void _handleLongPress(BuildContext context, int index) {
    Repository.setToUpdate(index);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            const ChangeRoute('Update Payment', UpdateFormWidget()),
      ),
    );
  }

  void _handleTap(BuildContext context, int index) {
    final Payment payment = Repository.get(index);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text('${payment.totalSum} \$'),
              subtitle: const Text('Total Sum'),
            ),
            ListTile(
              subtitle: const Text('Paid Sum'),
              title: Text('${payment.paidSum} \$'),
            ),
            ListTile(
              title: Text(payment.reason),
              subtitle: const Text('Reason'),
            ),
            ListTile(
              title: Text(payment.address),
              subtitle: const Text('Address'),
            ),
            ListTile(
              title: Text(payment.iban != null ? payment.iban! : ''),
              subtitle: const Text('IBAN'),
            )
          ],
        );
      },
    );
  }
}

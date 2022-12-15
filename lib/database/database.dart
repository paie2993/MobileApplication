// To open the database, add these imports to the existing file defining the
// database class. They are used to open the database.
import 'dart:io';
import 'dart:developer' as developer;
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:flutter_crud/error_service/error_service.dart';
import 'package:observer/observer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// it's needed for drift to know about the generated code
part 'database.g.dart';

@DataClassName('Payments')
class Payment extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get totalSum => integer()();

  IntColumn get paidSum => integer().nullable()();

  TextColumn get reason => text()();

  TextColumn get address => text()();

  TextColumn get iban => text().nullable()();
}

@DriftDatabase(tables: [Payment])
class PaymentDatabase extends _$PaymentDatabase with Observable {
  // we tell the database where to store the data with this constructor
  PaymentDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  @override
  int get schemaVersion => 3;

  Future<List<Payments>> read() async {
    return select(payment).get();
  }

  // functionality related to adding a payment
  Future<void> add(Payments paymentToAdd) async {
    developer.log('Attempting to add item in database: $paymentToAdd',
        name: 'PaymentDatabase:add');

    try {
      await into(payment).insert(paymentToAdd);
    } on Exception catch (_, exception) {
      developer.log('Could not add item to database: $exception',
          name: 'PaymentDatabase:add');
      ErrorService.add(exception.toString());
    }
  }

  // functionality related to deleting a payment
  Future<void> remove(int idToRemove) async {
    developer.log('Attempting to delete item with id $idToRemove',
        name: 'PaymentDatabase:remove');

    Payments? paymentToRemove = await _fetchPayment(idToRemove);
    await _removePayment(paymentToRemove);
  }

  // fetch the payment with the given id from the database
  Future<Payments?> _fetchPayment(int idToRemove) async {
    Payments? paymentToRemove;

    final query = select(payment)
      ..where((element) => element.id.equals(idToRemove));

    try {
      paymentToRemove = await query.getSingle();
    } on Exception catch (_, exception) {
      developer.log('Could not identify item with id $idToRemove: $exception',
          name: 'PaymentDatabase:remove');
      ErrorService.add(exception.toString());
    }

    return paymentToRemove;
  }

  // remove that payment from the database
  Future<void> _removePayment(final Payments? payment) async {
    if (payment != null) {
      try {
        await delete(this.payment).delete(payment);
      } on Exception catch (_, exception) {
        developer.log('Could not delete payment $payment: $exception',
            name: 'PaymentDatabase:remove');
        ErrorService.add(exception.toString());
      }
    } else {
      var message = 'Could not find the payment to be deleted';
      developer.log(message, name: 'PaymentDatabase:_removePayment');
      ErrorService.add(message);
    }
  }

  Future<void> updateElement(Payments paymentToUpdate) async {
    try {
      await update(payment).replace(paymentToUpdate);
    } on Exception catch (_, exception) {
      developer.log(
          'Failed to update payment: $paymentToUpdate, error: $exception',
          name: 'PaymentDatabase:updateElement');
      ErrorService.add(exception.toString());
    }
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // this ensures that database I/O will be run on a background isolate,
    // making the operations on the database asynchronous
    return NativeDatabase.createInBackground(file);
  });
}

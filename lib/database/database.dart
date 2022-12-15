// To open the database, add these imports to the existing file defining the
// database class. They are used to open the database.
import 'dart:io';

import 'package:drift/native.dart';
import 'package:drift/drift.dart';
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
class PaymentDatabase extends _$PaymentDatabase {
  // we tell the database where to store the data with this constructor
  PaymentDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  @override
  int get schemaVersion => 3;

  Future<List<Payments>> read() async {
    return select(payment).get();
  }

  void add(Payments paymentToAdd) {
    into(payment).insert(paymentToAdd);
  }

  void remove(int idToRemove) {
    delete(payment).where((element) => element.id.equals(idToRemove));
  }

  void updateElement(Payments paymentToUpdate) {
    update(payment).replace(paymentToUpdate);
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

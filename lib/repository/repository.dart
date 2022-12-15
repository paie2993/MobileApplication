import 'package:observer/observer.dart';
import 'dart:developer' as developer;
import '../database/database.dart';

class Repository with Observable {
  final PaymentDatabase database;

  List<Payments> list = <Payments>[];

  Repository(this.database) {
    _fetchPayments();
  }

  void _fetchPayments() {
    var future = database.read();

    future.then((value) {
      list = value;
      developer.log('Fetched from database: $value',
          name: 'Repository:_fetchPayments');
      notifyObservers(list); // when reading completes, notify observers
    });
  }

  List<Payments> read() {
    return list;
  }

  int lastId() {
    var id = 0;
    for (var item in list) {
      if (item.id > id) {
        id = item.id;
      }
    }

    developer.log('Returning last id from repository: $id', name: 'Repository');
    return id;
  }

  Payments? getById(int id) {
    for (var element in list) {
      if (element.id == id) {
        return element;
      }
    }
    return null;
  }

  Future<void> add(Payments payment) async {
    // add to database
    await database.add(payment);

    // synchronize local list with database
    _fetchPayments();
  }

  Future<void> remove(int idToRemove) async {
    // remove from the database
    await database.remove(idToRemove);

    // now synchronize local list with database, to ensure consistency
    _fetchPayments();
  }

  Future<void> update(Payments payment) async {
    // modify in database
    await database.updateElement(payment);

    _fetchPayments();
  }
}

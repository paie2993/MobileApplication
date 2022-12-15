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
      developer.log('Fetched from database: $value', name: 'Repository');
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

  void add(Payments payment) {
    // add to local list
    list.add(payment);

    // add to database
    database.add(payment);

    developer.log('Added payment: $payment', name: 'Repository');
    notifyObservers(list);
  }

  void remove(int idToRemove) {
    // remove from the local list
    _removeFromList(idToRemove);

    // remove from the database
    database.remove(idToRemove);

    notifyObservers(list);
  }

  void _removeFromList(int idToRemove) {
    for (var i = 0; i < list.length; i++) {
      var current = list[i];
      if (current.id == idToRemove) {
        list.removeAt(i);
        break;
      }
    }
  }

  void update(Payments payment) {
    // modify in local list
    _updateInList(payment);

    // modify in database
    database.updateElement(payment);

    notifyObservers(list);
  }

  void _updateInList(Payments payment) {
    for (var i = 0; i < list.length; i++) {
      var current = list[i];
      if (current.id == payment.id) {
        list[i] = payment;
        break;
      }
    }
  }
}

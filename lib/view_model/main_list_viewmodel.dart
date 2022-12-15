import 'package:observer/observer.dart';
import 'dart:developer' as developer;
import '../database/database.dart';
import '../repository/repository.dart';

class MainListViewModel with Observable, Observer {
  final Repository repository;

  List<Payments> list = <Payments>[];

  // related to singleton implementation ...
  MainListViewModel(this.repository) {
    repository.addObserver(this);
    list = repository.read();
  }

  static MainListViewModel? _instance;

  static void initialize(Repository repository) =>
      _instance ??= MainListViewModel(repository);

  static MainListViewModel get() {
    if (_instance == null) {
      throw Exception("Instance of MainListViewModel not initialized");
    }
    return _instance!;
  }

  // ... until here

  List<Payments> read() {
    return list;
  }

  void add(Payments payment) {
    repository.add(payment);
  }

  void remove(int idToRemove) {
    repository.remove(idToRemove);
  }

  // this is for observing the changes in the repository
  // 1. receive changes from repo
  // 2. propagate changes to observers
  @override
  void update(Observable observable, Object arg) {
    list = arg as List<Payments>;
    developer.log('Received update from observable: $list', name: 'MainListViewModel:update');
    notifyObservers(list);
  }
}

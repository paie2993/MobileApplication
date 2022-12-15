// import 'main_list_view.dart';
// import 'main_list_viewmodel.dart.dart';
// import 'model.dart';
//
// class Repository {
//   static List<Payment> list = [];
//
//   static List<ListState> subscribers = [];
//
//   static subscribe(ListState newSub) => subscribers.add(newSub);
//
//   static int? indexOfPaymentToUpdate;
//
//   static Payment get(int index) => list[index];
//
//   static void add(Payment payment) {
//     list.add(payment);
//     notify();
//   }
//
//   static void remove(int index) {
//     list.removeAt(index);
//     notify();
//   }
//
//   static void update(int index, Payment payment) {
//     list.removeAt(index);
//     list.insert(index, payment);
//     notify();
//   }
//
//   static int? getToUpdate() => indexOfPaymentToUpdate;
//
//   static void setToUpdate(int index) => indexOfPaymentToUpdate = index;
//
//   static void resetToUpdate() => indexOfPaymentToUpdate = null;
//
//   static void notify() {
//     for (ListState sub in subscribers) {
//       sub.update();
//     }
//   }
// }

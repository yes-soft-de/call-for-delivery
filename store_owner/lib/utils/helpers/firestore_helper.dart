import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class FireStoreHelper {
  Stream? onInsertChangeWatcher() {
    try {
      return FirebaseFirestore.instance
          .collection('c4d_actions')
          .doc('new_action')
          .collection('action_history')
          .snapshots();
    } catch (e) {
      return null;
    }
  }

  Future<void> insertWatcher() async {
    try {
      await FirebaseFirestore.instance
          .collection('c4d_actions')
          .doc('new_action')
          .collection('action_history')
          .add({'date': DateTime.now().toUtc().toIso8601String()}).timeout(
              Duration(seconds: 30));
    } catch (e) {
      return;
    }
  }

  Future<void> insertWatcherOrder(int orderId) async {
    try {
      FirebaseFirestore.instance
          .collection('order_state')
          .doc(orderId.toString())
          .collection('order_history')
          .add({'date': DateTime.now().toLocal().toIso8601String()});
    } catch (e) {
      return;
    }
  }
}

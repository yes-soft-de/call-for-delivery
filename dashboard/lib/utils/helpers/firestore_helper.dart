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
          .add({'date': DateTime.now().toUtc().toIso8601String()});
      print('----------------------------------------------inserted');
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  Future<void> deleteWatcher() async {
    try {
      DateTime dateTime = DateTime.now();
      if (dateTime.hour >= 21) {
        var data = await FirebaseFirestore.instance
            .collection('c4d_actions')
            .doc('new_action')
            .get();
        if ((data.data()?.length ?? 0) >= 100) {
          await FirebaseFirestore.instance
              .collection('c4d_actions')
              .doc('new_action')
              .delete();
          print('----------------------------------------------deleted');
        }
      }
    } catch (e) {
      print(e.toString());
      return;
    }
  }
}

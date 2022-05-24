import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@injectable
class FireStoreHelper {
  Stream? onInsertChangeWatcher() {
    try {
      print(
          'Wathcer is On <-------------------------------------------------->');
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
              const Duration(seconds: 10));
      log('inserted ------------------------------------------------!');
    } catch (e) {
      log(e.toString());
      return;
    }
  }
}

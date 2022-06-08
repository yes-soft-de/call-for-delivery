import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:isolate_handler/isolate_handler.dart';

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

  Future<void> backgroundThread(String message) async {
    if (Platform.isAndroid) {
      final isolates = IsolateHandler();
      try {
        isolates.spawn(
          entryPoint,
          onReceive: (message) async {
            await Firebase.initializeApp();
            await FireStoreHelper().insertWatcher();
            isolates.kill('FireStoreInserter');
          },
          onInitialized: () {
            isolates.send(message, to: 'FireStoreInserter');
          },
          name: 'FireStoreInserter',
        );
      } catch (e) {
        log(e.toString());
      }
    } else {
      FireStoreHelper().insertWatcher().ignore();
    }
  }
}

void entryPoint(Map<String, dynamic> context) async {
  // Calling initialize from the entry point with the context is
  // required if communication is desired. It returns a messenger which
  // allows listening and sending information to the main isolate.

  final messenger = HandledIsolate.initialize(context);
  // Triggered every time data is received from the main isolate.
  messenger.listen((message) async {
    // Add one to the count and send the new value back to the main
    // isolate.
    messenger.send(message);
  });
}

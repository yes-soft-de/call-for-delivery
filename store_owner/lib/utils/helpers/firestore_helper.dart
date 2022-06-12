import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:firebase_database/firebase_database.dart';

@injectable
class FireStoreHelper {
  Stream? onInsertChangeWatcher() {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref('c4d_actions');
      return ref.onValue;
    } catch (e) {
      return null;
    }
  }

  Future<void> insertWatcher() async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref('c4d_actions');
      ref.set({'action_history': DateTime.now().toUtc().toIso8601String()});
      log('inserted -----------------------------------------------------------!');
      return;
    } catch (e) {
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

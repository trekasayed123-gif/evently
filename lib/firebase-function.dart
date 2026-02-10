import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunction {
 static CollectionReference<TaskModel> getCollection() {
    return FirebaseFirestore.instance
        .collection("tasks")
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, options) {
            return TaskModel.fromJson(snapshot.data()!);
          },
          toFirestore: (value, options) => value.toJson(),
        );

  }
    static Future<void> createTask(TaskModel taskModel){
    var collection=getCollection();
   var doc= collection.doc();
   taskModel.id=doc.id;
  return doc.set(taskModel);


  }


  static Future<void> createUser(
    String emailAddress,
    String password,
    String name,
    VoidCallback onSuccess,
    Function(String) onError,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

      await credential.user!.updateDisplayName(name);
      await credential.user!.sendEmailVerification();

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? "Auth error");
    } catch (e) {
      onError("Something went wrong");
    }
  }

  static Future<void> signUser(
    String emailAddress,
    String password,
    VoidCallback onSuccess,
    Function(String) onError,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      await credential.user!.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        onSuccess();
      } else {
        onError("Please verify your email first");
      }
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? "Login failed");
    }
  }
}

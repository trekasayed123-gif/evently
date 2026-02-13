import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/task_model.dart';
import 'package:evently/model/user_model.dart';
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

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("User")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) {
            return UserModel.fromJson(snapshot.data()!);
          },
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static creatUserDB(UserModel user) {
    var collection = getUserCollection();
    var doc = collection.doc(user.id);
    return doc.set(user);
  }

  static Future<void> deleteTask(TaskModel taskModel) {
    var collection = getCollection();
    return collection.doc(taskModel.id).delete();
  }

  static Stream<QuerySnapshot<TaskModel>> getFavoriteTasks() {
    var uid = FirebaseAuth.instance.currentUser!.uid;

    return getCollection()
        .where("userId", isEqualTo: uid)
        .where("isFavorite", isEqualTo: true)
        .snapshots();
  }

  static Future<void> toggleFavorite(String id, bool value) {
    return getCollection().doc(id).update({"isFavorite": value});
  }

  static Future<void> updateTask(TaskModel taskModel) {
    var collection = getCollection();
    return collection.doc(taskModel.id).update(taskModel.toJson());
  }

  static Stream<QuerySnapshot<TaskModel>> getStreamsTasks() {
    var uid = FirebaseAuth.instance.currentUser!.uid;

    return getCollection().where("userId", isEqualTo: uid).snapshots();
  }

  static Future<QuerySnapshot<TaskModel>> getTasks() {
    var collection = getCollection();
    return collection.get();
  }

  static Future<void> createTask(TaskModel taskModel) {
    var collection = getCollection();
    var doc = collection.doc();
    taskModel.id = doc.id;
    return doc.set(taskModel);
  }
static signOut() async {
  await FirebaseAuth.instance.signOut();
}

  static Future<UserModel?> readUser() async {
    var collection = getUserCollection();
    var userDoc = await collection.doc(FirebaseAuth.instance.currentUser!.uid);
    return userDoc.get().then((value) => value.data());
  }

  static Future<void> createUser(
    String emailAddress,
    String password,
    String name,
    VoidCallback onSuccess,

    Function(String) onError,
  ) async {
    try {
      onSuccess();
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      creatUserDB(
        UserModel(
          name: name,
          email: emailAddress,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: credential.user!.uid,
        ),
      );

      await credential.user!.updateDisplayName(name);
      //await credential.user!.sendEmailVerification();

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
      Function onLoading,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      await credential.user!.reload();
      final user = FirebaseAuth.instance.currentUser;
      onSuccess();
      // if (user != null && user.emailVerified) {
      //   onSuccess();
      // } else {
      //   onError("Please verify your email first");
      // }
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? "Login failed");
    }
  }
}

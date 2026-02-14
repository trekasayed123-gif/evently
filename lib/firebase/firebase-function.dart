import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/task_model.dart';
import 'package:evently/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseFunction {
  static Future<void> signInWithGoogle({
    required Function(User) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      // 1️⃣ Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        onError("Google sign-in cancelled");
        return;
      }

      // 2️⃣ Get Google auth details
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // 3️⃣ Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4️⃣ Sign in to Firebase
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        onSuccess(user);
      } else {
        onError("Failed to sign in with Google");
      }
    } catch (e) {
      onError(e.toString());
    }
  }

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

  static Future<void> creatUserDB(UserModel user) {
    var collection = getUserCollection();
    var doc = collection.doc(user.id);
    return doc.set(user);
  }

  static Future<UserModel?> readUser() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    var collection = getUserCollection();
    var userDoc = collection.doc(user.uid);
    var snapshot = await userDoc.get();
    return snapshot.data();
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

      await creatUserDB(
        UserModel(
          name: name,
          email: emailAddress,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: credential.user!.uid,
        ),
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
      VoidCallback onLoading,
      ) async {
    try {
      onLoading();

      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }



  static Future<void> createTask(TaskModel taskModel) {
    var collection = getCollection();
    var doc = collection.doc();
    taskModel.id = doc.id;
    return doc.set(taskModel);
  }

  static Future<void> deleteTask(TaskModel taskModel) {
    var collection = getCollection();
    return collection.doc(taskModel.id).delete();
  }

  static Future<void> updateTask(TaskModel taskModel) {
    var collection = getCollection();
    return collection.doc(taskModel.id).update(taskModel.toJson());
  }

  static Future<void> toggleFavorite(String id, bool value) {
    return getCollection().doc(id).update({"isFavorite": value});
  }

  static Stream<QuerySnapshot<TaskModel>> getStreamsTasks() {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return getCollection()
        .where("userId", isEqualTo: user.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot<TaskModel>> getFavoriteTasks() {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return getCollection()
        .where("userId", isEqualTo: user.uid)
        .where("isFavorite", isEqualTo: true)
        .snapshots();
  }

  static Future<QuerySnapshot<TaskModel>> getTasks() {
    var collection = getCollection();
    return collection.get();
  }
}

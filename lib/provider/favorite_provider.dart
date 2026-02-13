import 'package:flutter/material.dart';
import '../firebase/firebase-function.dart';
import '../model/task_model.dart';

class FavoriteProvider extends ChangeNotifier {

  List<TaskModel> favoriteTasks = [];
  bool isLoading = false;
  String errorMessage = "";


  void getFavoriteTasks() {
    isLoading = true;
    notifyListeners();

    FirebaseFunction.getFavoriteTasks().listen((snapshot) {
      favoriteTasks =
          snapshot.docs.map((e) => e.data()).toList();

      isLoading = false;
      notifyListeners();
    });
  }
}

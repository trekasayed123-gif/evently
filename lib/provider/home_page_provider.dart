import 'package:evently/firebase/firebase-function.dart';
import 'package:flutter/widgets.dart';
import '../model/task_model.dart';

class HomePageProvider extends ChangeNotifier {

  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];

  final List<String> categories = [
    "All",
    "Sport",
    "Book Club",
    "Exhibition",
    "Meeting",
    "Birthday",
  ];

  String errorMessage = "";
  bool isLoading = false;
  int selectedCategoryIndex = 0;
  void getTasks() {
    isLoading = true;
    notifyListeners();

    FirebaseFunction.getStreamsTasks().listen((snapshot) {

      allTasks = snapshot.docs.map((e) => e.data()).toList();
      if (categories[selectedCategoryIndex] == "All") {
        filteredTasks = allTasks;
      } else {
        filteredTasks = allTasks
            .where((task) =>
        task.category == categories[selectedCategoryIndex])
            .toList();
      }

      isLoading = false;
      notifyListeners();

    }, onError: (error) {
      errorMessage = error.toString();
      isLoading = false;
      notifyListeners();
    });
  }
  void changeCategory(int index) {
    selectedCategoryIndex = index;

    if (categories[index] == "All") {
      filteredTasks = allTasks;
    } else {
      filteredTasks = allTasks
          .where((task) => task.category == categories[index])
          .toList();
    }

    notifyListeners();
  }
}

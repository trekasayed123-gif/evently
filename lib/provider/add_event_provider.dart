import 'package:evently/model/task_model.dart';
import 'package:flutter/cupertino.dart';

import '../firebase/firebase-function.dart';

class AddEventProvider extends ChangeNotifier {
  int selectedCategoryIndex = 0;
DateTime date=DateTime.now();
changeDate(DateTime newDate){
  date=newDate;
  notifyListeners();
}
  void changeCategory(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }
  addEvents(TaskModel taskModel) async{
 await  FirebaseFunction.createTask(taskModel);
notifyListeners();

  }
}

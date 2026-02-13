import 'package:evently/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../firebase/firebase-function.dart';

class AuthProvider extends ChangeNotifier{
  User ?firebaseUser ;
  UserModel ?userModel;
  AuthProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }
    initUser()async{

      userModel = await FirebaseFunction.readUser();
      notifyListeners();
    }


}
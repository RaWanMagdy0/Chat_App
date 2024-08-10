import 'package:chattapp/database/database_utils.dart';
import 'package:chattapp/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'Login_navigator.dart';

class LoginViewModel extends ChangeNotifier {
  late LoginNavigator navigator;
  void loginFirebaseAuth(String email, String password) async {
    try {
      //showLoading
      navigator.showLoading();
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      //hideLoading
      navigator.hideLoading();
      //show message
      navigator.showMessage('Login successfully');
      //retrieve data
      var userObject = await DatabaseUtils.getUser(result.user?.uid ?? '');
      if (userObject == null) {
        navigator.hideLoading();
        navigator.showMessage("Register failed please try again");
      } else {
        navigator.navigateToHme(userObject);
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.userNotFound) {
        //hide loading
        navigator.hideLoading();
        //show message
        navigator.showMessage("No user found for that email.");
        print('No user found for that email.');
      } else if (e.code == FirebaseErrors.wrongPassword) {
        //hide loading
        navigator.hideLoading();
        //show message
        navigator.showMessage("Wrong password provided for that user.");
        print('Wrong password provided for that user.');
      }
    }
  }
}

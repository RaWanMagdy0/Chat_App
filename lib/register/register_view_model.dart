import 'package:chattapp/database/database_utils.dart';
import 'package:chattapp/model/my_user.dart';
import 'package:chattapp/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_errors.dart';

class RegisterViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;

  void registerFirebaseauth(
    String email,
    String password,
    String firstName,
    String lastName,
    String userName
  ) async {
    try {
      navigator.showLoading();
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //save data
      var user = MyUser(
          email: email,
          firstName: firstName,
          id: result.user?.uid ??'',
          lastName: lastName,
          userName: userName);
     var dataUser=await DatabaseUtils.registerUser(user);
      navigator.hideLoading();
      navigator.showMessage('Register Successfully');
      navigator.navigateToHme(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.weakPassword) {
        navigator.hideLoading();
        navigator.showMessage('this password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == FirebaseErrors.emailAlreadyInUse) {
        navigator.hideLoading();
        navigator.showMessage('The account already exists for that email.');

        print('The account already exists for that email.');
      }
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage('Some');
      print(e);
    }
  }
}

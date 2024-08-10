import 'package:chattapp/model/my_user.dart';

abstract class LoginNavigator{
  void showLoading();
  void hideLoading();
  void showMessage(String message);
  void navigateToHme(MyUser user);
}
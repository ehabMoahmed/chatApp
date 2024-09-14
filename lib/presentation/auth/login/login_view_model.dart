import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
 import '../../../core/resuable_component/dialog.dart';
import '../../../core/utils/routes_manager.dart';

//b3ml abstract class w akhle al viewmodel 3ndoo reference meno w b3d kda akhle al view implement al abstract w ab3t al widget le al viewmodel btre2a indrect
abstract class LoginNavigator{
  void showLoading();
  void hideLoadingDialoge();
  void showMessage(String message);
}
class LoginViewModel extends ChangeNotifier{
  //3ndo obj mn no3 navigator
  LoginNavigator? navigator;
var auth =FirebaseAuth.instance;

  void login(BuildContext context, String emailController,String passwordController)async{
    try {
      navigator?.showLoading();
      final credential = await auth.signInWithEmailAndPassword(
          email: emailController ,
          password: passwordController
      );
      navigator?.hideLoadingDialoge();
      navigator?.showMessage(credential.user?.uid??"");
      navigator?.hideLoadingDialoge();
      Navigator.pushReplacementNamed(context, RoutesManager.home);

    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialoge();
      if (e.code == 'user-not-found') {
        navigator?.showMessage("No user found for that email ");
      } else if (e.code == 'wrong-password') {
        navigator?.showMessage("'Wrong password provided for that user");
      }
    }
  }

}
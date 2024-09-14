import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/resuable_component/dialog.dart';
import '../../../core/utils/routes_manager.dart';

abstract class RegisterNavigator {
  void showLoading();
  void hideLoadingDialoge();
  void showMessage(String message);
}

class RegisterViewModel extends ChangeNotifier {
  RegisterNavigator? navigator;
var auth=FirebaseAuth.instance;

  CreateUser(String emailController, String passwordController,
      BuildContext context) async {
    navigator?.showLoading();

    try {
      final credential =
          await auth.createUserWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );
      navigator?.hideLoadingDialoge();

      // DialogUtils.hideLoading(context);

      auth.currentUser!.sendEmailVerification();
      Navigator.pushReplacementNamed(context, RoutesManager.login);
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialoge();

       if (e.code == 'weak-password') {
        print('The password provided is too weak.');
         navigator?.showMessage("The password provided is too weak. ");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        navigator?.showMessage("The account already exists for that email.");

      }
    } catch (e) {
      navigator?.hideLoadingDialoge();

      navigator?.showMessage("something went wrong , please try again later.");

    }
  }
}

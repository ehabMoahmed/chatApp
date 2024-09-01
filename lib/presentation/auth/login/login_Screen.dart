import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/core/resuable_component/custom_formfield.dart';
import 'package:chat_app/core/utils/routes_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/constant.dart';
import '../../../core/resuable_component/dialog.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  GlobalKey<FormState> formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(

            image:AssetImage( "assets/images/background.png"),fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
             title: Text("Login",style: TextStyle(color: Colors.white,fontSize: 24),),
            centerTitle: true,
          ),
          body: Padding(
            padding:   EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 180,),
                     SizedBox(height: 15,),
                    CustomFormFied(text: "Email",  keyboardType: TextInputType.emailAddress,controller: emailController,
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return 'this feild cant be empty';
                        }
                        //de 3obara 3n function btbd2 tt2kd en al value mktob bnfs seght al variable da btrg3 true or false
                        if(!RegExp(Constant.emailRegex).hasMatch(value)) {
                          return "Enter valid Email";
                        }
                        return null;
                      },),
                    SizedBox(height: 15,),
                    CustomFormFied(text: "password", keyboardType: TextInputType.visiblePassword,controller: passwordController,
                        validator: (value){
                          if(value==null||value.isEmpty){
                            return 'this feild cant be empty';
                          }
                          if(value.length<8){
                            return'Password should be at least 8 character';
                          }
                          return null;
                        }),
                    SizedBox(height: 15,),
                     SizedBox(height: 40,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                        onPressed:  () async {
                          if(formkey.currentState!.validate()){
                            DialogUtils.showLoadingDialog(context);
                            try {
                              final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                              DialogUtils.hideLoading(context);

                              if(credential.user!.emailVerified){
                                 Navigator.pushNamedAndRemoveUntil(context, RoutesManager.home,(route) => false,);
                              }else{
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: 'Please go to your email inbox and click on the verification link to activate your account',
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              DialogUtils.hideLoading(context);

                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: 'No user found for that email',

                                ).show();
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc: 'Wrong password provided for that user',

                                ).show();
                              }
                            }
                          }else{
                            print("Not Valid");
                          }
                        }, child: Container(
                        width: double.infinity,
                        child: Center(child: Text("Login",style: TextStyle(color: Colors.white,),))) ),
                    InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesManager.register );
                        },
                        child: Text("Dont have acc? >Register")),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }




createUser()async{
  if(formkey.currentState?.validate()==false){
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      return ;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "No user found for that email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Wrong password provided for that user",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print('Wrong password provided for that user.');
      }
    }
  }
}

}
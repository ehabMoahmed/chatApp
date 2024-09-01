import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/core/resuable_component/custom_formfield.dart';
import 'package:chat_app/core/utils/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/constant.dart';
import '../../../core/resuable_component/dialog.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController NameController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController confirmPasswordController=TextEditingController();

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
          leading: Icon(Icons.arrow_back,color: Colors.white,),
          title: Text("Create Account",style: TextStyle(color: Colors.white,fontSize: 24),),
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
                   CustomFormFied(text: "Name",  keyboardType: TextInputType.text,controller: NameController,validator: (value){
                     if(value==null||value.trim().isEmpty){
                       return "please enter your name";
                     }
                     return null;
                   },),
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
                   CustomFormFied(text: "confirm Password", keyboardType: TextInputType.visiblePassword,controller: confirmPasswordController,
                       validator: (value){
                     if(value!=passwordController.text){
                       return "not match";
                     }
                     return null;
                       }),
                   SizedBox(height: 40,),
                   ElevatedButton(
                       style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                       onPressed: () async {
                         if (formkey.currentState!.validate()) {
                           DialogUtils.showLoadingDialog(context);

                           try {
                             final credential = await FirebaseAuth.instance
                                 .createUserWithEmailAndPassword(
                               email: emailController.text,
                               password: passwordController.text,
                             );
                             DialogUtils.hideLoading(context);

                             FirebaseAuth.instance.currentUser!
                                 .sendEmailVerification();
                             Navigator.pushReplacementNamed(
                                 context, RoutesManager.login);
                           } on FirebaseAuthException catch (e) {
                             DialogUtils.hideLoading(context);
                             if (e.code == 'weak-password') {
                               print('The password provided is too weak.');
                               AwesomeDialog(
                                 context: context,
                                 dialogType: DialogType.error,
                                 animType: AnimType.rightSlide,
                                 title: 'Error',
                                 desc: 'The password provided is too weak.',
                               ).show();
                             } else if (e.code == 'email-already-in-use') {
                               print('The account already exists for that email.');
                               AwesomeDialog(
                                 context: context,
                                 dialogType: DialogType.error,
                                 animType: AnimType.rightSlide,
                                 title: 'Error',
                                 desc:
                                 'The account already exists for that email.',
                               ).show();
                             }
                           } catch (e) {
                             print(e);
                           }
                         } else {
                           print("No valid");
                         }
                       }, child: Container(
                       width: double.infinity,
                       child: Center(child: Text("Register",style: TextStyle(color: Colors.white,),))) ),
                   InkWell(
                       onTap: (){
                         Navigator.pushNamed(context, RoutesManager.login );
                       },
                       child: Text("you have acc? LOGIN")),
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

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "The password provided is too weak",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print('The account already exists for that email.');
      }
      return;
    } catch (e) {
      print(e);
    }
  }
}

}

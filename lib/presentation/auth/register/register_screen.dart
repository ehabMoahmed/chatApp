import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/core/resuable_component/custom_formfield.dart';
import 'package:chat_app/core/utils/routes_manager.dart';
import 'package:chat_app/presentation/auth/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../core/constant.dart';
import '../../../core/resuable_component/dialog.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigator{
  TextEditingController NameController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController confirmPasswordController=TextEditingController();

  GlobalKey<FormState> formkey=GlobalKey<FormState>();

  late RegisterViewModel viewModel;
  @override
  void initState() {
    viewModel=RegisterViewModel();
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterViewModel(),
      child: Container(
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

                             createUser();




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
      ),
    );
  }

void createUser()async{
  if(formkey.currentState?.validate()==false){
    return;
  }


viewModel.CreateUser(emailController.text, passwordController.text, context);


  }


  @override
  void showLoading() {
    DialogUtils.showLoadingDialog(context);
  }

  @override
  void hideLoadingDialoge() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showMessage(String message) {
    DialogUtils.showMessage(context: context, message: message,postivePress: () {},postiveText: "ok",
    );
  }

}

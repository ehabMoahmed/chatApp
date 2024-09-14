import 'dart:async';

 import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/core/resuable_component/custom_formfield.dart';
import 'package:chat_app/core/utils/routes_manager.dart';
 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constant.dart';
import '../../../core/resuable_component/dialog.dart';
import 'login_view_model.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator
{

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  GlobalKey<FormState> formkey=GlobalKey<FormState>();

  late LoginViewModel viewModel; //b3ml obj mn al viewModel

  @override
  void initState() {
    //msh hytnde 3leha gher law ast5dmt viewmode
    viewModel=LoginViewModel();
    viewModel.navigator=this; // kda b3t obj mn al widget ba3te le al viewmodel btre2a indirect l2nha law direct al viewmodel hyt3md 3ala view
  }
  @override
  Widget build(BuildContext context) {
    //initialize
    return ChangeNotifierProvider(
      create: (context)=>viewModel  ,
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
                          onPressed:  () {

                            createUser();
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
      ),
    );
  }




void createUser()async{

    if(formkey.currentState!.validate()){
      //yobaa al logic kolo 3nd al viewModel
      viewModel.login(context, emailController.text, passwordController.text);
    }else{
      print("Not Valid");
    }

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
    DialogUtils.showMessage(context: context, message: message);
  }

}
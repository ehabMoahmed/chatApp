import 'package:flutter/material.dart';

class CustomFormFied extends StatefulWidget {
  String text;
  bool isPass;
  bool isVisible;
  TextInputType keyboardType;
  String? Function(String?)? validator;
  TextEditingController? controller;
    CustomFormFied({super.key,required this.text,  this.isVisible=false,this.isPass=false,  this.validator,  this.controller,required this.keyboardType});

  @override
  State<CustomFormFied> createState() => _CustomFormFiedState();
}

class _CustomFormFiedState extends State<CustomFormFied> {
  @override
  Widget build(BuildContext context) {
    return   TextFormField(
     validator: widget.validator,
      obscureText: widget.isVisible,
      controller: widget.controller,
      keyboardType:widget.keyboardType ,
      decoration: InputDecoration(
        suffixIcon:widget.isPass==true?InkWell(
            onTap: (){
              widget.isVisible=!widget.isVisible;
              setState(() {

              });
            },
            child: Icon(widget.isVisible?Icons.visibility:Icons.visibility_off)
        ):null,
        hintText: widget.text,
        hintStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
        enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(20),borderSide: BorderSide(width: 1),
        ),
        focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(20),borderSide: BorderSide(width: 1),
        ),
        disabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(20),borderSide: BorderSide(width: 1),
        ),
      ),
    );
  }
}

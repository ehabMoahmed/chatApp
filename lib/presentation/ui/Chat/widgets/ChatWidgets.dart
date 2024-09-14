
import 'package:chat_app/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

import '../../../../data-layer/model/messages_model/message.dart';

class ChatWidget extends StatelessWidget {
   MessageModel message;
   ChatWidget(this.message);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only( top: 15,bottom: 15),
      decoration: BoxDecoration(

        color: ColorManager.primaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)
        ),
      ),
      child: Padding(
        padding:   EdgeInsets.all(8.0),
        child: Text(message.text,style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
